$ScriptBlock = {
        <#
        .SYNOPSIS
        Auto-complete the -Name parameter value for Azure Automation Runbook Azure Resource Manager (ARM) PowerShell cmdlets.
		
		NOTE: Use this command to find commands that this auto-completer applies to: 
		(Get-Command -Module Az.Automation -Name *runbook* -ParameterName Name).ForEach({ "'{0}'" -f $PSItem.Name }) | Set-Clipboard

        .NOTES
        Created by Trevor Sullivan <trevor@trevorsullivan.net>
        http://trevorsullivan.net
        #>
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        try {
            $ObjectList = Get-AzAutomationRunbook -AutomationAccountName $fakeBoundParameter["AutomationAccountName"] -ResourceGroupName $fakeBoundParameter["ResourceGroupName"] -ErrorAction Stop -WarningAction Ignore;
        } catch {
            Write-Host -Object ('Error occurred retrieving Automation Runbooks: {0}' -f $PSItem.Exception.Message);
        }
        $ItemList = $ObjectList | Where-Object { $PSItem.Name -match $wordToComplete } | ForEach-Object {
            $CompletionText = $PSItem.Name;
            $ToolTip = 'Runbook {0} in {1} Automation Account.' -f $PSItem.Name, $PSItem.AutomationAccountName;
            $ListItemText = '{0}' -f $PSItem.Name;
            $CompletionResultType = [System.Management.Automation.CompletionResultType]::ParameterValue;

            New-Object -TypeName System.Management.Automation.CompletionResult -ArgumentList @($CompletionText, $ListItemText, $CompletionResultType, $ToolTip);
        }

        return $ItemList
    }

$ArgumentCompleter = @{
        CommandName = @(
			'Export-AzAutomationRunbook'
			'Get-AzAutomationRunbook'
			'Get-AzAutomationScheduledRunbook'
			'Import-AzAutomationRunbook'
			'New-AzAutomationRunbook'
			'Publish-AzAutomationRunbook'
			'Register-AzAutomationScheduledRunbook'
			'Remove-AzAutomationRunbook'
			'Set-AzAutomationRunbook'
			'Start-AzAutomationRunbook'
			'Unregister-AzAutomationScheduledRunbook'
		);
        ParameterName = 'Name';
        ScriptBlock = $ScriptBlock;
}

Microsoft.PowerShell.Core\Register-ArgumentCompleter @ArgumentCompleter;
