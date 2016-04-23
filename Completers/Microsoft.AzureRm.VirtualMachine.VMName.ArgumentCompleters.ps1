$ScriptBlock = {
        <#
        .SYNOPSIS
        Auto-complete the -StorageAccountName parameter value for Azure Resource Manager (ARM) PowerShell cmdlets.
    
        .NOTES
       
        Created by Trevor Sullivan <trevor@trevorsullivan.net>
        http://trevorsullivan.net
        #>
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        try {
            $StorageAccountList = Get-AzureRmVm | Where-Object -FilterScript { $PSItem.Name -match $wordToComplete } | ForEach-Object {
                $CompletionText = '{0} -ResourceGroupName {1}' -f $PSItem.Name, $PSItem.ResourceGroupName;
                $ToolTip = 'Storage Account "{0}" in "{1}" region.' -f $PSItem.Name, $PSItem.Location;
                $ListItemText = '{0} ({1})' -f $PSItem.Name, $PSItem.Location;
                $CompletionResultType = [System.Management.Automation.CompletionResultType]::ParameterValue;

                New-Object -TypeName System.Management.Automation.CompletionResult -ArgumentList @($CompletionText, $ListItemText, $CompletionResultType, $ToolTip);
            }

            return $StorageAccountList;
        }
        catch {
            Write-Host -Message ('Error occurred calling argument completer: {0}' -f $PSItem.Exception.Message);
        }
    };

$ArgumentCompleterList = @(
    @{
    CommandName = @(
        'Add-AzureRmVMAdditionalUnattendContent'
        'Add-AzureRmVMDataDisk'
        'Add-AzureRmVMNetworkInterface'
        'Add-AzureRmVMSecret'
        'Add-AzureRmVMSshPublicKey'
        'Get-AzureRmVM'
        'Get-AzureRmVMAccessExtension'
        'Get-AzureRmVMBootDiagnosticsData'
        'Get-AzureRmVMCustomScriptExtension'
        'Get-AzureRmVMDiagnosticsExtension'
        'Get-AzureRmVMDiskEncryptionStatus'
        'Get-AzureRmVMDscExtension'
        'Get-AzureRmVMDscExtensionStatus'
        'Get-AzureRmVMExtension'
        'Get-AzureRmVmExtensionImage'
        'Get-AzureRmVMExtensionImageType'
        'Get-AzureRmVMImage'
        'Get-AzureRmVMImageOffer'
        'Get-AzureRmVMImagePublisher'
        'Get-AzureRmVMImageSku'
        'Get-AzureRmVMSize'
        'Get-AzureRmVMSqlServerExtension'
        'Get-AzureRmVMUsage'
        'New-AzureRmVM'
        'New-AzureRmVMConfig'
        'Publish-AzureRmVMDscConfiguration'
        'Remove-AzureRmVM'
        'Remove-AzureRmVMAccessExtension'
        'Remove-AzureRmVMBackup'
        'Remove-AzureRmVMCustomScriptExtension'
        'Remove-AzureRmVMDataDisk'
        'Remove-AzureRmVMDiagnosticsExtension'
        'Remove-AzureRmVMDiskEncryptionExtension'
        'Remove-AzureRmVMDscExtension'
        'Remove-AzureRmVMExtension'
        'Remove-AzureRmVMNetworkInterface'
        'Remove-AzureRmVMSqlServerExtension'
        'Restart-AzureRmVM'
        'Save-AzureRmVMImage'
        'Set-AzureRmVM'
        'Set-AzureRmVMAccessExtension'
        'Set-AzureRmVMBackupExtension'
        'Set-AzureRmVMBootDiagnostics'
        'Set-AzureRmVMCustomScriptExtension'
        'Set-AzureRmVMDataDisk'
        'Set-AzureRmVMDiagnosticsExtension'
        'Set-AzureRmVMDiskEncryptionExtension'
        'Set-AzureRmVMDscExtension'
        'Set-AzureRmVMExtension'
        'Set-AzureRmVMOperatingSystem'
        'Set-AzureRmVMOSDisk'
        'Set-AzureRmVMSourceImage'
        'Set-AzureRmVMSqlServerExtension'
        'Start-AzureRmVM'
        'Stop-AzureRmVM'
        'Update-AzureRmVM'
    );
    ParameterName = 'Name';
    #Description = 'Complete the -Name parameter value for Azure Resource Manager (ARM) Virtual Machine cmdlets: Get-AzureRmVm -Name <TAB>';
    ScriptBlock = $ScriptBlock;
    };
)

foreach ($ArgumentCompleter in $ArgumentCompleterList) {
    Microsoft.PowerShell.Core\Register-ArgumentCompleter @ArgumentCompleter;
}