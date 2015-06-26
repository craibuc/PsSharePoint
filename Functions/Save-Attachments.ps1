<#
.SYNOPSIS
Save the item's specified attachment(s) to disk.

.PARAMETER Id
.PARAMETER Name
.PARAMETER Path

#>
Function Save-Attachments {

  Param(
    [Parameter(Mandatory=$True,Position=1)]
    [string]$WebUrl,

    [Parameter(Mandatory=$True,Position=2)]
    [string]$ListName,

    [Parameter(Mandatory=$True,Position=3)]
    [int]$ItemId,

    [Parameter(Mandatory=$True,Position=4,ValueFromPipeline=$True)]
    # allow binding to Get-Attachments pipeilne
    [Alias('Title')]
    [string[]]$Names,

    [Parameter(Mandatory=$False,Position=5)]
    [ValidateNotNullOrEmpty()]
    [string]$Path='.',

    [switch]$Passthru
    )

  Begin {
    Write-Verbose "$($MyInvocation.MyCommand.Name)::Begin"

    Write-Verbose "ItemId: $ItemId"
    Write-Verbose "Path: $Path"
  }

  Process {
    Write-Verbose "$($MyInvocation.MyCommand.Name)::Process"

    Foreach ($Name in $Names) {

     $endpointUrl="http://apps/ReportRequests/Lists/Report Requests/Attachments/$ItemId/$Name"
      Write-Verbose "endpointUrl: $endpointUrl"

      $Destination = (Join-Path $Path $Name)
      Write-Verbose "Destination: $Destination"

      try {
        # if OutFile set, response will be null
        Invoke-WebRequest -Uri $endpointUrl -Method Get -UseDefaultCredentials -OutFile $Destination
      }
      # Invoke-WebRequest throws System.Net.WebException
      catch [System.Net.WebException] {
        throw
      }
      finally {
        if ($Passthru) { Get-Item $Destination }
      }

    } # Foreach
  } # Process

  End { Write-Verbose "$($MyInvocation.MyCommand.Name)::End"}

}