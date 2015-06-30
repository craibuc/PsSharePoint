<#
.SYNOPSIS
Return a SharePoint resource as a PsCustomObject

.PARAMETER Url
The Url of the JSON resource.

.EXAMPLE
PS> Get-PsCustomObject -Url 'http://contoso.intranet.com/_vti_bin/listdata.svc/TheList(1)''

.OUTPUT
PsCustomObject

#>
Function Get-PsCustomObject {

    Param(
      [Parameter(Mandatory=$True,Position=1)]
      [string]$Url
    )

    try {

      $client = New-Object System.Net.WebClient
      $client.Credentials = [System.Net.CredentialCache]::DefaultCredentials 
      $client.Headers.Add("Content-Type", "application/json;odata=verbose")
      $client.Headers.Add("Accept", "application/json;odata=verbose")

      $data = $client.DownloadString($Url)
      # return PsCustomObject
      return $data | ConvertFrom-Json

    }
    catch {
      throw
    }
    finally {
      $client.Dispose()
    }

}
