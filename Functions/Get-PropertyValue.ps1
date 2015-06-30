<#
.SYNOPSIS
Return a single property's value.

.PARAMETER WebUrl
The SharePoint list's base Url (e.g. 'http://contoso.intranet.com/').

.PARAMETER ListName
The name of the SharePoint list (e.g. 'Tasks').

.PARAMETER ItemId
The list item.

.PARAMETER Property
The name of the property (e.g. Name).

.PARAMETER Function
Defualts to '$value'; '$count' is an option for collections.

.EXAMPLE
PS > Get-PropertyValue -WebUrl "http://contoso.intranet.com/" -ListName "Tasks" -itemId 1 -Property 'Name'

Get's the property's '$value'.

.EXAMPLE
PS > Get-PropertyValue -WebUrl "http://contoso.intranet.com/" -ListName "Tasks" -itemId 1 -Property 'Attachments' -Function 'count'

Get's the Attachments collection's '$count'.

#>
function Get-PropertyValue
{

    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True,Position=1)]
        [string]$WebUrl,

        [Parameter(Mandatory=$True,Position=2)]
        [string]$ListName,

        [Parameter(Mandatory=$True,Position=3)]
        [int]$ItemId, 

        [Parameter(Mandatory=$True,Position=4)]
        [string]$Property,

        [Parameter(Mandatory=$False,Position=5)]
        [string]$Function='value'
    )

  BEGIN { Write-Verbose "$($MyInvocation.MyCommand.Name)::Begin" }

  PROCESS {
    Write-Verbose "$($MyInvocation.MyCommand.Name)::Process"

    $endpointUrl = "$WebUrl/_vti_bin/listdata.svc/$ListName($ItemId)/$Property/`$$($Function.ToLower())"
    Write-Verbose "Endpoint Url: $endpointurl"
    
    try {
        $response = Invoke-WebRequest -Uri $endpointUrl -Method Get -UseDefaultCredentials
        Write-Verbose "Status: $($Response.StatusCode)"
        Write-Verbose "Content: $($Response.Content)"
    }

    # Invoke-WebRequest throws System.Net.WebException
    catch [System.Net.WebException] {
        # ignore 404 NotFound erros; these are returned if the property's value has not been set
        if (([int]$_.Exception.Response.StatusCode) -ne 404) { throw }
    }

    finally {
        # return response object
        $response
    }

  } #PROCESS

  END {Write-Verbose "$($MyInvocation.MyCommand.Name)::End"}

}
