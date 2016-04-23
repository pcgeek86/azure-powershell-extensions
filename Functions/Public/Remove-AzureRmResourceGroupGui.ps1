function Remove-AzureRmResourceGroupGui {
    <#
    .Synopsis
    Removes Azure Resource Manager (ARM) Resource Groups, using a simple GUI.

    .Description
    

    .Example
    Remove-AzureRmResourceGroupGui
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
    )

    ### Prompt user to select a Microsoft Azure Storage Account to upload the file(s) to
    $ResourceGroupList = Get-AzureRmResourceGroup | Out-GridView -OutputMode Multiple -Title 'Please select one or more Resource Groups to delete';
    if (!$ResourceGroupList) {
        throw 'No Azure Resource Groups were selected. Please re-run the command and select one or more Microsoft Azure Resource Groups.';
    }

    $ResourceGroupList | Remove-AzureRmResourceGroup -Force;
}