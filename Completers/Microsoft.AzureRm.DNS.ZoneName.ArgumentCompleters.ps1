$ScriptBlock = {
        <#
        .SYNOPSIS
        Auto-complete the -ZoneName parameter value for Azure Resource Manager (ARM) PowerShell cmdlets.

        .NOTES
        Created by Trevor Sullivan <trevor@trevorsullivan.net>
        https://trevorsullivan.net
        #>
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        try {
            $ObjectList = Get-AzureRmDnsZone -ResourceGroupName $fakeBoundParameter["ResourceGroupName"] -ErrorAction Stop -WarningAction Ignore;
        } catch {
            Write-Host -Object ('Error occurred retrieving DNS Zones: {0}' -f $PSItem.Exception.Message);
        }
        $ItemList = $ObjectList | Where-Object { $PSItem.Name -match $wordToComplete } | ForEach-Object {
            $CompletionText = '{0}' -f $PSItem.Name;
            $ToolTip = 'DNS Zone {0} in {1} Resource Group.' -f $PSItem.Name, $PSItem.ResourceGroupName;
            $ListItemText = '{0}' -f $PSItem.Name;
            $CompletionResultType = [System.Management.Automation.CompletionResultType]::ParameterValue;

            New-Object -TypeName System.Management.Automation.CompletionResult -ArgumentList @($CompletionText, $ListItemText, $CompletionResultType, $ToolTip);
        }

        return $ItemList
    }

$ArgumentCompleter = @{
        CommandName = @(
			'Get-AzureRmDnsRecordSet',
			'New-AzureRmDnsRecordSet',
			'Remove-AzureRmDnsRecordSet'
		);
        ParameterName = 'ZoneName';
        ScriptBlock = $ScriptBlock;
}

Microsoft.PowerShell.Core\Register-ArgumentCompleter @ArgumentCompleter;

$ArgumentCompleter = @{
        CommandName = @(
			'Get-AzureRmDnsZone',
			'New-AzureRmDnsZone',
			'Remove-AzureRmDnsZone',
			'Set-AzureRmDnsZone'
		);
        ParameterName = 'Name';
        ScriptBlock = $ScriptBlock;
}

Microsoft.PowerShell.Core\Register-ArgumentCompleter @ArgumentCompleter;