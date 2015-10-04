The Microsoft Azure PowerShell module does not offer aliases out of the box, which can make interactive usage more challenging. 
This project aims to provide aliases as a means to simplify the interactive use of the core Azure PowerShell experience.

This folder contains a series of JSON files that declare command aliases, that will be exported from this PowerShell module.

Each JSON file contains a root element called "aliases," which contains an array of JSON objects, each of which declares a single alias.
Each JSON object representing an alias **must** have the following properties:

- **Name** - The name of the alias, that will be called by the user.
- **Value** - The full command name that the alias points to.
- **Description** - A brief description of what the alias performs.

When the **AzureExt** PowerShell module is imported, the `Aliases` folder is scanned for files with the `.json` file extension.
The `aliases` property, at the root of each JSON file, is scanned for an array of JSON objects, and for each object that is found, an alias will be created.

**NOTE**: Each JSON file should contain aliases that target a specific feature area of the Microsoft Azure platform (eg. SQL Database, Storage, Authentication, Subscription Management, etc.)