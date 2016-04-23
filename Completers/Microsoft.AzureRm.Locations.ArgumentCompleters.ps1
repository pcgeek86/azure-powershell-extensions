$ArgumentCompleter = @{
    CommandName = @(
            'Add-AlertRule',
            'Add-AutoscaleSetting',
            'Add-AzureRmApiManagementRegion',
            'Get-AzureRmHDInsightProperties',
            'Get-AzureRmStreamAnalyticsQuota',
            'Get-AzureRmVMExtensionImage',
            'Get-AzureRmVMExtensionImageType',
            'Get-AzureRmVMImage',
            'Get-AzureRmVMImageOffer',
            'Get-AzureRmVMImagePublisher',
            'Get-AzureRmVMImageSku',
            'Get-AzureRmVMSize',
            'Get-AzureRmVMUsage',
            'New-AzureRmApiManagement',
            'New-AzureRmApiManagementVirtualNetwork',
            'New-AzureRmApplicationGateway',
            'New-AzureRmAppServicePlan',
            'New-AzureRmAutomationAccount',
            'New-AzureRmAvailabilitySet',
            'New-AzureRmBatchAccount',
            'New-AzureRmDataFactory',
            'New-AzureRmHDInsightCluster',
            'New-AzureRmKeyVault',
            'New-AzureRmLoadBalancer',
            'New-AzureRmLocalNetworkGateway',
            'New-AzureRmNetworkInterface',
            'New-AzureRmNetworkSecurityGroup',
            'New-AzureRmOperationalInsightsWorkspace',
            'New-AzureRmPublicIpAddress',
            'New-AzureRmRedisCache',
            'New-AzureRmResource',
            'New-AzureRmResourceGroup',
            'New-AzureRmRouteTable',
            'New-AzureRmSiteRecoveryVault',
            'New-AzureRmSqlServer',
            'New-AzureRmStorageAccount',
            'New-AzureRmVirtualNetwork',
            'New-AzureRmVirtualNetworkGateway',
            'New-AzureRmVirtualNetworkGatewayConnection',
            'New-AzureRmVM',
            'New-AzureRmWebApp',
            'Remove-AzureRmApiManagementRegion',
            'Set-AzureRmAppServicePlan',
            'Set-AzureRmVMAccessExtension',
            'Set-AzureRmVMCustomScriptExtension',
            'Set-AzureRmVMDiagnosticsExtension',
            'Set-AzureRmVMDscExtension',
            'Set-AzureRmVMExtension',
            'Set-AzureRmVMSqlServerExtension',
            'Test-AzureRmDnsAvailability',
            'Update-AzureRmApiManagementDeployment',
            'Update-AzureRmApiManagementRegion'
    );
    ParameterName = 'Location';
    #Description = 'Complete the -Location parameter value for Azure Resource Manager cmdlets: New-AzureResource -Location <TAB>';
    ScriptBlock = {
        <#
        .SYNOPSIS
        Auto-complete the -Location parameter value for Azure cmdlets.
    
        .NOTES
        Created by Trevor Sullivan <trevor@trevorsullivan.net>
        http://trevorsullivan.net
        http://twitter.com/pcgeek86
        #>
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        function Get-AllAzureLocations {
            <#
            .Synopsis
            Retrieves a list of Azure locations, using the AzureResourceManager PowerShell module.

            .Description
            This function may be deprecated, or require modification, if the Get-AzureLocation command is changed
            from returning Azure platform features, to returning Azure locations. As of this implementation, the
            ARM Get-AzureLocation command returns a list of Azure Resource Providers as the top-level object.

            NOTE: This argument completer requires that the user be authenticated to Microsoft Azure.
            #>
            [CmdletBinding()]
            param ()

            $LocationList = (Get-AzureRmResourceProvider).Locations | Select-Object -Unique | Sort-Object;
            Write-Output -InputObject $LocationList;
        }

        ### Create fresh completion results for Azure virtual machines
        $ItemList = Get-AllAzureLocations | Where-Object { $PSItem.Name -match $wordToComplete } | ForEach-Object {
            $CompletionText = $PSItem;
            $ToolTip = $PSItem;
            $ListItemText = $PSItem;
            $CompletionResultType = [System.Management.Automation.CompletionResultType]::ParameterValue;

            New-Object -TypeName System.Management.Automation.CompletionResult -ArgumentList @($CompletionText, $ListItemText, $CompletionResultType, $ToolTip);
        }
    
        ### Return the fresh completion results
        return $ItemList;
    }
}

Microsoft.PowerShell.Core\Register-ArgumentCompleter @ArgumentCompleter;