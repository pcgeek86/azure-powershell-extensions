function Remove-AzureRmResourceGui {
    <#
    .Synopsis
    Removes Azure Resource Manager (ARM) Resources, using a simple GUI.

    .Description
    Removes Azure Resource Manager (ARM) Resources, using a simple GUI.

    .Example
    Remove-AzureRmResourceGui
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
    )

    ### Prompt user to select a Microsoft Azure Storage Account to upload the file(s) to
    $ResourceList = Get-AzureRmResource | Out-GridView -OutputMode Multiple -Title 'Please select one or more Resources to delete';
    if (!$ResourceList) {
        throw 'No Azure Resources were selected. Please re-run the command and select one or more Microsoft Azure Resources.';
		return;
    }

    $ResourceList | Remove-AzureRmResource -Force;
}