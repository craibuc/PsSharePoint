

<#
Relevant:

    http://www.dotnetmafia.com/blogs/dotnettipoftheday/archive/2010/01/21/introduction-to-querying-lists-with-rest-and-listdata-svc-in-sharepoint-2010.aspx
    http://blogs.technet.com/b/heyscriptingguy/archive/2012/03/26/use-powershell-to-parse-an-xml-file-and-sort-the-data.aspx
    
#>

function Get-Items() {

    [CmdletBinding()] 
    param (
        [Parameter(Mandatory=$True,Position=0)]
        [String] $webUrl,
        [Parameter(Mandatory=$True,Position=1)]
        [String] $listName
    ) 

    begin { Write-Verbose "$($MyInvocation.MyCommand.Name)::Begin" }

    process {

        $uri = "$($webUrl)/_vti_bin/listdata.svc/$($listName)"
        $SearchWS = New-WebServiceProxy -Uri $uri -UseDefaultCredential

    }
    
    end { Write-Verbose "$($MyInvocation.MyCommand.Name)::End" }

}

function Get-Url {

    [CmdletBinding()] 
    param (
      [Parameter(Mandatory=$True)]
      [String] $url
    ) 

    BEGIN { Write-Verbose "$($MyInvocation.MyCommand.Name)::Begin" }

    PROCESS {

        try {

            $webRequest = Invoke-WebRequest -Uri $url -Method Get -UseDefaultCredentials
            [xml]$xml = $webRequest.Content
            return $xml

            # $req = [System.Net.WebRequest]::Create($webUrl)        
            # $req.Method ="GET"
            # # JSON
            # # $req.Accept = "application/json; odata=verbose"
            # # $req.ContentType = "application/json; charset=utf-8"
            # $req.ContentLength = 0
            # $req.Credentials = [System.Net.CredentialCache]::DefaultCredentials

            # $resp = $req.GetResponse()
            # $reader = new-object System.IO.StreamReader($resp.GetResponseStream())

            # return $reader.ReadToEnd()  

        }
        catch [Exception] {
            Write-Host $_.Exception.ToString()
        }
        # finally {
        #     if ($reader -ne $null) {
        #         $reader.Close()
        #     }
        # }

    } # PROCESS

    END { Write-Verbose "$($MyInvocation.MyCommand.Name)::End" }

}

# http://apps/ReportRequests/_vti_bin/listdata.svc/ReportRequestsReportCategory
function Get-List() {

    [CmdletBinding()] 
    param (
      [Parameter(Mandatory=$True,Position=0)]
      [String] $webUrl,
      [Parameter(Mandatory=$True,Position=1)]
      [String] $listName
    ) 

    begin { Write-Verbose "$($MyInvocation.MyCommand.Name)::Begin" }

    process {

        $url = "$($webUrl)/_vti_bin/listdata.svc/$($listName)"
        Write-Verbose "URL: " $url

        try {
          Get-Url $url
        }
        catch [Exception]{
            Write-Host $_.Exception.ToString()
        }

    }

    end { Write-Verbose "$($MyInvocation.MyCommand.Name)::End" }

}

function Get-ListItem() {

    [CmdletBinding()] 
    param (
      [Parameter(Mandatory=$True,Position=0)]
      [String] $webUrl,
      [Parameter(Mandatory=$True,Position=1)]
      [String] $listName,
      [Parameter(Mandatory=$True,Position=2)]
      [Int] $itemId
    ) 

    begin { Write-Verbose "$($MyInvocation.MyCommand.Name)::Begin" }

    process {

        $uri = "$($webUrl)/_vti_bin/listdata.svc/$($listName)($($itemId))"
        Write-Host "URI: $($uri)"

        try {
          Write-Host "trying..."

          [xml]$xml = Get-Url $uri
          $xml

        }
        catch [Exception]{
            Write-Host "catching..."
            Write-Host $_.Exception.ToString()
        }

    }

    end { Write-Verbose "$($MyInvocation.MyCommand.Name)::End" }

}

function Update-ListItem() {

  [CmdletBinding()] 
  param (
      [Parameter(Mandatory=$True,Position=0)]
      [String] $webUrl,
      [Parameter(Mandatory=$True,Position=1)]
      [String] $listName,
      [Parameter(Mandatory=$True,Position=2)]
      [Int] $itemId,
      [Parameter(Mandatory=$True,Position=3)]
      [String[]] $properties
  ) 

  begin { Write-Verbose "$($MyInvocation.MyCommand.Name)::Begin" }

  process {
  
    $url = "$($webUrl)/_vti_bin/listdata.svc/$($listName)($($itemId))"
    Write-Host "url: " $url        

    $req = [System.Net.WebRequest]::Create($url)
    $req.Method ="POST"
    # JSON
    $req.Accept = "application/json; odata=verbose"
    # headers: { "Accept": "application/json; odata=verbose" }
    $req.ContentType = "application/json; charset=utf-8"
    $req.ContentLength = 0
    $req.Credentials = [System.Net.CredentialCache]::DefaultCredentials
    $req.Headers.Add("X-HTTP-Method", "MERGE")
    $req.Headers.Add("If-Match", "MERGE")

    $resp = $req.GetResponse()
    $reader = new-object System.IO.StreamReader($resp.GetResponseStream())
  
    return $reader.ReadToEnd()
  
  }
  
   #    $.ajax({
   #       type: 'POST',
   #       url: item.__metadata.uri,
   #       contentType: 'application/json',
   #       processData: false,
   #       headers: {
   #              "Accept": "application/json;odata=verbose",
   #              "X-HTTP-Method": "MERGE",
   #              "If-Match": item.__metadata.etag
   #       },
   #       data: Sys.Serialization.JavaScriptSerializer.serialize(itemProperties),
   
   end { Write-Verbose "$($MyInvocation.MyCommand.Name)::End" }

}