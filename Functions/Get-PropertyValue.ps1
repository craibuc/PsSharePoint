function Get-PropertyValue
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
        [string]$Property
    )

  BEGIN { Write-Verbose "$($MyInvocation.MyCommand.Name)::Begin" }

  PROCESS {
    Write-Verbose "$($MyInvocation.MyCommand.Name)::Process"

    $endpointUrl = "$WebUrl/_vti_bin/listdata.svc/$ListName($ItemId)/$Property/\`$value"
    Write-Verbose "Endpoint Url: $endpointurl"
    
    try {
        $response = Invoke-WebRequest -Uri $endpointUrl -Method Get -UseDefaultCredentials
        Write-Verbose "Content: $($Response.Content)"
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
