$ScriptBlock = {
        <#
        .SYNOPSIS
        Auto-complete the -Name parameter value for Azure Resource Manager (ARM) PowerShell cmdlets for Virtual Networking.
    
        .NOTES
       
        Created by Trevor Sullivan <trevor@trevorsullivan.net>
        http://trevorsullivan.net
        #>
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        try {
            $CompletionList = Get-AzVirtualNetwork | Where-Object -FilterScript { $PSItem.Name -match $wordToComplete } | ForEach-Object {
                $CompletionText = '{0} -ResourceGroupName {1}' -f $PSItem.Name, $PSItem.ResourceGroupName;
                $ToolTip = 'Virtual Network "{0}" in "{1}" region, member of "{2}" Resource Group.' -f $PSItem.Name, $PSItem.Location, $PSItem.ResourceGroup;
                $ListItemText = '{1} ({0}, {2})' -f $PSItem.ResourceGroupName, $PSItem.Name, $PSItem.Location;
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
    CommandName = @(
        'Get-AzLocalNetworkGateway'
        'Get-AzVirtualNetwork'
        'Get-AzVirtualNetworkGateway'
        'Get-AzVirtualNetworkGatewayConnection'
        'Get-AzVirtualNetworkGatewayConnectionSharedKey'
        'New-AzVirtualNetwork'
        'New-AzVirtualNetworkGateway'
        'New-AzVirtualNetworkGatewayConnection'
        'New-AzVirtualNetworkSubnetConfig'
        'Remove-AzVirtualNetwork'
        'Remove-AzVirtualNetworkGateway'
        'Remove-AzVirtualNetworkGatewayConnection'
        'Reset-AzVirtualNetworkGatewayConnectionSharedKey'
        'Set-AzVirtualNetworkGatewayConnectionSharedKey'
    );
    ParameterName = 'Name';
    #Description = 'Complete the -Name parameter value for Azure Resource Manager (ARM) Virtual Network cmdlets: Get-AzVirtualNetwork -Name <TAB>';
    ScriptBlock = $ScriptBlock;
    };
)

foreach ($ArgumentCompleter in $ArgumentCompleterList) {
    Microsoft.PowerShell.Core\Register-ArgumentCompleter @ArgumentCompleter;
}