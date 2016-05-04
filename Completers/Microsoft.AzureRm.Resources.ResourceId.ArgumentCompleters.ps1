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
            $ObjectList = Get-AzureRmResource -ErrorAction Stop -WarningAction Ignore;
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
        ### (Get-Command -Module AzureRM* -ParameterName ResourceId).Name.ForEach({ "'{0}'," -f $PSItem }) | Set-Clipboard
        CommandName = @(
            'Get-AzureRmAlertHistory',
            'Get-AzureRmAutoscaleHistory',
            'Get-AzureRmDiagnosticSetting',
            'Get-AzureRmLog',
            'Get-AzureRmMetric',
            'Get-AzureRmMetricDefinition',
            'Get-AzureRmPolicyAssignment',
            'Get-AzureRmPolicyDefinition',
            'Get-AzureRmResource',
            'Get-AzureRmResourceGroup',
            'Get-AzureRmResourceGroupDeployment',
            'Get-AzureRmResourceLock',
            'Get-AzureRmUsage',
            'Invoke-AzureRmResourceAction',
            'Move-AzureRmResource',
            'New-AzureRmResource',
            'New-AzureRmResourceLock',
            'Remove-AzureRmPolicyAssignment',
            'Remove-AzureRmPolicyDefinition',
            'Remove-AzureRmResource',
            'Remove-AzureRmResourceGroup',
            'Remove-AzureRmResourceGroupDeployment',
            'Remove-AzureRmResourceLock',
            'Set-AzureRmDiagnosticSetting',
            'Set-AzureRmPolicyAssignment',
            'Set-AzureRmPolicyDefinition',
            'Set-AzureRmResource',
            'Set-AzureRmResourceGroup',
            'Set-AzureRmResourceLock',
            'Stop-AzureRmResourceGroupDeployment'
        );
        ParameterName = 'ResourceId';
        ScriptBlock = $ScriptBlock;
}

Microsoft.PowerShell.Core\Register-ArgumentCompleter @ArgumentCompleter;
