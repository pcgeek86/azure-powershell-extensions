$ScriptBlock = {
        <#
        .SYNOPSIS
        Auto-complete the -StorageAccountName parameter value for Azure Resource Manager (ARM) PowerShell cmdlets.
    
        .NOTES
       
        Created by Trevor Sullivan <trevor@trevorsullivan.net>
        http://trevorsullivan.net
        #>
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        try {
            $StorageAccountList = Get-AzureRmStorageAccount | Where-Object -FilterScript { $PSItem.StorageAccountName -match $wordToComplete } | ForEach-Object {
                $CompletionText = '{0} -ResourceGroupName {1}' -f $PSItem.StorageAccountName, $PSItem.ResourceGroupName;
                $ToolTip = 'Storage Account "{0}" in "{1}" region.' -f $PSItem.StorageAccountName, $PSItem.Location;
                $ListItemText = '{0} ({1})' -f $PSItem.StorageAccountName, $PSItem.Location;
                $CompletionResultType = [System.Management.Automation.CompletionResultType]::ParameterValue;

                New-Object -TypeName System.Management.Automation.CompletionResult -ArgumentList @($CompletionText, $ListItemText, $CompletionResultType, $ToolTip);
            }

            return $StorageAccountList;
        }
        catch {
            Write-Host -Message ('Error occurred calling argument completer: {0}' -f $PSItem.Exception.Message);
        }
    };

$ArgumentCompleterList = @(
    @{
        CommandName = @(
            'Add-AzureRMHDInsightStorage'
            'New-AzureRMResourceGroup'
            'New-AzureRMResourceGroupDeployment'
            'New-AzureRMStorageContext'
            'Publish-AzureRMVMDscConfiguration'
            'Remove-AzureRMStorageAccount'
            'Restore-AzureRMBackupItem'
            'Set-AzureRMHDInsightDefaultStorage'
            'Set-AzureRMSqlDatabaseAuditingPolicy'
            'Set-AzureRMSqlServerAuditingPolicy'
            'Set-AzureRMVMCustomScriptExtension'
            'Set-AzureRMVMDscExtension'
            'Test-AzureRMResourceGroupTemplate'
        );
        ParameterName = 'StorageAccountName';
        ScriptBlock = $ScriptBlock;
    };
    @{
        CommandName = @(
            'Get-AzureRmStorageAccountKey'
            'New-AzureRmStorageAccountKey'
            'Get-AzureRmStorageAccount'
            'New-AzureRmStorageAccount'
            'Set-AzureRmStorageAccount'
			'Remove-AzureRmStorageAccount'
        );
        ParameterName = 'Name';
        ScriptBlock = $ScriptBlock;
    }
)

foreach ($ArgumentCompleter in $ArgumentCompleterList) {
    Microsoft.PowerShell.Core\Register-ArgumentCompleter @ArgumentCompleter;
}