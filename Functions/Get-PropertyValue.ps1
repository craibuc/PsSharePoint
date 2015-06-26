<#

.EXMAPLE
PS > 'value'
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

    $endpointUrl = "$WebUrl/_vti_bin/listdata.svc/$ListName($ItemId)/$Property/\`$$($Function.ToLower())"
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
