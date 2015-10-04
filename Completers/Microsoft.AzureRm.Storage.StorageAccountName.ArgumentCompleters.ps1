$ArgumentCompleter =     @{
        Command = @(
            'Add-AzureRMHDInsightStorage'
            'Get-AzureRMStorageAccount'
            'Get-AzureRMStorageAccountKey'
            'New-AzureRMResourceGroup'
            'New-AzureRMResourceGroupDeployment'
            'New-AzureRMStorageAccount'
            'New-AzureRMStorageAccountKey'
            'New-AzureRMStorageContext'
            'Publish-AzureRMVMDscConfiguration'
            'Remove-AzureRMStorageAccount'
            'Restore-AzureRMBackupItem'
            'Set-AzureRMHDInsightDefaultStorage'
            'Set-AzureRMSqlDatabaseAuditingPolicy'
            'Set-AzureRMSqlServerAuditingPolicy'
            'Set-AzureRMStorageAccount'
            'Set-AzureRMVMCustomScriptExtension'
            'Set-AzureRMVMDscExtension'
            'Test-AzureRMResourceGroupTemplate'
        );
        Parameter = 'StorageAccountName';
        Description = 'Complete the -StorageAccountName parameter value for Azure Resource Manager (ARM) cmdlets: Get-AzureRmStorageAccountKey -StorageAccountName <TAB>';
        ScriptBlock =  {
        <#
        .SYNOPSIS
        Auto-complete the -StorageAccountName parameter value for Azure Resource Manager (ARM) PowerShell cmdlets.
    
        .NOTES
       
        Created by Trevor Sullivan <trevor@trevorsullivan.net>
        http://trevorsullivan.net
        #>
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        #Write-Verbose -Message ('Called AzureRm StorageAccountName completer at {0}' -f (Get-Date))

        $CacheKey = 'RmStorageAccount_StorageAccountNameCache';
        $Cache = Get-CompletionPrivateData -Key $CacheKey;

        ### Return the cached value if it has not expired
        if ($Cache) {
            return $Cache;
        }

        $StorageAccountList = Get-AzureRmStorageAccount | Where-Object { $PSItem.StorageAccountName -match $wordToComplete } | ForEach-Object -Process {
            $CompletionResult = @{
                CompletionText = $PSItem.StorageAccountName;
                ToolTip = 'Storage Account "{0}" in "{1}" region.' -f $PSItem.StorageAccountName, $PSItem.Location;
                ListItemText = '{0} ({1})' -f $PSItem.StorageAccountName, $PSItem.Location;
                CompletionResultType = [System.Management.Automation.CompletionResultType]::ParameterValue;
                }
            New-CompletionResult @CompletionResult;
        }

        Set-CompletionPrivateData -Key $CacheKey -Value $StorageAccountList;
        return $StorageAccountList;
        }
    }

TabExpansion++\Register-ArgumentCompleter @ArgumentCompleter;