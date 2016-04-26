function Resize-AzureRmVm {
    <#
    .Synopsis
    Resizes Microsoft Azure Virtual Machines to a new size.

    .Description
    This command resizes Microsoft Azure Virtual Machines. Use the Get-AzureRmVmSize command to determine an authoritative list of supported Azure Virtual Machine sizes.

    .Example

    ### Resize multiple Azure Virtual Machines at once
    Resize-AzureRmVm -Gui;

    .Example

    ### Resize a single Azure Virtual Machine
    Resize-AzureRmVm -ResourceGroupName MyCoolResourceGroup -Name UbuntuVM -Size Standard_A4;

    .Example

    ### Resize an Azure Virtual Machine using pipelining
    Get-AzureRmVm -ResourceGroupName LinuxStuff -Name Ubuntu | Resize-AzureRmVm -Size Standard_A2;

    .Link
    https://trevorsullivan.net
    https://artofshell.com
    #>
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, Mandatory = $true, ParameterSetName = 'VM', HelpMessage = 'Please enter the name of the Azure Resource Group where the Virtual Machine lives')]
        [string] $ResourceGroupName
      , [Parameter(ValueFromPipelineByPropertyName = $true, Mandatory = $true, ParameterSetName = 'VM', HelpMessage = 'Please enter the name of the Azure VM in the Resource Group')]
        [string] $Name
      , [Parameter(Mandatory = $true, ParameterSetName = 'VM', HelpMessage = 'Please specify the Azure VM size you want to configure this VM with')]
        [ValidateScript({
            $VMSizeList = (Get-AzureRmVmSize -Location westus).Name;
            if ($VMSizeList -contains $_) { return true; }
            else { throw 'Please select one of the following VM sizes: {0}' -f ($VMSizeList -join ', '); return false; }
        })]
        [string] $Size
      , [Parameter(ParameterSetName = 'Gui', Mandatory = $true)]
        [switch] $Gui
    )

    process {
        try {        
            if ($PSCmdlet.ParameterSetName -eq 'Gui') {
                $VMList = Get-AzureRmVm | Out-GridView -OutputMode Multiple -Title 'Please select an Azure Virtual Machine to resize.';
                $TargetSize = Get-AzureRmVmSize | Out-GridView -OutputMode Single -Title 'Please select a target Azure Virtual Machine size.';
                foreach ($VM in $VMList) {
                    Write-Verbose -Message ('Resizing Microsoft Azure Virtual Machine {0} in Resource Group {1} to size {2}' -f $VM.Name, $VM.ResourceGroupName, $TargetSize);
                    $VM.HardwareProfile.VmSize = $TargetSize.Name;
                    Update-AzureRmVm -VM $VM -ResourceGroupName $VM.ResourceGroupName
                }
            }
            else {
                Write-Verbose -Message ('Resizing Microsoft Azure Virtual Machine {0} in Resource Group {1} to size {2}' -f $Name, $ResourceGroupName, $Size);
                $VM = Get-AzureRmVm -ResourceGroupName $ResourceGroupName -Name $Name;
                $VM.HardwareProfile.VmSize = $Size;
                Update-AzureRmVm -ResourceGroupName $VM.ResourceGroupName -VM $VM;
            }
        }
        catch {
            throw 'An error occurred while trying to resize the VM {0}\{1}: {2}' -f $ResourceGroupName, $Name, $PSItem.Exception.Message
        }
    }
}