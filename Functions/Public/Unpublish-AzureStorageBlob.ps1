function Unpublish-AzureStorageBlob {
    <#
    .Synopsis
    Removes Azure blobs from a blob container in an Azure Storage Account using a simple, graphical interface.

    .Description
    This command uses the built-in PowerShell v3.0 (and later) Out-GridView command to prompt the user for an 
    array of Azure Storage Blobs to remove from the Azure Blob Storage Container.

    .Example
    Unpublish-AzureStorageBlob;
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
    )

    ### Prompt user to select a Microsoft Azure Storage Account to upload the file(s) to
    $StorageAccount = Get-AzureStorageAccount | Select-Object -Property StorageAccountName, Location, AffinityGroup | Out-GridView -OutputMode Single;
    if (!$StorageAccount) {
        throw 'No Azure Storage Account was selected. Please re-run the command and select a Microsoft Azure Storage Account.';
    }
    $StorageKey = Get-AzureStorageKey -StorageAccountName $StorageAccount.StorageAccountName;
    $StorageContext = New-AzureStorageContext -StorageAccountName $StorageKey.StorageAccountName -StorageAccountKey $StorageKey.Primary;
    
    ### Prompt user to select a Microsoft Azure Blob Container (inside the Storage Account) to upload the file(s) to
    $ContainerList = Get-AzureStorageContainer -Context $StorageContext;
    $Container = $ContainerList | Out-GridView -Title 'Please select a target Microsoft Azure blob storage container.' -OutputMode Single;

    ### Retrieve list of blobs inside blob container
    $BlobList = Get-AzureStorageBlob -Context $StorageContext -Container $Container.Name;

    ### If there are no blobs in the container, then throw an exception and exit function
    if (!$BlobList) {
        throw 'No blobs found in {0}/{1}' -f $StorageAccount.StorageAccountName, $Container.Name;
        return;
    }

    ### Prompt user to select Azure Storage Blobs to remove.
    $BlobList = $BlobList | Out-GridView -Title 'Please select the Azure Storage Blobs to remove.' -OutputMode Multiple;

    ### Remove each Azure blob that was selected by the user
    foreach ($Blob in $BlobList) {
        Write-Verbose -Message ('Removing blob {0} from {1}/{2}' -f $Blob.Name, $StorageAccount.StorageAccountName, $Container.Name);
        if ($PSCmdlet.ShouldProcess($Blob.Name, 'Remove Azure Storage blob')) {
            try {
                Remove-AzureStorageBlob -Context $StorageContext -Container $Container.Name -Blob $Blob.Name -Force;
            }
            catch {
                Write-Warning -Message ('Failed to remove Azure Storage blob' -f $Blob.Name);
            }
        }
    }
}