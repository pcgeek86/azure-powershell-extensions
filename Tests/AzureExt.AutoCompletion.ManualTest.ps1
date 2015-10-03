<#
    .Synopsis
    Helper script for testing Microsoft Azure argument-completer functions for TabExpansion++.
#>
$AzureUsername = 'trevor@trevorsullivan.net';
$AzureCredential = Get-Credential -UserName $AzureUsername -Message 'Please enter your Microsoft Azure password.';
$AzureProfile = Login-AzureRMAccount -Credential $AzureCredential;

Import-Module -Name AzureExt -Force;

### Now test the argument completer(s). If changes are made simply re-run the script.