function Resize-AzureRmVm {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = 'Please enter the name of the Azure Resource Group where the Virtual Machine lives')]
        [string] $ResourceGroupName
      , [Parameter(Mandatory = $true, HelpMessage = 'Please enter the name of the Azure VM in the Resource Group')]
        [string] $Name
      , [Parameter(Mandatory = $true, HelpMessage = 'Please specify the Azure VM size you want to configure this VM with')]
        [ValidateScript({
            $VMSizeList = (Get-AzureRmVmSize -Location westus).Name;
            if ($VMSizeList -contains $_) { return true; }
            else { return false; }
        })]
        [string] $Size
    )

    try {
        Write-Verbose -Message ('Resizing Microsoft Azure Virtual Machine {0} in Resource Group {1} to size {2}' -f $Name, $ResourceGroupName, $Size);
        $VM = Get-AzureRmVm -ResourceGroupName $ResourceGroupName -Name $Name;
        $VM.HardwareProfile.VmSize = $Size;
        Update-AzureRmVm -ResourceGroupName $ResourceGroupName -VM $VM;
    }
    catch {
        throw 'An error occurred while trying to resize the VM {0}\{1}: {2}' -f $ResourceGroupName, $Name, $PSItem.Exception.Message
    }
}