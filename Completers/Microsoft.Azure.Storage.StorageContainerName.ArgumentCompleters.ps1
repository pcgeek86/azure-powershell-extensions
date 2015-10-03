$ArgumentCompleter = @{
        Command = @('Get-AzureStorageContainerAcl', 
                    'Get-AzureSiteRecoveryProtectionContainer', 
                    'Get-AzureStorageContainer', 
                    'New-AzureStorageContainer', 
                    'New-AzureStorageContainerSASToken', 
                    'Remove-AzureStorageContainer', 
                    'Set-AzureStorageContainerAcl');
        Parameter = 'Name';
        Description = 'Complete the -Name parameter value for Azure cmdlets:  Get-AzureStorageContainer -Context $Context -Name <TAB>';
        ScriptBlock = {
        <#
        .SYNOPSIS
        Auto-complete the -Name parameter value for Azure PowerShell storage container cmdlets.

        .NOTES
        Created by Trevor Sullivan <trevor@trevorsullivan.net>
        http://trevorsullivan.net
        #>
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        $CacheKey = 'AzureStorage_ContainerNameCache'
        $ContainerNameCache = Get-CompletionPrivateData -Key $CacheKey

        ### Return the cached value if it has not expired
        if ($ContainerNameCache) {
            return $ContainerNameCache
        }

        $ContainerList = Get-AzureStorageContainer -Context $fakeBoundParameter['Context'] | Where-Object -FilterScript { $PSItem.Name -match ${wordToComplete} } | ForEach-Object {
            $CompletionResult = @{
                CompletionText = $PSItem.Name
                ToolTip = 'Storage Container "{0}" in "{1}" Storage Account.' -f $PSItem.Name, $fakeBoundParameter['Context'].StorageAccountName
                ListItemText = '{0} ({1})' -f $PSItem.Name, $fakeBoundParameter['Context'].StorageAccountName
                CompletionResultType = [System.Management.Automation.CompletionResultType]::ParameterValue
                }
            New-CompletionResult @CompletionResult
        }

        Set-CompletionPrivateData -Key $CacheKey -Value $ContainerList
        return $ContainerList
        }
    }


TabExpansion++\Register-ArgumentCompleter @ArgumentCompleter;