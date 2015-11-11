$ScriptBlock = {
        <#
        .SYNOPSIS
        Auto-complete the -StorageAccountName parameter value for Azure Resource Manager (ARM) PowerShell cmdlets.
    
        .NOTES
       
        Created by Trevor Sullivan <trevor@trevorsullivan.net>
        http://trevorsullivan.net
        #>
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        $CacheKey = 'RmVirtualMachine_VMNameCache';
        $Cache = Get-CompletionPrivateData -Key $CacheKey;

        ### Return the cached value if it has not expired
        if ($Cache) { return $Cache; }

        try {
            $StorageAccountList = Get-AzureRmStorageAccount | Where-Object -FilterScript { $PSItem.Name -match $wordToComplete } | ForEach-Object {
                $CompletionResult = @{
                    CompletionText = '{0} -ResourceGroupName {1}' -f $PSItem.Name, $PSItem.ResourceGroupName;
                    ToolTip = 'Storage Account "{0}" in "{1}" region.' -f $PSItem.Name, $PSItem.Location;
                    ListItemText = '{0} ({1})' -f $PSItem.Name, $PSItem.Location;
                    CompletionResultType = [System.Management.Automation.CompletionResultType]::ParameterValue;
                    NoQuotes = $true;
                    }
                New-CompletionResult @CompletionResult;
            }

            Set-CompletionPrivateData -Key $CacheKey -Value $StorageAccountList;
            return $StorageAccountList;
        }
        catch {
            Write-Host -Message ('Error occurred calling argument completer: {0}' -f $PSItem.Exception.Message);
        }
    };

$ArgumentCompleterList = @(
    @{
    Command = @(
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
    Parameter = 'StorageAccountName';
    Description = 'Complete the -StorageAccountName parameter value for Azure Resource Manager (ARM) cmdlets: Get-AzureRmStorageAccountKey -StorageAccountName <TAB>';
    ScriptBlock = $ScriptBlock;
    };
    @{
        Command = @(
            'Get-AzureRMStorageAccountKey'
            'New-AzureRMStorageAccountKey'
            'Get-AzureRMStorageAccount'
            'New-AzureRMStorageAccount'
            'Set-AzureRMStorageAccount'
        );
        Parameter = 'Name';
        Description = '';
        ScriptBlock = $ScriptBlock;
    }
)

foreach ($ArgumentCompleter in $ArgumentCompleterList) {
    TabExpansion++\Register-ArgumentCompleter @ArgumentCompleter;
}