$ScriptBlock = {
        <#
        .SYNOPSIS
        Auto-complete the -Name parameter value for Azure Resource Manager (ARM) PowerShell cmdlets for Network Interfaces.
    
        .NOTES
       
        Created by Trevor Sullivan <trevor@trevorsullivan.net>
        http://trevorsullivan.net
        #>
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        try {
            $CompletionList = Get-AzNetworkInterface | Where-Object -FilterScript { $PSItem.Name -match $wordToComplete } | ForEach-Object {
                $CompletionText = '{0} -ResourceGroupName {1}' -f $PSItem.Name, $PSItem.ResourceGroupName;
                $ToolTip = 'Network Interface "{0}" in "{1}" region, member of "{2}" Resource Group.' -f $PSItem.Name, $PSItem.Location, $PSItem.ResourceGroup;
                $ListItemText = '{0}\{1} ({2})' -f $PSItem.ResourceGroupName, $PSItem.Name, $PSItem.Location;
                $CompletionResultType = [System.Management.Automation.CompletionResultType]::ParameterValue;

                [System.Management.Automation.CompletionResult]::new($CompletionText, $ListItemText, $CompletionResultType, $ToolTip);
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
        'Get-AzNetworkInterface'
        'New-AzNetworkInterface'
        'Remove-AzNetworkInterface'
        'Set-AzNetworkInterface'
    );
    ParameterName = 'Name';
    #Description = 'Complete the -Name parameter value for Azure Resource Manager (ARM) Network Interface cmdlets: Get-AzNetworkInterface -Name <TAB>';
    ScriptBlock = $ScriptBlock;
    };
)

foreach ($ArgumentCompleter in $ArgumentCompleterList) {
    Microsoft.PowerShell.Core\Register-ArgumentCompleter @ArgumentCompleter;
}