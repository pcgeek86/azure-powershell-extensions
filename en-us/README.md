This folder contains the help files for the Azure PowerShell Extensions project.

[This document](https://technet.microsoft.com/en-us/library/dd878343(v=vs.85).aspx) describes the process of adding help to PowerShell modules.

There are five differnt types of module help in PowerShell:

**Cmdlet Help**. The Help topics that describe cmdlets in a module are XML files that use the command help schema.

**Provider Help**. The Help topics that describe providers in a module are XML files that use the provider help schema.

**Function Help**. The Help topics that describe functions in a module can be XML files that use the command help schema or comment-based Help topics within the function, or the script or script module.

**Script Help**. The Help topics that describe scripts in a module can be XML files that use the command help schema or comment-based Help topics in the script or script module.

**Conceptual ("About") Help**. You can use a conceptual ("about") Help topic to describe the module and its members and to explain how the members can be used together to perform tasks. Conceptual Help topics are text files with Unicode (UTF-8) encoding. The file name must use the *about_<name>.help.txt format*, such as *about_MyModule.help.txt*. By default, Windows PowerShell includes over 100 of these conceptual About Help topics.