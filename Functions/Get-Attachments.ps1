Add-Type -AssemblyName System.Web

<#
.SYNOPSIS
Get attachments associated with the list item.

.PARAMETER WebUrl
.PARAMETER ListName
.PARAMETER ItemId

.EXAMPLE
PS> Get-Attachments -WebUrl "http://contoso.intranet.com/" -ListName "Tasks" -ItemId 1

.OUTPUT
PsCustomObject

#>
Function Get-Attachments() {

    Param(
        [Parameter(Mandatory=$True,Position=1)]
        [string]$WebUrl,

        [Parameter(Mandatory=$True,Position=2)]
        [string]$ListName,

        [Parameter(Mandatory=$True,Position=3)]
        [int]$ItemId
    )

  BEGIN {
    Write-Verbose "$($MyInvocation.MyCommand.Name)::Begin"
}

  PROCESS {
    Write-Verbose "$($MyInvocation.MyCommand.Name)::Process"

    $endpointUrl = "$WebUrl/_vti_bin/listdata.svc/$ListName($ItemId)/Attachments"
    Write-Verbose "Endpoint Url: $endpointurl"

    # XPath: /feed/entry/*
    # write to pipeline
    (Invoke-RestMethod -Uri $endpointUrl -Method Get -UseDefaultCredentials) | Foreach {
        $i++
        [PsCustomObject]@{
            '#'="$i";
            Title=$_.Title.'#text';
            Url=[System.Web.HttpUtility]::UrlDecode($_.Content.src);
            ContentType=$_.Content.type; 
        }
    } # Foreach

  } #PROCESS

  END {Write-Verbose "$($MyInvocation.MyCommand.Name)::End"}

}