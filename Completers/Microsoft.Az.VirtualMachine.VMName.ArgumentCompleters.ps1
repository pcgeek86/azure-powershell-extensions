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
            $StorageAccountList = Get-AzVm | Where-Object -FilterScript { $PSItem.Name -match $wordToComplete } | ForEach-Object {
                $CompletionText = '{0} -ResourceGroupName {1}' -f $PSItem.Name, $PSItem.ResourceGroupName;
                $ToolTip = 'Virtual Machine "{0}" in "{1}" region.' -f $PSItem.Name, $PSItem.Location;
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
        'Add-AzVMAdditionalUnattendContent'
        'Add-AzVMDataDisk'
        'Add-AzVMNetworkInterface'
        'Add-AzVMSecret'
        'Add-AzVMSshPublicKey'
        'Get-AzVM'
        'Get-AzVMAccessExtension'
        'Get-AzVMBootDiagnosticsData'
        'Get-AzVMCustomScriptExtension'
        'Get-AzVMDiagnosticsExtension'
        'Get-AzVMDiskEncryptionStatus'
        'Get-AzVMDscExtension'
        'Get-AzVMDscExtensionStatus'
        'Get-AzVMExtension'
        'Get-AzVmExtensionImage'
        'Get-AzVMExtensionImageType'
        'Get-AzVMImage'
        'Get-AzVMImageOffer'
        'Get-AzVMImagePublisher'
        'Get-AzVMImageSku'
        'Get-AzVMSize'
        'Get-AzVMSqlServerExtension'
        'Get-AzVMUsage'
        'New-AzVM'
        'New-AzVMConfig'
        'Publish-AzVMDscConfiguration'
        'Remove-AzVM'
        'Remove-AzVMAccessExtension'
        'Remove-AzVMBackup'
        'Remove-AzVMCustomScriptExtension'
        'Remove-AzVMDataDisk'
        'Remove-AzVMDiagnosticsExtension'
        'Remove-AzVMDiskEncryptionExtension'
        'Remove-AzVMDscExtension'
        'Remove-AzVMExtension'
        'Remove-AzVMNetworkInterface'
        'Remove-AzVMSqlServerExtension'
        'Restart-AzVM'
        'Save-AzVMImage'
        'Set-AzVM'
        'Set-AzVMAccessExtension'
        'Set-AzVMBackupExtension'
        'Set-AzVMBootDiagnostics'
        'Set-AzVMCustomScriptExtension'
        'Set-AzVMDataDisk'
        'Set-AzVMDiagnosticsExtension'
        'Set-AzVMDiskEncryptionExtension'
        'Set-AzVMDscExtension'
        'Set-AzVMExtension'
        'Set-AzVMOperatingSystem'
        'Set-AzVMOSDisk'
        'Set-AzVMSourceImage'
        'Set-AzVMSqlServerExtension'
        'Start-AzVM'
        'Stop-AzVM'
        'Update-AzVM'
        'Invoke-AzRemoteDesktop'
    );
    ParameterName = 'Name';
    ScriptBlock = $ScriptBlock;
    };
)

foreach ($ArgumentCompleter in $ArgumentCompleterList) {
    Microsoft.PowerShell.Core\Register-ArgumentCompleter @ArgumentCompleter;
}
