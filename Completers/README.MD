This folder contains "argument completer" functions for the [TabExpansion++](https://github.com/lzybkr/TabExpansionPlusPlus) PowerShell module. 
These argument completer functions perform auto-completion for PowerShell Intellisense, when it is invoked by a user, typically using the {CTRL} + {SPACE} keyboard shortcut, or by putting a space after a parameter name.

**NOTE**: Each individual script file contained in this folder is responsible for defining *and* registering a single, custom argument completer.

For Azure Service Management (ASM) argument completers, the file name should match the following format:

```
Microsoft.Azure.<ServiceType>.<ParameterName>.ArgumentCompleters.ps1
```

For Azure Resource Manager (ARM) argument completers, the file name should match the following format:

```
Microsoft.AzureRm.<ServiceType>.<ParameterName>.ArgumentCompleters.ps1
```

The module file scans for **all** files in the `Completers` folder, that have a `.ps1` file extension.

