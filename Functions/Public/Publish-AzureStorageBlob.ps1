function Publish-AzureStorageBlob {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
    )

    ### Load the Windows Forms .NET Assembly
    Add-Type -AssemblyName System.Windows.Forms;
    $OpenFileDialog = New-Object -TypeName System.Windows.Forms.OpenFileDialog;
    $OpenFileDialog.Multiselect = $true;
    $DialogResult = $OpenFileDialog.ShowDialog();
    if ($DialogResult -ne [System.Windows.Forms.DialogResult]::OK) {
        throw 'Please select one or more files to upload to the Microsoft Azure blob storage container.';
    }

    ### Prompt user to select a Microsoft Azure Storage Account to upload the file(s) to
    $StorageAccount = Get-AzureRmStorageAccount | Select-Object -Property StorageAccountName, Location, AffinityGroup | Out-GridView -OutputMode Single;
    if (!$StorageAccount) {
        throw 'No Azure Storage Account was selected. Please re-run the command and select a Microsoft Azure Storage Account.';
    }
    $StorageKey = Get-AzureRmStorageKey -StorageAccountName $StorageAccount.StorageAccountName;
    $StorageContext = New-AzureStorageContext -StorageAccountName $StorageKey.StorageAccountName -StorageAccountKey $StorageKey.Primary;
    
    ### Prompt user to select a Microsoft Azure Blob Container (inside the Storage Account) to upload the file(s) to
    $ContainerList = Get-AzureStorageContainer -Context $StorageContext;
    $Container = $ContainerList | Out-GridView -Title 'Please select a target Microsoft Azure blob storage container.' -OutputMode Single;

    ### If the user does not select a container, then prompt the user to create a new one.
    if (!$Container) {
        $ContainerName = Read-Host -Prompt 'Please enter a container name';
        if ($ContainerList.Name -notcontains $ContainerName) {
            $Container = New-AzureStorageContainer -Context $StorageContext -Name $ContainerName;
        }
        else {
            throw 'Container named {0} already exists in Storage Account {1}. Please re-run the command and use a different container name.' -f $ContainerName, $StorageAccount.StorageAccountName;
        }
    }

    foreach ($File in $OpenFileDialog.FileNames) {
        Write-Verbose -Message ('Uploading file {0} to {1}/{2}' -f $File, $StorageAccount.StorageAccountName, $Container.Name);
        if ($PSCmdlet.ShouldProcess($File, 'Upload to Azure blob storage')) {
            try {
                Set-AzureStorageBlobContent -Context $StorageContext -Container $Container.Name -File $File -ErrorAction Stop;
            }
            catch {
                Write-Warning -Message ('Failed to copy {0} to Azure blob container' -f $File);
            }
        }
    }
}