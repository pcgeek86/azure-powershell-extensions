$ScriptBlock = {
        <#
        .SYNOPSIS
        Auto-complete the -CollationName parameter value for Azure Resource Manager (ARM) PowerShell cmdlets.

        .NOTES
        Created by Trevor Sullivan <trevor@trevorsullivan.net>
        https://trevorsullivan.net
        #>
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

		$ObjectList = @(
			@{ Name = 'SQL_Latin1_General_Cp437_CS_AS_KI_WI'; Description = 'Dictionary order, case-sensitive'; }
			@{ Name = 'SQL_Latin1_General_Cp437_CI_AS_KI_WI'; Description = 'Dictionary order, case-insensitive'; }
			@{ Name = 'SQL_Latin1_General_Pref_Cp437_CI_AS_KI_WI'; Description = 'Dictionary order, case-insensitive, uppercase preference'; }
			@{ Name = 'SQL_Latin1_General_Cp437_CI_AI_KI_WI'; Description = 'Dictionary order, case-insensitive, accent-insensitive'; }
			@{ Name = 'SQL_Latin1_General_Cp437_BIN'; Description = 'Binary'; }
			@{ Name = 'SQL_Latin1_General_Cp850_BIN'; Description = 'Binary'; }
			@{ Name = 'SQL_Latin1_General_Cp850_CS_AS_KI_WI'; Description = 'Dictionary order, case-sensitive'; }
			@{ Name = 'SQL_Latin1_General_Cp850_CI_AS_KI_WI'; Description = 'Dictionary order, case-insensitive'; }
			@{ Name = 'SQL_Latin1_General_Cp850_CI_AI_KI_WI'; Description = 'Dictionary order, case-insensitive, accent-insensitive'; }
			@{ Name = 'SQL_Latin1_General_Pref_Cp850_CI_AS_KI_WI'; Description = 'Dictionary order, case-insensitive, uppercase preference'; }
			@{ Name = 'SQL_1xCompat_Cp850_CI_AS_KI_WI'; Description = 'Strict compatibility with Version 1.x case-insensitive databases'; }
			@{ Name = 'SQL_Latin1_General_Cp1_CS_AS_KI_WI'; Description = 'Dictionary order, case-sensitive'; }
			@{ Name = 'SQL_Latin1_General_Cp1_CI_AS_KI_WI'; Description = 'Dictionary order, case-insensitive'; }
			@{ Name = 'SQL_Latin1_General_Pref_Cp1_CI_AS_KI_WI'; Description = 'Dictionary order, case-insensitive, uppercase preference'; }
			@{ Name = 'SQL_Latin1_General_Cp1_CI_AI_KI_WI'; Description = 'Dictionary order, case-insensitive, accent-insensitive'; }
			@{ Name = 'SQL_AltDiction_Cp850_CS_AS_KI_WI'; Description = 'Alternate dictionary order, case-sensitive'; }
			@{ Name = 'SQL_AltDiction_Pref_Cp850_CI_AS_KI_WI'; Description = 'Alternate dictionary order, case-insensitive, uppercase preference'; }
			@{ Name = 'SQL_AltDiction_Cp850_CI_AI_KI_WI'; Description = 'Alternate dictionary order, case-insensitive, accent-insensitive'; }
			@{ Name = 'SQL_Scandainavian_Pref_Cp850_CI_AS_KI_WI'; Description = 'Scandinavian dictionary sort order, case-insensitive, uppercase preference'; }
			@{ Name = 'SQL_Scandainavian_Cp850_CS_AS_KI_WI'; Description = 'Scandinavian dictionary sort order, case-sensitive'; }
			@{ Name = 'SQL_Scandainavian_Cp850_CI_AS_KI_WI'; Description = 'Case-insensitive Scandinavian dictionary sort order, without case preference'; }
			@{ Name = 'SQL_AltDiction_Cp850_CI_AS_KI_WI'; Description = 'Alternate dictionary order, case-insensitive'; }
			@{ Name = 'SQL_Latin1_General_1250_BIN'; Description = 'Binary'; }
			@{ Name = 'SQL_Latin1_General_Cp1250_CS_AS_KI_WI'; Description = 'Dictionary order, case-sensitive'; }
			@{ Name = 'SQL_Latin1_General_Cp1250_CI_AS_KI_WI'; Description = 'Dictionary order, case-insensitive'; }
			@{ Name = 'SQL_Czech_Cp1250_CS_AS_KI_WI'; Description = 'Czech dictionary order, case-sensitive'; }
			@{ Name = 'SQL_Czech_Cp1250_CI_AS_KI_WI'; Description = 'Czech dictionary order, case-insensitive'; }
			@{ Name = 'SQL_Hungarian_Cp1250_CS_AS_KI_WI'; Description = 'Hungarian dictionary order, case-sensitive'; }
			@{ Name = 'SQL_Hungarian_Cp1250_CI_AS_KI_WI'; Description = 'Hungarian dictionary order, case-insensitive'; }
			@{ Name = 'SQL_Polish_Cp1250_CS_AS_KI_WI'; Description = 'Polish dictionary order, case-sensitive'; }
			@{ Name = 'SQL_Polish_Cp1250_CI_AS_KI_WI'; Description = 'Polish dictionary order, case-insensitive'; }
			@{ Name = 'SQL_Romanian_Cp1250_CS_AS_KI_WI'; Description = 'Romanian dictionary order, case-sensitive'; }
			@{ Name = 'SQL_Romanian_Cp1250_CI_AS_KI_WI'; Description = 'Romanian dictionary order, case-insensitive'; }
			@{ Name = 'SQL_Croatian_Cp1250_CS_AS_KI_WI'; Description = 'Croatian dictionary order, case-sensitive'; }
			@{ Name = 'SQL_Croatian_Cp1250_CI_AS_KI_WI'; Description = 'Croatian dictionary order, case-insensitive'; }
			@{ Name = 'SQL_Slovak_Cp1250_CS_AS_KI_WI'; Description = 'Slovak dictionary order, case-sensitive'; }
			@{ Name = 'SQL_Slovak_Cp1250_CI_AS_KI_WI'; Description = 'Slovak dictionary order, case-insensitive'; }
			@{ Name = 'SQL_Slovenian_Cp1250_CS_AS_KI_WI'; Description = 'Slovenian dictionary order, case-sensitive'; }
			@{ Name = 'SQL_Slovenian_Cp1250_CI_AS_KI_WI'; Description = 'Slovenian dictionary order, case-insensitive'; }
			@{ Name = 'SQL_Latin1_General_1251_BIN'; Description = 'Binary'; }
			@{ Name = 'SQL_Latin1_General_Cp1251_CS_AS_KI_WI'; Description = 'Dictionary order, case-sensitive'; }
			@{ Name = 'SQL_Latin1_General_Cp1251_CI_AS_KI_WI'; Description = 'Dictionary order, case-insensitive'; }
			@{ Name = 'SQL_Ukrainian_Cp1251_CS_AS_KI_WI'; Description = 'Ukrainian dictionary order, case-sensitive'; }
			@{ Name = 'SQL_Ukrainian_Cp1251_CI_AS_KI_WI'; Description = 'Ukrainian dictionary order, case-insensitive'; }
			@{ Name = 'SQL_Latin1_General_1253_BIN'; Description = 'Binary'; }
			@{ Name = 'SQL_Latin1_General_Cp1253_CS_AS_KI_WI'; Description = 'Dictionary order, case-sensitive'; }
			@{ Name = 'SQL_Latin1_General_Cp1253_CI_AS_KI_WI'; Description = 'Dictionary order, case-insensitive'; }
			@{ Name = 'SQL_Latin1_General_Cp1253_CI_AS_KI_WI'; Description = 'Dictionary order, case-sensitive, accent-sensitive'; }
			@{ Name = 'SQL_Latin1_General_Cp1253_CI_AI_KI_WI'; Description = 'Dictionary order, case-insensitive, accent-insensitive'; }
			@{ Name = 'SQL_Latin1_General_1254_BIN'; Description = 'Binary'; }
			@{ Name = 'SQL_Latin1_General_Cp1254_CS_AS_KI_WI'; Description = 'Dictionary order, case-sensitive'; }
			@{ Name = 'SQL_Latin1_General_Cp1254_CI_AS_KI_WI'; Description = 'Dictionary order, case-insensitive'; }
			@{ Name = 'SQL_Latin1_General_1255_BIN'; Description = 'Binary'; }
			@{ Name = 'SQL_Latin1_General_Cp1255_CS_AS_KI_WI'; Description = 'Dictionary order, case-sensitive'; }
			@{ Name = 'SQL_Latin1_General_Cp1255_CI_AS_KI_WI'; Description = 'Dictionary order, case-insensitive'; }
			@{ Name = 'SQL_Latin1_General_1256_BIN'; Description = 'Binary'; }
			@{ Name = 'SQL_Latin1_General_Cp1256_CS_AS_KI_WI'; Description = 'Dictionary order, case-sensitive'; }
			@{ Name = 'SQL_Latin1_General_Cp1256_CI_AS_KI_WI'; Description = 'Dictionary order, case-insensitive'; }
			@{ Name = 'SQL_Latin1_General_1257_BIN'; Description = 'Binary'; }
			@{ Name = 'SQL_Latin1_General_Cp1257_CS_AS_KI_WI'; Description = 'Dictionary order, case-sensitive'; }
			@{ Name = 'SQL_Latin1_General_Cp1257_CI_AS_KI_WI'; Description = 'Dictionary order, case-insensitive'; }
			@{ Name = 'SQL_Estonian_Cp1257_CS_AS_KI_WI'; Description = 'Estonian dictionary order, case-sensitive'; }
			@{ Name = 'SQL_Estonian_Cp1257_CI_AS_KI_WI'; Description = 'Estonian dictionary order, case-insensitive'; }
			@{ Name = 'SQL_Latvian_Cp1257_CS_AS_KI_WI'; Description = 'Latvian dictionary order, case-sensitive'; }
			@{ Name = 'SQL_Latvian_Cp1257_CI_AS_KI_WI'; Description = 'Latvian dictionary order, case-insensitive'; }
			@{ Name = 'SQL_Lithuanian_Cp1257_CS_AS_KI_WI'; Description = 'Lithuanian dictionary order, case-sensitive'; }
			@{ Name = 'SQL_Lithuanian_Cp1257_CI_AS_KI_WI'; Description = 'Lithuanian dictionary order, case-insensitive'; }
			@{ Name = 'SQL_Danish_Pref_Cp1_CI_AS_KI_WI'; Description = 'Danish/Norwegian dictionary order, case-insensitive, uppercase preference'; }
			@{ Name = 'SQL_SwedishPhone_Pref_Cp1_CI_AS_KI_WI'; Description = 'Swedish/Finnish[Phone] dictionary order, case-insensitive, uppercase preference'; }
			@{ Name = 'SQL_SwedishStd_Pref_Cp1_CI_AS_KI_WI'; Description = 'Swedish/Finnish[Std] dictionary order, case-insensitive, uppercase preference'; }
			@{ Name = 'SQL_Icelandic_Pref_Cp1_CI_AS_KI_WI'; Description = 'Icelandic dictionary order, case-insensitive, uppercase preference'; }
		)

        $ItemList = $ObjectList | Where-Object { $PSItem.Name -match $wordToComplete } | ForEach-Object {
            $CompletionText = $PSItem.Name;
            $ToolTip = $PSItem.Description;
            $ListItemText = $PSItem.Name;
            $CompletionResultType = [System.Management.Automation.CompletionResultType]::ParameterValue;

            New-Object -TypeName System.Management.Automation.CompletionResult -ArgumentList @($CompletionText, $ListItemText, $CompletionResultType, $ToolTip);
        }

        return $ItemList
    }

$ArgumentCompleter = @{
        CommandName = @(
			'New-AzSqlDatabase'
		);
        ParameterName = 'CollationName';
        ScriptBlock = $ScriptBlock;
}

Microsoft.PowerShell.Core\Register-ArgumentCompleter @ArgumentCompleter;
