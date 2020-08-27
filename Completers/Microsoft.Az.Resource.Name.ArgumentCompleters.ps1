$ArgumentCompleter = @{
    CommandName = @(
        'Get-AzResource'
        'Get-AzResourceLock'
        'Get-AzRoleAssignment'
        'Invoke-AzResourceAction'
        'New-AzResource'
        'New-AzResourceLock'
        'New-AzRoleAssignment'
        'Remove-AzResource'
        'Remove-AzResourceLock'
        'Remove-AzRoleAssignment'
        'Set-AzResource'
        'Set-AzResourceLock'
    );
    ParameterName = 'ResourceName';
    #Description = 'Complete the -ResourceName parameter value for Azure Resource Manager cmdlets: Get-AzureResource -ResourceName <TAB>';
    ScriptBlock = {
        <#
        .SYNOPSIS
        Auto-complete the -ResourceName parameter value for Azure Resource Manager (ARM) cmdlets.
    
        .NOTES
        Created by Trevor Sullivan <trevor@trevorsullivan.net>
        http://trevorsullivan.net
        http://twitter.com/pcgeek86
        #>
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        ### Create fresh completion results for Azure virtual machines
        $ItemList = Get-AzResource | Where-Object { $PSItem.ResourceName -match $wordToComplete } | ForEach-Object {
            $CompletionText = '{0} -ResourceType {1} -ResourceGroupName {2}' -f $PSItem.ResourceName, $PSItem.ResourceType, $PSItem.ResourceGroupName;
            $ToolTip = 'Resource {0} of type {1} in Resource Group {2}' -f $PSItem.ResourceName, $PSItem.ResourceType, $PSItem.ResourceGroupName;
            $ListItemText = '{0} ({1})' -f $PSItem.ResourceName, $PSItem.ResourceGroupName;
            $CompletionResultType = [System.Management.Automation.CompletionResultType]::ParameterValue;

            New-Object -TypeName System.Management.Automation.CompletionResult -ArgumentList @($CompletionText, $ListItemText, $CompletionResultType, $ToolTip);
        }
    
        ### Return the fresh completion results
        return $ItemList;
    }
}

Microsoft.PowerShell.Core\Register-ArgumentCompleter @ArgumentCompleter;