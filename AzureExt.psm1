#region Aliases
### This section contains 
#region Azure Profile Aliases
New-Alias -Name aazac -Value Add-AzureAccount -Description 'Authenticate to Microsoft Azure Active Directory (AAD).';
New-Alias -Name selazsub -Value Select-AzureSubscription -Description 'Select an Azure susbcription to perform automation tasks on.';
New-Alias -Name gazsub -Value Get-AzureSusbcription -Description 'Get a list of Azure subscriptions in the user''s local cache.';
New-Alias -Name sazsub -Value Set-AzureSubscription -Description 'Reconfigure an Azure subscription.';
#endregion

#region Azure Service Management (ASM) Aliases
New-Alias -Name nazvm -Value New-AzureVM -Description 'Create an Azure Virtual Machine from a VM configuration object.';
New-Alias -Name nazvmc -Value New-AzureVMConfig -Description 'Create an Azure Virtual Machine configuration object.';

New-Alias -Name nazsa -Value New-AzureStorageAccount -Description 'Create an Azure Storage Account.';
New-Alias -Name razsa -Value Remove-AzureStorageAccount -Description 'Remove an Azure Storage Account.';

New-Alias -Name nazsqlsrv -Value New-AzureSqlDatabaseServer -Description 'Create an Azure SQL Database Server.';
New-Alias -Name razsqlsrv -Value Remove-AzureSqlDatabaseServer -Description 'Remove an Azure SQL Database Server.';
#endregion

#region Azure Resource Manager (ARM) Aliases
#endregion

#endregion