function Invoke-AzureRmRemoteDesktop {
    <#
    .Author
    Trevor Sullivan <pcgeek86@gmail.com>

    .Description
    Invoke a RDP session to an Azure Virtual Machine, without having to type the
    Resource Group name or Virtual Machine name. Instead, simply select it from the 
	WPF window that pops open. This command is intended to work with the Azure 
    Resource Manager (ARM) PowerShell module, not Azure Service Management (ASM).

    .Outputs
    None

    .Links
    http://trevorsullivan.net
    http://twitter.com/pcgeek86
    #>
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $false, ParameterSetName = 'SpecifiedName')]
        [Alias('rgname')]
        [string] $ResourceGroupName
      , [Parameter(Position = 1, Mandatory = $false, ParameterSetName = 'SpecifiedName')]
        [string] $Name
    )

    $VM = Get-AzureRmVM -ErrorAction Stop | Out-GridView -PassThru -Title 'Select your Azure Virtual Machine';

    if (!$VM) { 
        Write-Warning -Message 'No virtual machines exist in this subscription, or no virtual machine was selected. Please create a virtual machine or select a different Azure subscription';
        return; 
    }

    Write-Verbose -Message ('Invoking Remote Desktop session to {0}\{1}' -f $VM.ResourceGroupName, $VM.Name);
    Get-AzureRmRemoteDesktopFile -ResourceGroupName $VM.ResourceGroupName -Name $VM.Name -Launch;
}