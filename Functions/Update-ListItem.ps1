<#
.SYNOPSIS
    Update List item

.DESCRIPTION
    Updates List Item operation using SharePoint 2010 REST Interface.
    To  update an existing entity, you must perform the following actions:
      - Create an HTTP request using the POST verb.
      - Add an X-HTTP-Method header with a value of MERGE.
      - Use the service URL of the list item you want to update as the target for the POST
      - Add an If-Match header with a value of the entityâ€™s original ETag.
    Follow http://blog.vgrem.com/2014/03/22/list-items-manipulation-via-rest-api-in-sharepoint-2010/ for a more details

.PARAMETER WebUrl
    The server's URL

.PARAMETER ListName
    Name of the list

.PARAMETER ItemId
    The list item # to get

.PARAMETER Properties
    The item's properties to be updated

.EXAMPLE
   PS> Update-ListItem -WebUrl "http://contoso.intranet.com" -ListName "Tasks" -ItemId 1 -Properties $ItemProperties

#>
Function Update-ListItem()
{

    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True)]
        [string]$WebUrl,

        [Parameter(Mandatory=$True)]
        [string]$ListName,

        [Parameter(Mandatory=$True)]
        [int]$ItemId, 

        [Parameter(Mandatory=$True)]
        [Hashtable]$Properties
    )

  BEGIN { Write-Verbose "$($MyInvocation.MyCommand.Name)::Begin" }

  PROCESS {
    Write-Verbose "$($MyInvocation.MyCommand.Name)::Process"

    $endpointUrl = "$WebUrl/_vti_bin/listdata.svc/$ListName($ItemId)"
    Write-Verbose "Endpoint Url: $endpointurl"

    $headers = @{
       "X-HTTP-Method" = "MERGE";
       "If-Match" = "*"
    }

    $ItemPayload = $Properties | ConvertTo-Json
    Write-Verbose "Item Payload: $ItemPayload"
    
    try {
        $response = Invoke-WebRequest -Uri $endpointUrl -Method Post -UseDefaultCredentials -Headers $headers -ContentType "application/json" -Body $ItemPayload
    }

    # Invoke-WebRequest throws System.Net.WebException
    catch [System.Net.WebException] {
      throw
    }

    finally {
        # return response object
        $response
    }

  } #PROCESS

  END {Write-Verbose "$($MyInvocation.MyCommand.Name)::End"}

}

Set-Alias spuli Update-ListItem