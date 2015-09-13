<#
	.Author
	Trevor Sullivan <trevor@trevorsullivan.net>
	.Description
	Publishes the PowerShell module to the PowerShell Gallery.
	This PowerShell script is invoked by AppVeyor after the "Deploy" phase has completed successfully.
#>

function Patch-ModuleManifest {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $false)] 
        [string] $Path
	  , [string] $BuildNumber
	)

	if (!$Path) {
		$Path = Get-ChildItem -Path $env:APPVEYOR_BUILD_FOLDER\* -Include *.psd1;
		if (!$Path) { throw 'Could not find a module manifest file'; }
	}

	$ManifestContent = Get-Content -Path $Path -Raw;
	$ManifestContent = $ManifestContent -replace '(?<=ModuleVersion\s+=\s+'')(?<ModuleVersion>.*)(?='')', ('${{ModuleVersion}}.{0}' -f $BuildNumber);
	Set-Content -Path $Path -Value $ManifestContent;

	$ManifestContent -match '(?<=ModuleVersion\s+=\s+'')(?<ModuleVersion>.*)(?='')';
	Write-Verbose -Message ('Module Version patched: ' + $Matches.ModuleVersion);
}