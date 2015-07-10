<#
.SYNOPSIS
Return a SharePoint resource as a JSON string

.PARAMETER Url
The Url of the JSON resource.

.EXAMPLE
PS> Get-JsonObject -Url 'http://contoso.intranet.com/_vti_bin/listdata.svc/TheList(1)''

.OUTPUT
Json-formatted string

#>
function Get-JsonObject {

    Param(
      [Parameter(Mandatory=$True,Position=1)]
      [string]$Url
    )

    try {

      $client = New-Object System.Net.WebClient
      $client.Credentials = [System.Net.CredentialCache]::DefaultCredentials 
      $client.Headers.Add("Content-Type", "application/json;odata=verbose")
      $client.Headers.Add("Accept", "application/json;odata=verbose")
      $client.DownloadString($Url)

    }
    catch {
      throw
    }
    finally {
      $client.Dispose()
    }

}
