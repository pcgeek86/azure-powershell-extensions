function Start-AzureRm {
    <#
    .Synopsis
    Loads or creates a cached Azure Profile.

    .Description
    Loads a cached Azure Profile from disk, if it exists, otherwise the user is prompted to create it.
    
    This command has no parameters.

    .Example
    Start-AzureRm;
    #>
    [CmdletBinding()]
    param ()

    $script:AzureProfilePath = '{0}\AzureProfile.json' -f $env:USERPROFILE;
    try {
        ### Load the Azure Profile from the local disk
        $null = Select-AzureRmProfile -Path $script:AzureProfilePath;
        Find-AzureRmResourceGroup -Tag @{ Name = 'NonExistentTag'; } -WarningAction Ignore;
    } catch {
        $AzureProfile = Add-AzureRmAccount -Credential (Get-Credential);
        Save-AzureRmProfile -Path $script:AzureProfilePath -Profile $AzureProfile;
    }

    ### Import the PowerShell ISE Snippets, if we are running inside PowerShell ISE
    if ($Host.Name -match 'ISE') {
        Import-IseSnippet -Module AzureExt;
    }
}
