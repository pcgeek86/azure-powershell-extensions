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
            $ObjectList = Get-AzAutomationAccount -ErrorAction Stop -WarningAction Ignore;
        } catch {
            Write-Host -Object ('Error occurred retrieving Automation Accounts: {0}' -f $PSItem.Exception.Message);
        }
        $ItemList = $ObjectList | Where-Object { $PSItem.AutomationAccountName -match $wordToComplete } | ForEach-Object {
            $CompletionText = '{0} -ResourceGroupName {1}' -f $PSItem.AutomationAccountName, $PSItem.ResourceGroupName;
            $ToolTip = 'Automation Account {0} in {1} region, in {2} Resource Group.' -f $PSItem.AutomationAccountName, $PSItem.Location, $PSItem.ResourceGroupName;
            $ListItemText = '{0} ({1})' -f $PSItem.AutomationAccountName, $PSItem.Location;
            $CompletionResultType = [System.Management.Automation.CompletionResultType]::ParameterValue;

            [System.Management.Automation.CompletionResult]::new($CompletionText, $ListItemText, $CompletionResultType, $ToolTip);
        }

        return $ItemList
    }

$ArgumentCompleter = @{
        CommandName = @(
            'Export-AzAutomationDscConfiguration',
            'Export-AzAutomationDscNodeReportContent',
            'Export-AzAutomationRunbook',
            'Get-AzAutomationAccount',
            'Get-AzAutomationCertificate',
            'Get-AzAutomationConnection',
            'Get-AzAutomationCredential',
            'Get-AzAutomationDscCompilationJob',
            'Get-AzAutomationDscCompilationJobOutput',
            'Get-AzAutomationDscConfiguration',
            'Get-AzAutomationDscNode',
            'Get-AzAutomationDscNodeConfiguration',
            'Get-AzAutomationDscNodeReport',
            'Get-AzAutomationDscOnboardingMetaconfig',
            'Get-AzAutomationJob',
            'Get-AzAutomationJobOutput',
            'Get-AzAutomationJobOutputRecord',
            'Get-AzAutomationModule',
            'Get-AzAutomationRegistrationInfo',
            'Get-AzAutomationRunbook',
            'Get-AzAutomationSchedule',
            'Get-AzAutomationScheduledRunbook',
            'Get-AzAutomationVariable',
            'Get-AzAutomationWebhook',
            'Import-AzAutomationDscConfiguration',
            'Import-AzAutomationDscNodeConfiguration',
            'Import-AzAutomationRunbook',
            'New-AzAutomationAccount',
            'New-AzAutomationCertificate',
            'New-AzAutomationConnection',
            'New-AzAutomationCredential',
            'New-AzAutomationKey',
            'New-AzAutomationModule',
            'New-AzAutomationRunbook',
            'New-AzAutomationSchedule',
            'New-AzAutomationVariable',
            'New-AzAutomationWebhook',
            'Publish-AzAutomationRunbook',
            'Register-AzAutomationDscNode',
            'Register-AzAutomationScheduledRunbook',
            'Remove-AzAutomationAccount',
            'Remove-AzAutomationCertificate',
            'Remove-AzAutomationConnection',
            'Remove-AzAutomationConnectionType',
            'Remove-AzAutomationCredential',
            'Remove-AzAutomationDscConfiguration',
            'Remove-AzAutomationDscNodeConfiguration',
            'Remove-AzAutomationModule',
            'Remove-AzAutomationRunbook',
            'Remove-AzAutomationSchedule',
            'Remove-AzAutomationVariable',
            'Remove-AzAutomationWebhook',
            'Resume-AzAutomationJob',
            'Set-AzAutomationAccount',
            'Set-AzAutomationCertificate',
            'Set-AzAutomationConnectionFieldValue',
            'Set-AzAutomationCredential',
            'Set-AzAutomationDscNode',
            'Set-AzAutomationModule',
            'Set-AzAutomationRunbook',
            'Set-AzAutomationSchedule',
            'Set-AzAutomationVariable',
            'Set-AzAutomationWebhook',
            'Start-AzAutomationDscCompilationJob',
            'Start-AzAutomationRunbook',
            'Stop-AzAutomationJob',
            'Suspend-AzAutomationJob',
            'Unregister-AzAutomationDscNode',
            'Unregister-AzAutomationScheduledRunbook'
        );
        ParameterName = 'AutomationAccountName';
        ScriptBlock = $ScriptBlock;
}

Microsoft.PowerShell.Core\Register-ArgumentCompleter @ArgumentCompleter;

$ArgumentCompleter = @{
        CommandName = @(
            'Get-AzAutomationAccount',
            'New-AzAutomationAccount',
            'Remove-AzAutomationAccount',
            'Set-AzAutomationAccount'
        );
        ParameterName = 'Name';
        ScriptBlock = $ScriptBlock;
}

Microsoft.PowerShell.Core\Register-ArgumentCompleter @ArgumentCompleter;