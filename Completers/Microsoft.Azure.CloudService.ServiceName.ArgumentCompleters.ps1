$ArgumentCompleter = @{
        CommandName = @('Add-AzureCertificate', 
                    'Add-AzureDns', 
                    'Add-AzureInternalLoadBalancer', 
                    'Export-AzureVM', 
                    'Get-AzureCertificate', 
                    'Get-AzureDeployment', 
                    'Get-AzureDeploymentEvent', 
                    'Get-AzureInternalLoadBalancer', 
                    'Get-AzureRemoteDesktopFile', 
                    'Get-AzureRole', 
                    'Get-AzureService', 
                    'Get-AzureServiceADDomainExtension', 
                    'Get-AzureServiceAntimalwareConfig', 'Get-AzureServiceDiagnosticsExtension', 'Get-AzureServiceExtension', 'Get-AzureServiceRemoteDesktopExtension', 'Get-AzureVM', 'Get-AzureWinRMUri', 'Move-AzureDeployment', 'New-AzureDeployment', 'New-AzureQuickVM', 'New-AzureService', 'New-AzureServiceProject', 'New-AzureVM', 'Publish-AzureServiceProject', 'Remove-AzureCertificate', 'Remove-AzureDeployment', 'Remove-AzureDns', 'Remove-AzureInternalLoadBalancer', 'Remove-AzureService', 'Remove-AzureServiceADDomainExtension', 'Remove-AzureServiceAntimalwareExtension', 'Remove-AzureServiceDiagnosticsExtension', 'Remove-AzureServiceExtension', 'Remove-AzureServiceRemoteDesktopExtension', 'Remove-AzureVM', 'Reset-AzureRoleInstance', 'Restart-AzureVM', 'Save-AzureVMImage', 'Set-AzureDeployment', 'Set-AzureDns', 'Set-AzureInternalLoadBalancer', 'Set-AzureLoadBalancedEndpoint', 'Set-AzureRole', 'Set-AzureService', 'Set-AzureServiceADDomainExtension', 'Set-AzureServiceAntimalwareExtension', 'Set-AzureServiceDiagnosticsExtension', 'Set-AzureServiceExtension', 'Set-AzureServiceRemoteDesktopExtension', 'Set-AzureWalkUpgradeDomain', 'Start-AzureService', 'Start-AzureVM', 'Stop-AzureService', 'Stop-AzureVM', 'Update-AzureVM');
        ParameterName = 'ServiceName';
        #Description = 'Complete the -ServiceName parameter value for Azure cmdlets:  Get-AzureService -ServiceName <TAB>';
        ScriptBlock = {
        <#
        .SYNOPSIS
        Auto-complete the -ServiceName parameter value for Azure PowerShell cmdlets.

        .NOTES
        Created by Trevor Sullivan <trevor@trevorsullivan.net>
        http://trevorsullivan.net
        #>
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        $ItemList = Get-AzureService | Where-Object { $PSItem.ServiceName -match $wordToComplete } | ForEach-Object {
            $CompletionText = $PSItem.ServiceName
            $ToolTip = 'Cloud Service in "{0}" region.' -f $PSItem.ExtendedProperties.ResourceLocation
            $ListItemText = '{0} ({1})' -f $PSItem.ServiceName, $PSItem.ExtendedProperties.ResourceLocation
            $CompletionResultType = [System.Management.Automation.CompletionResultType]::ParameterValue

            New-Object -TypeName System.Management.Automation.CompletionResult -ArgumentList @($CompletionText, $ListItemText, $CompletionResultType, $ToolTip);
        }

        return $ItemList
    }
}

Microsoft.PowerShell.Core\Register-ArgumentCompleter @ArgumentCompleter;