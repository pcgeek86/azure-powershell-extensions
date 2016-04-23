$ArgumentCompleter = @{
        CommandName = @('Get-AzureStorageContainerAcl', 
                    'Get-AzureSiteRecoveryProtectionContainer', 
                    'Get-AzureStorageContainer', 
                    'New-AzureStorageContainer', 
                    'New-AzureStorageContainerSASToken', 
                    'Remove-AzureStorageContainer', 
                    'Set-AzureStorageContainerAcl');
        ParameterName = 'Name';
        #Description = 'Complete the -Name parameter value for Azure cmdlets:  Get-AzureStorageContainer -Context $Context -Name <TAB>';
        ScriptBlock = {
        <#
        .SYNOPSIS
        Auto-complete the -Name parameter value for Azure PowerShell storage container cmdlets.

        .NOTES
        Created by Trevor Sullivan <trevor@trevorsullivan.net>
        http://trevorsullivan.net
        #>
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        $ContainerList = Get-AzureStorageContainer -Context $fakeBoundParameter['Context'] | Where-Object -FilterScript { $PSItem.Name -match ${wordToComplete} } | ForEach-Object {
            $CompletionText = $PSItem.Name
            $ToolTip = 'Storage Container "{0}" in "{1}" Storage Account.' -f $PSItem.Name, $fakeBoundParameter['Context'].StorageAccountName
            $ListItemText = '{0} ({1})' -f $PSItem.Name, $fakeBoundParameter['Context'].StorageAccountName
            $CompletionResultType = [System.Management.Automation.CompletionResultType]::ParameterValue

            New-Object -TypeName System.Management.Automation.CompletionResult -ArgumentList @($CompletionText, $ListItemText, $CompletionResultType, $ToolTip);
        }

        return $ContainerList
        }
    }


Microsoft.PowerShell.Core\Register-ArgumentCompleter @ArgumentCompleter;