#
# Get_AllAzureLocations.ps1
#

function Get-AllAzureLocations {
    <#
    .Synopsis
    Retrieves a list of Azure locations, using the AzureResourceManager PowerShell module.

    .Description

    This function may be deprecated, or require modification, if the Get-AzureLocation command is changed
    from returning Azure platform features, to returning Azure locations. As of this implementation, the
    ARM Get-AzureLocation command returns a list of Azure Resource Providers as the top-level object.
    #>
    [CmdletBinding()]
    param ()

    $LocationList = (AzureResourceManager\Get-AzureLocation).Locations | Select-Object -Unique | Sort-Object;
    Write-Output -InputObject $LocationList;
}