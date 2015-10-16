# PsSharePoint
PowerShell interface to Microsoft SharePoint 2010's OData API

## Motivation

I wanted a way to interact with SharePoint 2010 using PowerShell; the SharePoint 2010 Management Shell wasn't available for my use.

Some research led me to SharePoints OData API, which was (relatively) easy to use with PowerShell's `Invoke-WebRequest` Cmdlet.  A few hours of work led to the creation of this module that wraps most of the features that I needed at the time.

## Dependencies

- PowerShell v3
- [SharePoint 2010 Web Services](https://technet.microsoft.com/en-us/scriptcenter/dd919274.aspx)
- [Pester](https://github.com/pester/Pester) (for unit testing)

## Installation

-	Install dependencies
-	Download the [latest release](https://github.com/craibuc/PsSharePoint/releases/latest) and extract its contents
-	Rename the folder to be `PsSharePoint`
-	Move folder to your PowerShell `Modules` folder (C:\Users\<user>\Documents\WindowsPowerShell\Modules)

## Usage

```powershell
# import the module
PS> Import-Module PsSharePoint -Force

# get the list of commands
PS> Get-Command -Module PsSharePoint
```
## Enhancements

- See [issues](https://github.com/craibuc/PsSharePoint/issues)

## Contributing

- Fork the project
- Clone the repository (`git clone git@github.com:<your github name here>/PsSharePoint.git`) to your `Modules` folder (C:\Users\<user> \Documents\WindowsPowerShell\Modules)
- Add code; try to align with enhancements and fixes to items on the issues list
- Add unit tests (Pester); ensure that all test pass
- Push changes to your github account
- Create a pull request

## Relevant

- [Deciding Which SharePoint 2010 API to Use](https://msdn.microsoft.com/en-us/library/office/hh313619%28v=office.14%29.aspx)
