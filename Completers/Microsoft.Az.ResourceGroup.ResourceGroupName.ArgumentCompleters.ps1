$ScriptBlock = {
        <#
        .SYNOPSIS
        Auto-complete the -ResourceGroupName parameter value for Azure Resource Manager (ARM) PowerShell cmdlets.

        .NOTES
        Created by Trevor Sullivan <trevor@trevorsullivan.net>
        http://trevorsullivan.net
        #>
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        try {
            $ResourceGroupList = Get-AzResourceGroup -ErrorAction Stop -WarningAction Ignore;
        } catch {
            Write-Host -Object ('Error occurred retrieving resource groups: {0}' -f $PSItem.Exception.Message);
        }
        $ItemList = $ResourceGroupList | Where-Object { $PSItem.ResourceGroupName -match $wordToComplete } | ForEach-Object {
            $CompletionText = $PSItem.ResourceGroupName;
            $ToolTip = 'Resource Group {0} in {1} region.' -f $PSItem.ResourceGroupName, $PSItem.Location;
            $ListItemText = '{0} ({1})' -f $PSItem.ResourceGroupName, $PSItem.Location;
            $CompletionResultType = [System.Management.Automation.CompletionResultType]::ParameterValue;

            New-Object -TypeName System.Management.Automation.CompletionResult -ArgumentList @($CompletionText, $ListItemText, $CompletionResultType, $ToolTip);
        }

        return $ItemList
    }

