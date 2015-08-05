# Introduction

This PowerShell script module project is intended to offer extensions to the Microsoft Azure PowerShell module, to simply interactive use, and fill in functional & documentation gaps. The specific areas that it will help fill are:

- PowerShell Proxy functions - Simplify cmdlet calls that are unnecessarily complicated by default.
- PowerShell Aliases - Reduce the amount of typing necessary to run Azure PowerShell commands interactively.
- PowerShell about_* Help - Provide built-in PowerShell help that users are accustomed to, instead of browsing the web.
- Auto-completer Functions - Automatic tab-completion for parameter values, to reduce the need to memorize cloud resource names.

# Features

## Aliases

The abbreviation "az" will generally be used to refer to "Azure" in PowerShell command aliases, to differentiate them from other aliases.

The following aliases are supported by this module:

### Azure Profile

The following PowerShell aliases apply to Azure authentication and subscription management.

- **aazac** - Add-AzureAccount
- **razac** - Remove-AzureAccount

### Virtual Machines

- **nazvmc** - New-AzureVMConfig


### Azure Storage

- **nazsa** - New-AzureStorageAccount


## Auto-Completion

# Issues

For issues or enhancement requests related to this project, please report them on the GitHub issue tracker.

# Authors

The founder of this project is Trevor Sullivan, a Microsoft MVP for Windows PowerShell, and an independent Cloud & Automation Consultant.

