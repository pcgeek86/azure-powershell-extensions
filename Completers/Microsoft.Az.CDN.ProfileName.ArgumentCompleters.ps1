$ScriptBlock = {
        <#
        .SYNOPSIS
        Auto-complete the -ProfileName parameter value for Azure Resource Manager (ARM) PowerShell cmdlets for Azure CDN.
    
        .NOTES
       
        Created by Trevor Sullivan <trevor@trevorsullivan.net>
        http://trevorsullivan.net
        #>
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        try {
            $CompletionList = Get-AzCdnProfile | Where-Object -FilterScript { $PSItem.Name -match $wordToComplete } | ForEach-Object {
                $CompletionText = '{0} -ResourceGroupName {1}' -f $PSItem.Name, $PSItem.ResourceGroupName;
                $ToolTip = 'Redis Cache "{0}" in "{1}" region, member of "{2}" Resource Group.' -f $PSItem.Name, $PSItem.Location, $PSItem.ResourceGroupName;
                $ListItemText = '{0} ({1}, {2})' -f $PSItem.Name, $PSItem.ResourceGroupName, $PSItem.Location;
                $CompletionResultType = [System.Management.Automation.CompletionResultType]::ParameterValue;

                New-Object -TypeName System.Management.Automation.CompletionResult -ArgumentList @($CompletionText, $ListItemText, $CompletionResultType, $ToolTip);
            }

            return $CompletionList;
        }
        catch {
            Write-Host -Message ('Error occurred calling argument completer: {0}' -f $PSItem.Exception.Message);
        }
    };

$ArgumentCompleterList = @(
    @{
    # Use this command to regenerate the list of commands below, in case it changes.
    # (Get-Command -Module Az.Cdn -ParameterName ProfileName).Name | % { "'{0}'" -f $_ }
    CommandName = @(
        'Validate-AzCdnCustomDomain'
        'Disable-AzCdnCustomDomain'
        'Disable-AzCdnCustomDomainHttps'
        'Enable-AzCdnCustomDomain'
        'Enable-AzCdnCustomDomainHttps'
        'Get-AzCdnCustomDomain'
        'Get-AzCdnEndpoint'
        'Get-AzCdnEndpointResourceUsage'
        'Get-AzCdnOrigin'
        'Get-AzCdnProfile'
        'Get-AzCdnProfileResourceUsage'
        'Get-AzCdnProfileSsoUrl'
        'Get-AzCdnProfileSupportedOptimizationType'
        'New-AzCdnCustomDomain'
        'New-AzCdnEndpoint'
        'New-AzCdnProfile'
        'Publish-AzCdnEndpointContent'
        'Remove-AzCdnCustomDomain'
        'Remove-AzCdnEndpoint'
        'Remove-AzCdnProfile'
        'Start-AzCdnEndpoint'
        'Stop-AzCdnEndpoint'
        'Test-AzCdnCustomDomain'
        'Unpublish-AzCdnEndpointContent'
    );
    ParameterName = 'ProfileName';
    ScriptBlock = $ScriptBlock;
    };
)

foreach ($ArgumentCompleter in $ArgumentCompleterList) {
    Microsoft.PowerShell.Core\Register-ArgumentCompleter @ArgumentCompleter;
}