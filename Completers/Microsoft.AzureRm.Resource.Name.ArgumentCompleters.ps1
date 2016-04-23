$ArgumentCompleter = @{
    CommandName = @(
        'Get-AzureRmResource'
        'Get-AzureRmResourceLock'
        'Get-AzureRmRoleAssignment'
        'Invoke-AzureRmResourceAction'
        'New-AzureRmResource'
        'New-AzureRmResourceLock'
        'New-AzureRmRoleAssignment'
        'Remove-AzureRmResource'
        'Remove-AzureRmResourceLock'
        'Remove-AzureRmRoleAssignment'
        'Set-AzureRmResource'
        'Set-AzureRmResourceLock'
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

        ### Attempt to read Azure virtual machine details from the cache
        $CacheKey = 'AzureRm_ResourceNameCache';
        $Cache = Get-CompletionPrivateData -Key $CacheKey;

        ### If there is a valid cache, then go ahead and return them immediately
        if (-not $wordToComplete -and $Cache -and (Get-Date) -gt $Cache.ExpirationTime) {
            return $Cache;
        }

        ### Create fresh completion results for Azure virtual machines
        $ItemList = Get-AzureRmResource | Where-Object { $PSItem.ResourceName -match $wordToComplete } | ForEach-Object {
            $CompletionResult = @{
                CompletionText = '{0} -ResourceType {1} -ResourceGroupName {2}' -f $PSItem.ResourceName, $PSItem.ResourceType, $PSItem.ResourceGroupName;
                ToolTip = 'Resource {0} of type {1} in Resource Group {2}' -f $PSItem.ResourceName, $PSItem.ResourceType, $PSItem.ResourceGroupName;
                ListItemText = '{0} ({1})' -f $PSItem.ResourceName, $PSItem.ResourceGroupName;
                CompletionResultType = [System.Management.Automation.CompletionResultType]::ParameterValue;
                NoQuotes = $true;
                }
            New-CompletionResult @CompletionResult;
        }
    
        ### Update the cache for Azure virtual machines
        Set-CompletionPrivateData -Key $CacheKey -Value $ItemList;

        ### Return the fresh completion results
        return $ItemList;
    }
}

Microsoft.PowerShell.Core\Register-ArgumentCompleter @ArgumentCompleter;