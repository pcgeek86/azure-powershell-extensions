$ArgumentCompleter = @{
    CommandName = @(
            'Add-AlertRule',
            'Add-AutoscaleSetting',
            'Add-AzApiManagementRegion',
            'Get-AzHDInsightProperties',
            'Get-AzStreamAnalyticsQuota',
            'Get-AzVMExtensionImage',
            'Get-AzVMExtensionImageType',
            'Get-AzVMImage',
            'Get-AzVMImageOffer',
            'Get-AzVMImagePublisher',
            'Get-AzVMImageSku',
            'Get-AzVMSize',
            'Get-AzVMUsage',
            'New-AzApiManagement',
            'New-AzApiManagementVirtualNetwork',
            'New-AzApplicationGateway',
            'New-AzAppServicePlan',
            'New-AzAutomationAccount',
            'New-AzAvailabilitySet',
            'New-AzBatchAccount',
            'New-AzDataFactory',
            'New-AzHDInsightCluster',
            'New-AzKeyVault',
            'New-AzLoadBalancer',
            'New-AzLocalNetworkGateway',
            'New-AzNetworkInterface',
            'New-AzNetworkSecurityGroup',
            'New-AzOperationalInsightsWorkspace',
            'New-AzPublicIpAddress',
            'New-AzRedisCache',
            'New-AzResource',
            'New-AzResourceGroup',
            'New-AzRouteTable',
            'New-AzSiteRecoveryVault',
            'New-AzSqlServer',
            'New-AzStorageAccount',
            'New-AzVirtualNetwork',
            'New-AzVirtualNetworkGateway',
            'New-AzVirtualNetworkGatewayConnection',
            'New-AzVM',
            'New-AzWebApp',
            'Remove-AzApiManagementRegion',
            'Set-AzAppServicePlan',
            'Set-AzVMAccessExtension',
            'Set-AzVMCustomScriptExtension',
            'Set-AzVMDiagnosticsExtension',
            'Set-AzVMDscExtension',
            'Set-AzVMExtension',
            'Set-AzVMSqlServerExtension',
            'Test-AzDnsAvailability',
            'Update-AzApiManagementDeployment',
            'Update-AzApiManagementRegion'
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

            $LocationList = (Get-AzResourceProvider).Locations | Select-Object -Unique | Sort-Object;
            Write-Output -InputObject $LocationList;
        }

        ### Create fresh completion results for Azure virtual machines
        $ItemList = Get-AllAzureLocations | Where-Object { $PSItem -match $wordToComplete } | ForEach-Object {
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