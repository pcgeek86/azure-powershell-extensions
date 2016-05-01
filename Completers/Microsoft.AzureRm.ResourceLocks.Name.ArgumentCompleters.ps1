$ArgumentCompleter = @{
    CommandName = @(
        'Get-AzureRmResourceLock',
        'New-AzureRmResourceLock',
        'Remove-AzureRmResourceLock',
        'Set-AzureRmResourceLock'
    );
    ParameterName = 'LockName';
    ScriptBlock = {
        <#
        .SYNOPSIS
        Auto-complete the -LockName parameter value for Azure Resource Manager (ARM) cmdlets.
    
        .NOTES
        Created by Trevor Sullivan <trevor@trevorsullivan.net>
        http://trevorsullivan.net
        http://twitter.com/pcgeek86
        #>
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        ### Create fresh completion results for Azure virtual machines
        $ItemList = Get-AzureRmResourceLock | Where-Object { $PSItem.Name -match $wordToComplete } | ForEach-Object {
            $CompletionText = '{0} -ResourceGroupName {1}' -f $PSItem.Name, $PSItem.ResourceGroupName;
            $ToolTip = 'Lock named {0} applied to Resource Group {1}' -f $PSItem.ResourceName, $PSItem.ResourceGroupName;
            $ListItemText = '{0} ({1})' -f $PSItem.Name, $PSItem.ResourceGroupName;
            $CompletionResultType = [System.Management.Automation.CompletionResultType]::ParameterValue;

            New-Object -TypeName System.Management.Automation.CompletionResult -ArgumentList @($CompletionText, $ListItemText, $CompletionResultType, $ToolTip);
        }
    
        ### Return the completion results
        return $ItemList;
    }
}

Microsoft.PowerShell.Core\Register-ArgumentCompleter @ArgumentCompleter;