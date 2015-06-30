
<#
.SYNOPSIS
Cmdlet help is awesome.  Autogenerate via template so I never forget.

.DESCRIPTION
.PARAMETER Files
One or more CSV files to be convert to XLS format.

.PARAMETER Password
Password

.INPUTS
.OUTPUTS
.EXAMPLE
Encrypt-File  @("C:\Users\xxx\Desktop\foo.csv","C:\Users\xxx\Desktop\bar.csv") "Happy1"

.LINK
#>
function List() {

    [CmdletBinding()] 
    param (
        [Parameter(Mandatory=$True,Position=0)]
        [String] $siteUrl,
        [Parameter(Mandatory=$True,Position=1)]
        [String] $listName
    ) 

    begin { Write-Verbose "$($MyInvocation.MyCommand.Name)::Begin" }
    
    process {
    
        [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint")
        $site = new-object Microsoft.SharePoint.SPSite($siteUrl)
        $web = $site.openweb("/Lists")
        
        $list = $web.Lists[$listName] 
        $listItems = $list.Items
        $listItemsTotal = $listItems.Count

        for ($x=$listItemsTotal-1; $x -ge 0; $x--) {
    #        if($listItems[$x].name.Contains("3")) {
                Write-Host($listItems[$x].name + ": ")
            }
    #    }
        }
    
    end { Write-Verbose "$($MyInvocation.MyCommand.Name)::End" }
    
}

# List "http://apps/ReportRequests" "Report Requests"

<#
.SYNOPSIS
Cmdlet help is awesome.  Autogenerate via template so I never forget.

.DESCRIPTION
.PARAMETER Files
One or more CSV files to be convert to XLS format.

.PARAMETER Password
Password

.INPUTS
.OUTPUTS
.EXAMPLE
Encrypt-File  @("C:\Users\xxx\Desktop\foo.csv","C:\Users\xxx\Desktop\bar.csv") "Happy1"

.LINK
#>
function item() {

    param (
        [Parameter(Mandatory=$True,Position=0)]
        [String] $siteUrl,
        [Parameter(Mandatory=$True,Position=1)]
        [String] $listName
    ) 

    begin { Write-Verbose "$($MyInvocation.MyCommand.Name)::Begin" }
    
    process {
    
        # $url = "http://apps/ReportRequests/_layouts/listform.aspx
        # ?PageType=4&ListId={70C9B8F9-CBD4-4F5C-A94D-CE07B33FC7E4}&ID=7142&ContentTypeID=0x0100B25F3AFF34B865419C2A6A59A2E43B48"
        
        $web = Get-SPWeb -Identity$siteUrl
        $list = $web.Lists[$listName]
        
        # $spItem = $spList.GetItemById(7142)
        # $spItem["Name"] = "MyName"
        # $spItem.Update()

        $listItems = $list.Items
        $listItemsTotal = $listItems.Count

        for ($x=$listItemsTotal-1; $x -ge 0; $x--) {
    #        if($listItems[$x].name.Contains("3")) {
                Write-Host($listItems[$x].name + ": ")
    #        }
        }

    }
    
    end { Write-Verbose "$($MyInvocation.MyCommand.Name)::End" }

}

# item "http://apps/ReportRequests" "Report Requests"