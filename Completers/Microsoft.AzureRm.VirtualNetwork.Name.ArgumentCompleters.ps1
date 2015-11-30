$ScriptBlock = {
        <#
        .SYNOPSIS
        Auto-complete the -Name parameter value for Azure Resource Manager (ARM) PowerShell cmdlets for Virtual Networking.
    
        .NOTES
       
        Created by Trevor Sullivan <trevor@trevorsullivan.net>
        http://trevorsullivan.net
        #>
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        $CacheKey = 'RmVirtualNetwork_NameCache';
        $Cache = Get-CompletionPrivateData -Key $CacheKey;

        ### Return the cached value if it has not expired
        if ($Cache) { return $Cache; }

        try {
            $CompletionList = Get-AzureRmVirtualNetwork | Where-Object -FilterScript { $PSItem.Name -match $wordToComplete } | ForEach-Object {
                $CompletionResult = @{
                    CompletionText = '{0} -ResourceGroupName {1}' -f $PSItem.Name, $PSItem.ResourceGroupName;
                    ToolTip = 'Virtual Network "{0}" in "{1}" region, member of "{2}" Resource Group.' -f $PSItem.Name, $PSItem.Location, $PSItem.ResourceGroup;
                    ListItemText = '{0}\{1} ({2})' -f $PSItem.ResourceGroupName, $PSItem.Name, $PSItem.Location;
                    CompletionResultType = [System.Management.Automation.CompletionResultType]::ParameterValue;
                    NoQuotes = $true;
                    }
                New-CompletionResult @CompletionResult;
            }

            Set-CompletionPrivateData -Key $CacheKey -Value $CompletionList;
            return $CompletionList;
        }
        catch {
            Write-Host -Message ('Error occurred calling argument completer: {0}' -f $PSItem.Exception.Message);
        }
    };

$ArgumentCompleterList = @(
    @{
    Command = @(
        'Get-AzureRmLocalNetworkGateway'
        'Get-AzureRmVirtualNetwork'
        'Get-AzureRmVirtualNetworkGateway'
        'Get-AzureRmVirtualNetworkGatewayConnection'
        'Get-AzureRmVirtualNetworkGatewayConnectionSharedKey'
        'New-AzureRmVirtualNetwork'
        'New-AzureRmVirtualNetworkGateway'
        'New-AzureRmVirtualNetworkGatewayConnection'
        'New-AzureRmVirtualNetworkSubnetConfig'
        'Remove-AzureRmVirtualNetwork'
        'Remove-AzureRmVirtualNetworkGateway'
        'Remove-AzureRmVirtualNetworkGatewayConnection'
        'Reset-AzureRmVirtualNetworkGatewayConnectionSharedKey'
        'Set-AzureRmVirtualNetworkGatewayConnectionSharedKey'
    );
    Parameter = 'Name';
    Description = 'Complete the -Name parameter value for Azure Resource Manager (ARM) Virtual Network cmdlets: Get-AzureRmVirtualNetwork -Name <TAB>';
    ScriptBlock = $ScriptBlock;
    };
)

foreach ($ArgumentCompleter in $ArgumentCompleterList) {
    TabExpansion++\Register-ArgumentCompleter @ArgumentCompleter;
}