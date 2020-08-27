$ScriptBlock = {
        <#
        .SYNOPSIS
        Auto-complete the -ResourceId parameter value for Azure Resource Manager (ARM) PowerShell cmdlets.

        .NOTES
        Created by Trevor Sullivan <trevor@trevorsullivan.net>
        http://trevorsullivan.net
        #>
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        try {
            $ObjectList = Get-AzResource -ErrorAction Stop -WarningAction Ignore;
        } catch {
            Write-Host -Object ('Error occurred retrieving Automation Accounts: {0}' -f $PSItem.Exception.Message);
        }
        $ItemList = $ObjectList | Where-Object { $PSItem.AutomationAccountName -match $wordToComplete } | ForEach-Object {
            $CompletionText = $PSItem.ResourceId;
            $ToolTip = 'Resource {0} in {1} region, in {2} Resource Group.' -f $PSItem.ResourceName, $PSItem.Location, $PSItem.ResourceGroupName;
            $ListItemText = '{0} ({1})' -f $PSItem.ResourceName, $PSItem.Location;
            $CompletionResultType = [System.Management.Automation.CompletionResultType]::ParameterValue;

            New-Object -TypeName System.Management.Automation.CompletionResult -ArgumentList @($CompletionText, $ListItemText, $CompletionResultType, $ToolTip);
        }

        return $ItemList
    }
$ArgumentCompleter = @{
        ### NOTE: Use this command to generate command list:
        ### (Get-Command -Module Az* -ParameterName ResourceId).Name.ForEach({ "'{0}'," -f $PSItem }) | Set-Clipboard
        CommandName = @(
            'Get-AzAlertHistory',
            'Get-AzAutoscaleHistory',
            'Get-AzDiagnosticSetting',
            'Get-AzLog',
            'Get-AzMetric',
            'Get-AzMetricDefinition',
            'Get-AzPolicyAssignment',
            'Get-AzPolicyDefinition',
            'Get-AzResource',
            'Get-AzResourceGroup',
            'Get-AzResourceGroupDeployment',
            'Get-AzResourceLock',
            'Get-AzUsage',
            'Invoke-AzResourceAction',
            'Move-AzResource',
            'New-AzResource',
            'New-AzResourceLock',
            'Remove-AzPolicyAssignment',
            'Remove-AzPolicyDefinition',
            'Remove-AzResource',
            'Remove-AzResourceGroup',
            'Remove-AzResourceGroupDeployment',
            'Remove-AzResourceLock',
            'Set-AzDiagnosticSetting',
            'Set-AzPolicyAssignment',
            'Set-AzPolicyDefinition',
            'Set-AzResource',
            'Set-AzResourceGroup',
            'Set-AzResourceLock',
            'Stop-AzResourceGroupDeployment'
        );
        ParameterName = 'ResourceId';
        ScriptBlock = $ScriptBlock;
}

Microsoft.PowerShell.Core\Register-ArgumentCompleter @ArgumentCompleter;