$ArgumentCompleter = @{
        CommandName = @(
            'Get-AzSqlDatabaseServerAuditingPolicy'
            'Remove-AzSqlDatabaseServerAuditing'
            'Set-AzSqlDatabaseServerAuditingPolicy'
            'Use-AzSqlDatabaseServerAuditingPolicy'
            'Add-AzVhd'
            'Backup-AzApiManagement'
            'Disable-AzTrafficManagerEndpoint'
            'Disable-AzTrafficManagerProfile'
            'Enable-AzTrafficManagerEndpoint'
            'Enable-AzTrafficManagerProfile'
            'Export-AzAutomationDscConfiguration'
            'Export-AzAutomationDscNodeReportContent'
            'Export-AzAutomationRunbook'
            'Get-AzApiManagement'
            'Get-AzApiManagementSsoToken'
            'Get-AzApplicationGateway'
            'Get-AzAppServicePlan'
            'Get-AzAutomationAccount'
            'Get-AzAutomationCertificate'
            'Get-AzAutomationConnection'
            'Get-AzAutomationCredential'
            'Get-AzAutomationDscCompilationJob'
            'Get-AzAutomationDscCompilationJobOutput'
            'Get-AzAutomationDscConfiguration'
            'Get-AzAutomationDscNode'
            'Get-AzAutomationDscNodeConfiguration'
            'Get-AzAutomationDscNodeReport'
            'Get-AzAutomationDscOnboardingMetaconfig'
            'Get-AzAutomationJob'
            'Get-AzAutomationJobOutput'
            'Get-AzAutomationModule'
            'Get-AzAutomationRegistrationInfo'
            'Get-AzAutomationRunbook'
            'Get-AzAutomationSchedule'
            'Get-AzAutomationScheduledRunbook'
            'Get-AzAutomationVariable'
            'Get-AzAutomationWebhook'
            'Get-AzAvailabilitySet'
            'Get-AzBackupVault'
            'Get-AzBatchAccount'
            'Get-AzBatchAccountKeys'
            'Get-AzDataFactory'
            'Get-AzDataFactoryDataset'
            'Get-AzDataFactoryGateway'
            'Get-AzDataFactoryHub'
            'Get-AzDataFactoryLinkedService'
            'Get-AzDataFactoryPipeline'
            'Get-AzDataFactoryRun'
            'Get-AzDataFactorySlice'
            'Get-AzDnsRecordSet'
            'Get-AzDnsZone'
            'Get-AzHDInsightCluster'
            'Get-AzHDInsightJob'
            'Get-AzHDInsightJobOutput'
            'Get-AzKeyVault'
            'Get-AzLoadBalancer'
            'Get-AzLocalNetworkGateway'
            'Get-AzNetworkInterface'
            'Get-AzNetworkSecurityGroup'
            'Get-AzOperationalInsightsStorageInsight'
            'Get-AzOperationalInsightsWorkspace'
            'Get-AzOperationalInsightsWorkspaceManagementGroups'
            'Get-AzOperationalInsightsWorkspaceSharedKeys'
            'Get-AzOperationalInsightsWorkspaceUsage'
            'Get-AzPublicIpAddress'
            'Get-AzRedisCache'
            'Get-AzRedisCacheKey'
            'Get-AzRemoteDesktopFile'
            'Get-AzResource'
            'Get-AzResourceGroup'
            'Get-AzResourceGroupDeployment'
            'Get-AzResourceGroupDeploymentOperation'
            'Get-AzResourceLock'
            'Get-AzRoleAssignment'
            'Get-AzRouteTable'
            'Get-AzSqlDatabase'
            'Get-AzSqlDatabaseActivity'
            'Get-AzSqlDatabaseAuditingPolicy'
            'Get-AzSqlDatabaseDataMaskingPolicy'
            'Get-AzSqlDatabaseDataMaskingRule'
            'Get-AzSqlDatabaseExpanded'
            'Get-AzSqlDatabaseIndexRecommendations'
            'Get-AzSqlDatabaseReplicationLink'
            'Get-AzSqlDatabaseRestorePoints'
            'Get-AzSqlDatabaseSecureConnectionPolicy'
            'Get-AzSqlDatabaseTransparentDataEncryption'
            'Get-AzSqlDatabaseTransparentDataEncryptionActivity'
            'Get-AzSqlDatabaseUpgradeHint'
            'Get-AzSqlElasticPool'
            'Get-AzSqlElasticPoolActivity'
            'Get-AzSqlElasticPoolDatabase'
            'Get-AzSqlElasticPoolRecommendation'
            'Get-AzSqlServer'
            'Get-AzSqlServerActiveDirectoryAdministrator'
            'Get-AzSqlServerAuditingPolicy'
            'Get-AzSqlServerFirewallRule'
            'Get-AzSqlServerServiceObjective'
            'Get-AzSqlServerUpgrade'
            'Get-AzSqlServerUpgradeHint'
            'Get-AzStreamAnalyticsInput'
            'Get-AzStreamAnalyticsJob'
            'Get-AzStreamAnalyticsOutput'
            'Get-AzStreamAnalyticsTransformation'
            'Get-AzTrafficManagerEndpoint'
            'Get-AzTrafficManagerProfile'
            'Get-AzVirtualNetwork'
            'Get-AzVirtualNetworkGateway'
            'Get-AzVirtualNetworkGatewayConnection'
            'Get-AzVirtualNetworkGatewayConnectionSharedKey'
            'Get-AzVM'
            'Get-AzVMAccessExtension'
            'Get-AzVMCustomScriptExtension'
            'Get-AzVMDiagnosticsExtension'
            'Get-AzVMDscExtension'
            'Get-AzVMExtension'
            'Get-AzVMSize'
            'Get-AzVMSqlServerExtension'
            'Get-AzWebApp'
            'Get-AzWebAppPublishingProfile'
            'Grant-AzHDInsightHttpServicesAccess'
            'Grant-AzHDInsightRdpServicesAccess'
            'Import-AzApiManagementHostnameCertificate'
            'Import-AzAutomationDscConfiguration'
            'Import-AzAutomationRunbook'
            'Invoke-AzResourceAction'
            'New-AzApiManagement'
            'New-AzApiManagementContext'
            'New-AzApplicationGateway'
            'New-AzAppServicePlan'
            'New-AzAutomationAccount'
            'New-AzAutomationCertificate'
            'New-AzAutomationConnection'
            'New-AzAutomationCredential'
            'New-AzAutomationKey'
            'New-AzAutomationModule'
            'New-AzAutomationRunbook'
            'New-AzAutomationSchedule'
            'New-AzAutomationVariable'
            'New-AzAutomationWebhook'
            'New-AzAvailabilitySet'
            'New-AzBackupVault'
            'New-AzBatchAccount'
            'New-AzBatchAccountKey'
            'New-AzDataFactory'
            'New-AzDataFactoryDataset'
            'New-AzDataFactoryEncryptValue'
            'New-AzDataFactoryGateway'
            'New-AzDataFactoryGatewayKey'
            'New-AzDataFactoryHub'
            'New-AzDataFactoryLinkedService'
            'New-AzDataFactoryPipeline'
            'New-AzDnsRecordSet'
            'New-AzDnsZone'
            'New-AzHDInsightCluster'
            'New-AzKeyVault'
            'New-AzLoadBalancer'
            'New-AzLocalNetworkGateway'
            'New-AzNetworkInterface'
            'New-AzNetworkSecurityGroup'
            'New-AzOperationalInsightsStorageInsight'
            'New-AzOperationalInsightsWorkspace'
            'New-AzPublicIpAddress'
            'New-AzRedisCache'
            'New-AzRedisCacheKey'
            'New-AzResource'
            'New-AzResourceGroup'
            'New-AzResourceGroupDeployment'
            'New-AzResourceLock'
            'New-AzRoleAssignment'
            'New-AzRouteTable'
            'New-AzSqlDatabase'
            'New-AzSqlDatabaseCopy'
            'New-AzSqlDatabaseDataMaskingRule'
            'New-AzSqlDatabaseSecondary'
            'New-AzSqlElasticPool'
            'New-AzSqlServer'
            'New-AzSqlServerFirewallRule'
            'New-AzStorageAccount'
            'New-AzStreamAnalyticsInput'
            'New-AzStreamAnalyticsJob'
            'New-AzStreamAnalyticsOutput'
            'New-AzStreamAnalyticsTransformation'
            'New-AzTrafficManagerEndpoint'
            'New-AzTrafficManagerProfile'
            'New-AzVirtualNetwork'
            'New-AzVirtualNetworkGateway'
            'New-AzVirtualNetworkGatewayConnection'
            'New-AzVM'
            'New-AzWebApp'
            'New-AzureVMSqlServerAutoBackupConfig'
            'Publish-AzAutomationRunbook'
            'Publish-AzVMDscConfiguration'
            'Register-AzAutomationDscNode'
            'Register-AzAutomationScheduledRunbook'
            'Register-AzBackupContainer'
            'Remove-AzApiManagement'
            'Remove-AzApplicationGateway'
            'Remove-AzAppServicePlan'
            'Remove-AzAutomationAccount'
            'Remove-AzAutomationCertificate'
            'Remove-AzAutomationConnection'
            'Remove-AzAutomationCredential'
            'Remove-AzAutomationModule'
            'Remove-AzAutomationRunbook'
            'Remove-AzAutomationSchedule'
            'Remove-AzAutomationVariable'
            'Remove-AzAutomationWebhook'
            'Remove-AzAvailabilitySet'
            'Remove-AzBatchAccount'
            'Remove-AzDataFactory'
            'Remove-AzDataFactoryDataset'
            'Remove-AzDataFactoryGateway'
            'Remove-AzDataFactoryHub'
            'Remove-AzDataFactoryLinkedService'
            'Remove-AzDataFactoryPipeline'
            'Remove-AzDnsRecordSet'
            'Remove-AzDnsZone'
            'Remove-AzHDInsightCluster'
            'Remove-AzKeyVault'
            'Remove-AzKeyVaultAccessPolicy'
            'Remove-AzLoadBalancer'
            'Remove-AzLocalNetworkGateway'
            'Remove-AzNetworkInterface'
            'Remove-AzNetworkSecurityGroup'
            'Remove-AzOperationalInsightsStorageInsight'
            'Remove-AzOperationalInsightsWorkspace'
            'Remove-AzPublicIpAddress'
            'Remove-AzRedisCache'
            'Remove-AzResource'
            'Remove-AzResourceGroup'
            'Remove-AzResourceGroupDeployment'
            'Remove-AzResourceLock'
            'Remove-AzRoleAssignment'
            'Remove-AzRouteTable'
            'Remove-AzSqlDatabase'
            'Remove-AzSqlDatabaseAuditing'
            'Remove-AzSqlDatabaseDataMaskingRule'
            'Remove-AzSqlDatabaseSecondary'
            'Remove-AzSqlElasticPool'
            'Remove-AzSqlServer'
            'Remove-AzSqlServerActiveDirectoryAdministrator'
            'Remove-AzSqlServerAuditing'
            'Remove-AzSqlServerFirewallRule'
            'Remove-AzStorageAccount'
            'Remove-AzStreamAnalyticsInput'
            'Remove-AzStreamAnalyticsJob'
            'Remove-AzStreamAnalyticsOutput'
            'Remove-AzTrafficManagerEndpoint'
            'Remove-AzTrafficManagerProfile'
            'Remove-AzVirtualNetwork'
            'Remove-AzVirtualNetworkGateway'
            'Remove-AzVirtualNetworkGatewayConnection'
            'Remove-AzVM'
            'Remove-AzVMAccessExtension'
            'Remove-AzVMCustomScriptExtension'
            'Remove-AzVMDiagnosticsExtension'
            'Remove-AzVMDscExtension'
            'Remove-AzVMExtension'
            'Remove-AzVMSqlServerExtension'
            'Remove-AzWebApp'
            'Reset-AzVirtualNetworkGatewayConnectionSharedKey'
            'Restart-AzVM'
            'Restart-AzWebApp'
            'Restore-AzApiManagement'
            'Resume-AzAutomationJob'
            'Resume-AzDataFactoryPipeline'
            'Resume-AzSqlDatabase'
            'Revoke-AzHDInsightHttpServicesAccess'
            'Revoke-AzHDInsightRdpServicesAccess'
            'Save-AzDataFactoryLog'
            'Save-AzVMImage'
            'Set-AzApiManagementHostnames'
            'Set-AzApiManagementVirtualNetworks'
            'Set-AzAppServicePlan'
            'Set-AzAutomationAccount'
            'Set-AzAutomationCertificate'
            'Set-AzAutomationConnectionFieldValue'
            'Set-AzAutomationCredential'
            'Set-AzAutomationDscNode'
            'Set-AzAutomationModule'
            'Set-AzAutomationRunbook'
            'Set-AzAutomationSchedule'
            'Set-AzAutomationVariable'
            'Set-AzAutomationWebhook'
            'Set-AzBatchAccount'
            'Set-AzDataFactoryGateway'
            'Set-AzDataFactoryPipelineActivePeriod'
            'Set-AzDataFactorySliceStatus'
            'Set-AzDnsZone'
            'Set-AzHDInsightClusterSize'
            'Set-AzKeyVaultAccessPolicy'
            'Set-AzOperationalInsightsStorageInsight'
            'Set-AzOperationalInsightsWorkspace'
            'Set-AzRedisCache'
            'Set-AzResource'
            'Set-AzResourceGroup'
            'Set-AzResourceLock'
            'Set-AzSqlDatabase'
            'Set-AzSqlDatabaseAuditingPolicy'
            'Set-AzSqlDatabaseDataMaskingPolicy'
            'Set-AzSqlDatabaseDataMaskingRule'
            'Set-AzSqlDatabaseSecondary'
            'Set-AzSqlDatabaseTransparentDataEncryption'
            'Set-AzSqlElasticPool'
            'Set-AzSqlServer'
            'Set-AzSqlServerActiveDirectoryAdministrator'
            'Set-AzSqlServerAuditingPolicy'
            'Set-AzSqlServerFirewallRule'
            'Set-AzStorageAccount'
            'Set-AzVirtualNetworkGatewayConnectionSharedKey'
            'Set-AzVM'
            'Set-AzVMAccessExtension'
            'Set-AzVMCustomScriptExtension'
            'Set-AzVMDiagnosticsExtension'
            'Set-AzVMDscExtension'
            'Set-AzVMExtension'
            'Set-AzVMSqlServerExtension'
            'Start-AzAutomationDscCompilationJob'
            'Start-AzAutomationRunbook'
            'Start-AzHDInsightJob'
            'Start-AzSqlDatabaseExecuteIndexRecommendation'
            'Start-AzSqlServerUpgrade'
            'Start-AzStreamAnalyticsJob'
            'Start-AzVM'
            'Start-AzWebApp'
            'Stop-AzAutomationJob'
            'Stop-AzHDInsightJob'
            'Stop-AzResourceGroupDeployment'
            'Stop-AzSqlDatabaseExecuteIndexRecommendation'
            'Stop-AzSqlServerUpgrade'
            'Stop-AzStreamAnalyticsJob'
            'Stop-AzVM'
            'Stop-AzWebApp'
            'Suspend-AzAutomationJob'
            'Suspend-AzDataFactoryPipeline'
            'Suspend-AzSqlDatabase'
            'Test-AzResource'
            'Test-AzResourceGroup'
            'Test-AzResourceGroupTemplate'
            'Test-AzStreamAnalyticsInput'
            'Test-AzStreamAnalyticsOutput'
            'Unregister-AzAutomationDscNode'
            'Unregister-AzAutomationScheduledRunbook'
            'Update-AzApiManagementDeployment'
            'Update-AzVM'
            'Use-AzHDInsightCluster'
            'Use-AzSqlServerAuditingPolicy'
            'Wait-AzHDInsightJob'
        );
        ParameterName = 'ResourceGroupName';
        #Description = 'Complete the -ResourceGroupName parameter value for Azure Resource Manager cmdlets: New-AzureVM -ResourceGroupName <TAB>';
        ScriptBlock = $ScriptBlock;
}

Microsoft.PowerShell.Core\Register-ArgumentCompleter @ArgumentCompleter;

$ArgumentCompleter = @{
        CommandName = @(
            'Find-AzResourceGroup'
            'Get-AzResourceGroup'
            'New-AzResourceGroup'
            'Remove-AzResourceGroup'
            'Set-AzResourceGroup'
        );
        ParameterName = 'Name';
        #Description = 'Complete the -Name parameter value for the core Azure Resource Manager (ARM) Resource Group cmdlets: Get-AzureRmResourceGroup -Name <TAB>';
        ScriptBlock = $ScriptBlock;
}

Microsoft.PowerShell.Core\Register-ArgumentCompleter @ArgumentCompleter;