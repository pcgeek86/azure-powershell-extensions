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
        [Parameter(Mandatory = $false, ParameterSetName = 'SpecifiedName')]
        [switch] $PromptSubscription
      , [Parameter(Position = 0, Mandatory = $false, ParameterSetName = 'SpecifiedName')]
        [Alias('rgname')]
        [string] $ResourceGroupName
      , [Parameter(Position = 1, Mandatory = $false, ParameterSetName = 'SpecifiedName')]
        [string] $Name
      , [Parameter(Position = 2, Mandatory = $false, ParameterSetName = 'SpecifiedName')]
        [Alias('sn')]
        [string] $SubscriptionName
    )

    function Wait-AzureVM {
        param (
            [Parameter(Mandatory = $true)]
            [string] $ServiceName
          , [Parameter(Mandatory = $true)]
            [string] $Name
          , [int] $WaitInSeconds = 10
          , [string] $State = 'ReadyRole'
        )
        
        while (($VM = Get-AzureRMVM -ServiceName $ServiceName -Name $Name).Status -ne $State) {
            Start-Sleep -Seconds $WaitInSeconds;
            Write-Verbose -Message ('Virtual machine state {0}/{1} is {2}' -f $ServiceName, $Name, $VM.Status);
            $UserResult = $null;
            $UserResult = @('Yes', 'No') | Out-GridView -Title ('Keep waiting for {0} seconds?' -f $WaitInSeconds) -OutputMode Single;
            if (!$UserResult -or $UserResult -eq 'No') {
                throw 'User canceled waiting for VM to start up.';
                return $false;
            }
        }
        Write-Verbose -Message ('Virtual machine {0}/{1} is up and running' -f $ServiceName, $Name);
        return $true;
    }

    function PromptSubscription {
        Write-Verbose -Message 'Prompting for Azure subscription.';
        $SubscriptionList = Get-AzureSubscription;
        if (!$SubscriptionList) {
            & $AzureReauthenticate;
        }

        $Subscription = $SubscriptionList | Select-Object -Property SubscriptionName,SubscriptionId | Out-GridView -PassThru -Title 'Select your Azure Subscription';
        if (!$Subscription) {
            Write-Warning -Message 'No Azure subscription was selected.';
            return; 
        }
        Select-AzureSubscription -SubscriptionName $Subscription.SubscriptionName;
    }

    $AzureReauthenticate = {
        $AuthResult = Add-AzureAccount 3>&1;

        if ($AuthResult -match 'User canceled authentication') {
            Write-Error -Message 'User canceled authentication, exiting function.';
            return;
        }

        # Re-invoke the azrdp function using the same arguments that the user passed in originally
        $Parameters = (Get-PSCallStack)[1].InvocationInfo.BoundParameters;
        & $PSCmdlet.MyInvocation.MyCommand.Name @Parameters;
    }

    try {
        if ($PromptSubscription) {
            PromptSubscription;
        }

        $VM = Get-AzureRmVM -ErrorAction Stop | Out-GridView -PassThru -Title 'Select your Azure Virtual Machine';

        if (!$VM) { 
            Write-Warning -Message 'No virtual machines exist in this subscription, or no virtual machine was selected. Please create a virtual machine or select a different Azure subscription';
            return; 
        }
        if ($VM.Status -ne 'ReadyRole') {
            Write-Warning -Message 'The selected Azure virtual machine is not in the ReadyRole state.';
            $OperationList = @(
                [PSCustomObject]@{ Name = 'Start'; Description = 'Start the Microsoft Azure Virtual Machine'; };
                [PSCustomObject]@{ Name = 'Select New'; Description = 'Select a new Microsoft Azure Virtual Machine'; };
                [PSCustomObject]@{ Name = 'Exit'; Description = 'Quit / exit this function'; };
                );
            $Operation = $OperationList | Out-GridView -OutputMode Single;
            if ($Operation.Name -eq 'Start') {
                ### Start the VM using Azure Resource Manager (ARM) instead of Service Management,
                ### if the VM is an IaaSv2 VM.
                if ($VM.ResourceGroupName -and $VM.Name) {
                    Start-AzureRmVM -ResourceGroupName $VM.ResourceGroupName -Name $VM.Name; } 
                elseif ($VM.ServiceName -and $VM.Name) {
                    Start-AzureRmVM -ResourceGroupName $VM.ResourceGroupName -Name $VM.Name; }


                if (Wait-AzureVM -ServiceName $VM.ServiceName -Name $VM.Name) {
                    Get-AzureRemoteDesktopFile -ServiceName $VM.ServiceName -Name $VM.Name -Launch;
                }
                return;
            }
            elseif ($Operation.Name -eq 'Exit') {
                Write-Warning -Message 'User elected to quit the function.';
                return;
            }
            elseif ($Operation.Name -eq 'Select New') {
                & $PSCmdlet.MyInvocation.MyCommand.Name @PSBoundParameters;
                return;
            }
        }

        Write-Verbose -Message ('Invoking Remote Desktop session to {0}\{1}' -f $VM.ResourceGroupName, $VM.Name);
        Get-AzureRmRemoteDesktopFile -ResourceGroupNaem $VM.ResourceGroupName -Name $VM.Name -Launch;
    }
    catch [System.ArgumentException] {
        if ($PSItem.Exception.Message -match 'Add-AzureAccount') {
            & $AzureReauthenticate;
        }
    }
    catch [System.ApplicationException] {
        if ($PSItem.Exception.Message -match 'No default subscription') {
            & $AzureReauthenticate;
        }
    }
}