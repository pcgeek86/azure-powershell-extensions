#region Aliases
### This section contains aliases that will be exported from the module.

#region Azure Profile Aliases
$AliasList = @(
	@{  Name = 'aazac'; 
		Value = 'Add-AzureAccount';
		Description = 'Authenticate to Microsoft Azure Active Directory (AAD).'; }
	@{  Name = 'selazsub'; 
		Value = 'Select-AzureSubscription';
		Description = 'Select an Azure susbcription to perform automation tasks on.'; }
	@{  Name = 'gazsub'; 
		Value = 'Get-AzureSubscription';
		Description = 'Get a list of Azure subscriptions in the user''s local cache.'; }
	@{  Name = 'nazprof'; 
		Value = 'New-AzureProfile';
		Description = 'Creates a new Azure Profile'; }
	@{  Name = 'razprof'; 
		Value = 'New-AzureProfile';
		Description = 'Creates a new Azure Profile'; }
	@{  Name = 'clazprof'; 
		Value = 'Clear-AzureProfile';
		Description = 'Clears cached Azure Profiles'; }
	);

foreach ($Alias in $AliasList){
	New-Alias @Alias;
}
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

#region Functions

#region Public Functions
$FunctionList = Get-ChildItem -Path $PSScriptRoot\Functions\Public;
foreach ($Function in $FunctionList) {
	. $Function.FullName;
}
#endregion Public Functions

#region Private Functions
$FunctionList = Get-ChildItem -Path $PSScriptRoot\Functions\Private;
foreach ($Function in $FunctionList) {
	. $Function.FullName;
}
#endregion Private Functions

#endregion Functions

#region Import Argument Completers
$CompleterScriptList = Get-ChildItem -Path $PSScriptRoot\Completers;

foreach ($CompleterScript in $CompleterScriptList) {
    Write-Verbose -Message ('Import argument completer script: {0}' -f $CompleterScript.FullName);
    & $CompleterScript.FullName;
}
#endregion