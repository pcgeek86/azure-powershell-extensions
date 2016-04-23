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

        ### Create fresh completion results for Azure subscriptions
        $ItemList = Get-AzureSubscription | Where-Object { $PSItem.SubscriptionName -match ${wordToComplete} } | ForEach-Object {
            $CompletionText = $PSItem.SubscriptionName
            $ToolTip = 'Azure subscription "{0}" with ID {1}.' -f $PSItem.SubscriptionName, $PSItem.SubscriptionId
            $ListItemText = '{0} ({1})' -f $PSItem.SubscriptionName, $PSItem.SubscriptionId
            $CompletionResultType = [System.Management.Automation.CompletionResultType]::ParameterValue

            New-Object -TypeName System.Management.Automation.CompletionResult -ArgumentList @($CompletionText, $ListItemText, $CompletionResultType, $ToolTip);
        }
    
        ### Return the fresh completion results
        return $ItemList
    }
}

Microsoft.PowerShell.Core\Register-ArgumentCompleter @ArgumentCompleter;
