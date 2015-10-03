<img src="https://ci.appveyor.com/api/projects/status/rj6yk9p8d0bwonpn?svg=true" />

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

The following PowerShell aliases apply to Virtual Machine commands.

- **nazvmc** - New-AzureVMConfig


### Azure Storage

- **nazsa** - New-AzureStorageAccount
- **razsa** - Remove-AzureStorageAccount

## Auto-Completion

Auto-completers are PowerShell ScriptBlocks that provide Intellisense & tab-completion for PowerShell command parameter values. 
These functions require the presence of the TabExpansion++ PowerShell module, which is available from its [GitHub project page](https://github.com/lzybkr/TabExpansionPlusPlus/tree/DropScanningRegistration).
Make sure that you download the **DropScanningRegistration** branch, as it has updated code that has not yet been merged into the **master** branch.

**NOTE**: This module **must** be imported in order for the Intellisense extensions to be registered.
To simplify this process, each time you launch a new PowerShell session, you can add a line to your PowerShell profile to import the module:

```
Import-Module -Name AzureExt;
```

**IMPORTANT**: For most argument completer functions, you must be authenticated to Microsoft Azure.
Starting with the 1.0 release of the Azure Resource Manager module, token caches are not automatically saved between PowerShell sessions.
For Azure Service Management commands, use `Add-AzureAccount` to login. 
For Azure Resource Manager commands, use `Login-AzureRmAccount` to login.

This module includes auto-completion for the following Azure entitites.

### Service Management

- Subscription names
- Cloud Service names
- Virtual Machine names

### Resource Manager 

- Azure Locations
- Resource Group names
- Virtual Machine names
- Storage Accounts

## Built-in Help

# Issues

For issues or enhancement requests related to this project, please report them on the GitHub issue tracker.

# Authors

The founder of this project is Trevor Sullivan, a Microsoft MVP for Windows PowerShell, and an independent Cloud & Automation Consultant.

