$ScriptBlock = {
        <#
        .SYNOPSIS
        Auto-complete the -ProfileName parameter value for Azure Resource Manager (ARM) PowerShell cmdlets for Azure CDN.
    
        .NOTES
       
        Created by Trevor Sullivan <trevor@trevorsullivan.net>
        http://trevorsullivan.net
        #>
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        try {
            $CompletionList = Get-AzContainerGroup | Where-Object -FilterScript { $PSItem.Name -match $wordToComplete } | ForEach-Object {
                $CompletionText = '{0} -ResourceGroupName {1}' -f $PSItem.Name, $PSItem.ResourceGroupName;
                $ToolTip = 'Redis Cache "{0}" in "{1}" region, member of "{2}" Resource Group.' -f $PSItem.Name, $PSItem.Location, $PSItem.ResourceGroupName;
                $ListItemText = '{0} ({1}, {2})' -f $PSItem.Name, $PSItem.ResourceGroupName, $PSItem.Location;
                $CompletionResultType = [System.Management.Automation.CompletionResultType]::ParameterValue;

                New-Object -TypeName System.Management.Automation.CompletionResult -ArgumentList @($CompletionText, $ListItemText, $CompletionResultType, $ToolTip);
            }

            return $CompletionList;
        }
        catch {
            Write-Host -Message ('Error occurred calling argument completer: {0}' -f $PSItem.Exception.Message);
        }
    };

$ArgumentCompleterList = @(
    @{
    CommandName = @(
        'Remove-AzContainerGroup'
        'Get-AzContainerGroup'
    );
    ParameterName = 'Name';
    ScriptBlock = $ScriptBlock;
    };
)

foreach ($ArgumentCompleter in $ArgumentCompleterList) {
    Microsoft.PowerShell.Core\Register-ArgumentCompleter @ArgumentCompleter;
}

$ArgumentCompleterList = @(
    @{
    CommandName = @(
        'Get-AzContainerInstanceLog'
    );
    ParameterName = 'ContainerGroupName';
    ScriptBlock = $ScriptBlock;
    };
)

foreach ($ArgumentCompleter in $ArgumentCompleterList) {
    Microsoft.PowerShell.Core\Register-ArgumentCompleter @ArgumentCompleter;
}