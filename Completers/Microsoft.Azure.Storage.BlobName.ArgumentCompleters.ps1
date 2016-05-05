$ScriptBlock = {
        <#
        .SYNOPSIS
        Auto-complete the -Name parameter value for Azure PowerShell storage container cmdlets.

        .NOTES
        Created by Trevor Sullivan <trevor@trevorsullivan.net>
        http://trevorsullivan.net
        #>
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        $StorageContext = $fakeBoundParameter['Context'];
        $ContainerList = Get-AzureStorageContainer -Context $StorageContext;
        $BlobList = @();
        foreach ($Container in $ContainerList) {
            foreach ($Blob in (Get-AzureStorageBlob -Context $StorageContext -Container $Container.Name)) {
                $BlobList += $Blob | Add-Member -MemberType NoteProperty -Name ContainerName -Value $Container.Name -PassThru;
            }
        }

        $BlobList = $BlobList | Where-Object -FilterScript { $PSItem.Name -match ${wordToComplete} } | ForEach-Object {
            $CompletionText = '{0} -ContainerName {1}' -f $PSItem.Name, $PSItem.ContainerName;
            $ToolTip = 'Blob named "{0}" in "{1}" container.' -f $PSItem.Name, $PSItem.ContainerName;
            $ListItemText = '{0} ({1})' -f $PSItem.Name, $PSItem.ContainerName;
            $CompletionResultType = [System.Management.Automation.CompletionResultType]::ParameterValue;

            New-Object -TypeName System.Management.Automation.CompletionResult -ArgumentList @($CompletionText, $ListItemText, $CompletionResultType, $ToolTip);
        }

        return $BlobList;
        }

$ArgumentCompleter = @{
        ### (Get-Command -Module Azure.Storage -ParameterName Container).ForEach({ "'{0}'," -f $PSItem.Name; }) | Set-Clipboard;
        CommandName = @(
            'Stop-CopyAzureStorageBlob',
            'Get-AzureStorageBlob',
            'Get-AzureStorageBlobContent',
            'Get-AzureStorageBlobCopyState',
            'New-AzureStorageBlobSASToken',
            'Remove-AzureStorageBlob',
            'Set-AzureStorageBlobContent',
            'Stop-AzureStorageBlobCopy'
        );
        ParameterName = 'Blob';
        ScriptBlock = $ScriptBlock;
    }

Microsoft.PowerShell.Core\Register-ArgumentCompleter @ArgumentCompleter;
