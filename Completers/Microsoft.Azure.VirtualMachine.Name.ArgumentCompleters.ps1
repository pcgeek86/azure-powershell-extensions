$ArgumentCompleter = @{
    CommandName = @('Export-AzureVM', 
                'Get-AzureVM', 
                'Remove-AzureVM', 
                'Restart-AzureVM', 
                'Start-AzureVM', 
                'Stop-AzureVM', 
                'Update-AzureVM',
                'Get-AzureRemoteDesktopFile');
    ParameterName = 'Name';
    #Description = 'Complete the -Name parameter value for Azure virtual machine cmdlets:  Stop-AzureVM -Name <TAB>';
    ScriptBlock = {
        <#
        .SYNOPSIS
        Auto-complete the -Name parameter value for Azure PowerShell virtual machine cmdlets.

        .NOTES
        Created by Trevor Sullivan <trevor@trevorsullivan.net>
        http://trevorsullivan.net
        http://twitter.com/pcgeek86
        #>
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        #Write-Verbose -Message ('Called Azure Virtual Machine Name completer at {0}' -f (Get-Date))

        ### Attempt to read Azure virtual machine details from the cache
        $CacheKey = 'AzureVirtualMachine_NameCache'
        $VirtualMachineNameCache = Get-CompletionPrivateData -Key $CacheKey

        ### If there is a valid cache for the Azure virtual machine names, then go ahead and return them immediately
        if ($VirtualMachineNameCache -and (Get-Date) -gt $VirtualMachineNameCache.ExpirationTime) {
            return $VirtualMachineNameCache
        }

        ### Create fresh completion results for Azure virtual machines
        $ItemList = Get-AzureVM | Where-Object { $PSItem.Name -match $wordToComplete } | ForEach-Object {
            $CompletionResult = @{
                CompletionText = '{0} -ServiceName {1}' -f $PSItem.Name, $PSItem.ServiceName
                ToolTip = 'Azure VM {0}/{1} in state {2}.' -f $PSItem.ServiceName, $PSItem.Name, $PSItem.Status
                ListItemText = '{0}/{1}' -f $PSItem.ServiceName, $PSItem.Name
                CompletionResultType = [System.Management.Automation.CompletionResultType]::ParameterValue
                NoQuotes = $true
                }
            New-CompletionResult @CompletionResult
        }
    
        ### Update the cache for Azure virtual machines
        Set-CompletionPrivateData -Key $CacheKey -Value $ItemList

        ### Return the fresh completion results
        return $ItemList
    }
}

Microsoft.PowerShell.Core\Register-ArgumentCompleter @ArgumentCompleter;