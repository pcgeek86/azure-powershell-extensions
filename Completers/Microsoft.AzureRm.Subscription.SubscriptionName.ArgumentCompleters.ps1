$ArgumentCompleter = @{
        ### (Get-Command -Module AzureRM* -ParameterName SubscriptionName -Type Cmdlet).Name.ForEach({ "'{0}'," -f $PSItem }) | Set-Clipboard;
        CommandName = @(
            'Add-AzureRmAccount',
            'Get-AzureRmSubscription',
            'Set-AzureRmContext'
            );
        ParameterName = 'SubscriptionName';
        ScriptBlock = {
        <#
            .SYNOPSIS
            Auto-complete the -SubscriptionName parameter value for Azure Resource Manager (ARM) PowerShell cmdlets.

            .NOTES
            Created by Trevor Sullivan <trevor@trevorsullivan.net>
            http://trevorsullivan.net
        #>
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        $ErrorActionPreference = 'Stop';

        try {
            $ItemList = Get-AzureRmSubscription | Where-Object { $PSItem.SubscriptionName -match $wordToComplete } | ForEach-Object {
                $CompletionText = $PSItem.SubscriptionName;
                $ToolTip = 'Azure subscription "{0}" with ID {1}.' -f $PSItem.SubscriptionName, $PSItem.SubscriptionId;
                $ListItemText = '{0} ({1})' -f $PSItem.SubscriptionName, $PSItem.SubscriptionId;
                $CompletionResultType = [System.Management.Automation.CompletionResultType]::ParameterValue;

                New-Object -TypeName System.Management.Automation.CompletionResult -ArgumentList @($CompletionText, $ListItemText, $CompletionResultType, $ToolTip);
            }
    
            return $ItemList
        } catch {
            $LogPath = '{0}\AzureExt.log' -f $env:TEMP;
            Add-Content -Path $LogPath -Value ('{0}: Exception occurred' -f $PSItem.Exception.Message);
        }
    }
}

Microsoft.PowerShell.Core\Register-ArgumentCompleter @ArgumentCompleter;
