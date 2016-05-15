$ScriptBlock = {
        <#
        .SYNOPSIS
        Auto-complete the -AutomationAccountName parameter value for Azure Resource Manager (ARM) PowerShell cmdlets.

        .NOTES
        Created by Trevor Sullivan <trevor@trevorsullivan.net>
        http://trevorsullivan.net
        #>
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        try {
            $ObjectList = Get-AzureRmAutomationAccount -ErrorAction Stop -WarningAction Ignore;
        } catch {
            Write-Host -Object ('Error occurred retrieving Automation Accounts: {0}' -f $PSItem.Exception.Message);
        }
        $ItemList = $ObjectList | Where-Object { $PSItem.AutomationAccountName -match $wordToComplete } | ForEach-Object {
            $CompletionText = '{0} -ResourceGroupName {1}' -f $PSItem.AutomationAccountName, $PSItem.ResourceGroupName;
            $ToolTip = 'Automation Account {0} in {1} region, in {2} Resource Group.' -f $PSItem.AutomationAccountName, $PSItem.Location, $PSItem.ResourceGroupName;
            $ListItemText = '{0} ({1})' -f $PSItem.AutomationAccountName, $PSItem.Location;
            $CompletionResultType = [System.Management.Automation.CompletionResultType]::ParameterValue;

            New-Object -TypeName System.Management.Automation.CompletionResult -ArgumentList @($CompletionText, $ListItemText, $CompletionResultType, $ToolTip);
        }

        return $ItemList
    }

$ArgumentCompleter = @{
        CommandName = @(
            'Export-AzureRmAutomationDscConfiguration',
            'Export-AzureRmAutomationDscNodeReportContent',
            'Export-AzureRmAutomationRunbook',
            'Get-AzureRmAutomationAccount',
            'Get-AzureRmAutomationCertificate',
            'Get-AzureRmAutomationConnection',
            'Get-AzureRmAutomationCredential',
            'Get-AzureRmAutomationDscCompilationJob',
            'Get-AzureRmAutomationDscCompilationJobOutput',
            'Get-AzureRmAutomationDscConfiguration',
            'Get-AzureRmAutomationDscNode',
            'Get-AzureRmAutomationDscNodeConfiguration',
            'Get-AzureRmAutomationDscNodeReport',
            'Get-AzureRmAutomationDscOnboardingMetaconfig',
            'Get-AzureRmAutomationJob',
            'Get-AzureRmAutomationJobOutput',
            'Get-AzureRmAutomationJobOutputRecord',
            'Get-AzureRmAutomationModule',
            'Get-AzureRmAutomationRegistrationInfo',
            'Get-AzureRmAutomationRunbook',
            'Get-AzureRmAutomationSchedule',
            'Get-AzureRmAutomationScheduledRunbook',
            'Get-AzureRmAutomationVariable',
            'Get-AzureRmAutomationWebhook',
            'Import-AzureRmAutomationDscConfiguration',
            'Import-AzureRmAutomationDscNodeConfiguration',
            'Import-AzureRmAutomationRunbook',
            'New-AzureRmAutomationAccount',
            'New-AzureRmAutomationCertificate',
            'New-AzureRmAutomationConnection',
            'New-AzureRmAutomationCredential',
            'New-AzureRmAutomationKey',
            'New-AzureRmAutomationModule',
            'New-AzureRmAutomationRunbook',
            'New-AzureRmAutomationSchedule',
            'New-AzureRmAutomationVariable',
            'New-AzureRmAutomationWebhook',
            'Publish-AzureRmAutomationRunbook',
            'Register-AzureRmAutomationDscNode',
            'Register-AzureRmAutomationScheduledRunbook',
            'Remove-AzureRmAutomationAccount',
            'Remove-AzureRmAutomationCertificate',
            'Remove-AzureRmAutomationConnection',
            'Remove-AzureRmAutomationConnectionType',
            'Remove-AzureRmAutomationCredential',
            'Remove-AzureRmAutomationDscConfiguration',
            'Remove-AzureRmAutomationDscNodeConfiguration',
            'Remove-AzureRmAutomationModule',
            'Remove-AzureRmAutomationRunbook',
            'Remove-AzureRmAutomationSchedule',
            'Remove-AzureRmAutomationVariable',
            'Remove-AzureRmAutomationWebhook',
            'Resume-AzureRmAutomationJob',
            'Set-AzureRmAutomationAccount',
            'Set-AzureRmAutomationCertificate',
            'Set-AzureRmAutomationConnectionFieldValue',
            'Set-AzureRmAutomationCredential',
            'Set-AzureRmAutomationDscNode',
            'Set-AzureRmAutomationModule',
            'Set-AzureRmAutomationRunbook',
            'Set-AzureRmAutomationSchedule',
            'Set-AzureRmAutomationVariable',
            'Set-AzureRmAutomationWebhook',
            'Start-AzureRmAutomationDscCompilationJob',
            'Start-AzureRmAutomationRunbook',
            'Stop-AzureRmAutomationJob',
            'Suspend-AzureRmAutomationJob',
            'Unregister-AzureRmAutomationDscNode',
            'Unregister-AzureRmAutomationScheduledRunbook'
        );
        ParameterName = 'AutomationAccountName';
        ScriptBlock = $ScriptBlock;
}

Microsoft.PowerShell.Core\Register-ArgumentCompleter @ArgumentCompleter;

$ArgumentCompleter = @{
        CommandName = @(
            'Get-AzureRmAutomationAccount',
            'New-AzureRmAutomationAccount',
            'Remove-AzureRmAutomationAccount',
            'Set-AzureRmAutomationAccount'
        );
        ParameterName = 'Name';
        ScriptBlock = $ScriptBlock;
}

Microsoft.PowerShell.Core\Register-ArgumentCompleter @ArgumentCompleter;