<# 
.SYNOPSIS  
    Get an item from a SharePoint List

.PARAMETER WebUrl
    The server's URL

.PARAMETER ListName
    Name of the list

.PARAMETER ItemId
    The list item # to get

.EXAMPLE 
  PS> Get-ListItem -WebUrl 'http://contoso.intranet.com/' -ListName 'Tasks' -ItemId 1

#>
Function Get-ListItem
{

  [CmdletBinding()]
  param(
    [Parameter(Mandatory=$True,Position=1)]
    [string]$WebUrl,

    [Parameter(Mandatory=$True,Position=2)]
    [string]$ListName,

    [Parameter(Mandatory=$True,Position=3)]
    [int]$ItemId
  )

  BEGIN {Write-Verbose "$($MyInvocation.MyCommand.Name)::Begin"}
  PROCESS {
    Write-Verbose "$($MyInvocation.MyCommand.Name)::Process"

    #construct endpoint
    $endpointUrl = "$WebUrl/_vti_bin/listdata.svc/$ListName($ItemId)"
    Write-Verbose "endpointUrl: $endpointUrl"

    try {
        $response = Invoke-WebRequest -Uri $endpointUrl -Method Get -UseDefaultCredentials
    }

    # Invoke-WebRequest throws System.Net.WebException
    catch [System.Net.WebException] {
        write-host $_.Exception.Message
        Write-Host $_.Exception.Response.StatusCode.Value__
        Write-Host $_.Exception.Response.StatusDescription
    }

    finally {
        # returns Microsoft.PowerShell.Commands.HtmlWebResponseObject
        $response
    }

  } #PROCESS
  END {Write-Verbose "$($MyInvocation.MyCommand.Name)::End"}

}

Set-Alias spgli Get-ListItem