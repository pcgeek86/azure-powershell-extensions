$ArgumentCompleter = @{
        CommandName = @(
            'Get-WAPackSubscription', 
            'Remove-WAPackSubscription', 
            'Select-WAPackSubscription', 
            'Set-WAPackSubscription', 
            'Get-AzureSubscription', 
            'New-AzureSqlDatabaseServerContext', 
            'Remove-AzureSubscription', 
            'Select-AzureSubscription', 
            'Set-AzureSubscription'
            );
        ParameterName = 'SubscriptionName';
        #Description = 'Complete the -SubscriptionName parameter value for Azure cmdlets:  Select-AzureSubscription -SubscriptionName <TAB>';
        ScriptBlock = {
        <#
            .SYNOPSIS
            Auto-complete the -SubscriptionName parameter value for Azure PowerShell cmdlets.

            .NOTES
            Created by Trevor Sullivan <trevor@trevorsullivan.net>
            http://trevorsullivan.net
        #>
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        #Write-Verbose -Message ('Called Azure SubscriptionName completer at {0}' -f (Get-Date))

        ### Attempt to read Azure subscription details from the cache
        $CacheKey = 'AzureSubscription_SubscriptionNameCache'
        $SubscriptionNameCache = Get-CompletionPrivateData -Key $CacheKey

        ### If there is a valid cache for the Azure subscription names, then go ahead and return them immediately
        if ($SubscriptionNameCache) {
            return $SubscriptionNameCache
        }

        ### Create fresh completion results for Azure subscriptions
        $ItemList = Get-AzureSubscription | Where-Object { $PSItem.SubscriptionName -match ${wordToComplete} } | ForEach-Object {
            $CompletionResult = @{
                CompletionText = $PSItem.SubscriptionName
                ToolTip = 'Azure subscription "{0}" with ID {1}.' -f $PSItem.SubscriptionName, $PSItem.SubscriptionId
                ListItemText = '{0} ({1})' -f $PSItem.SubscriptionName, $PSItem.SubscriptionId
                CompletionResultType = [System.Management.Automation.CompletionResultType]::ParameterValue
                }
            New-CompletionResult @CompletionResult
        }
    
        ### Update the cache for Azure subscription names
        Set-CompletionPrivateData -Key $CacheKey -Value $ItemList

        ### Return the fresh completion results
        return $ItemList
    }
}

Microsoft.PowerShell.Core\Register-ArgumentCompleter @ArgumentCompleter;
