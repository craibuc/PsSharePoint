Import-Module 'PsSharePoint' -Force

# Request:  http://apps/ReportRequests/_vti_bin/listdata.svc/ReportRequests(7195)?$select=Title,Id,RequestStatusValue,ReportDeveloperId,ReportCategory
# Report Category:  http://apps/ReportRequests/_vti_bin/listdata.svc/ReportRequestsReportCategory
# Request Status:   http://apps/ReportRequests/_vti_bin/listdata.svc/ReportRequestsRequestStatus
# Business Analyst-Primary: http://apps/ReportRequests/_vti_bin/listdata.svc/ReportRequests(7195)/BusinessAnalystPrimary
# Report Developer: http://apps/ReportRequests/_vti_bin/listdata.svc/ReportRequests(7195)/ReportDeveloper

Describe "GET operations" {

    [xml]$xml = Get-ListItem "http://apps/ReportRequests" "ReportRequests" "7122"

    $request = @{}
    $request.add('Id', $xml.entry.content.properties.Id.innerText)
    $request.add('Title', $xml.entry.content.properties.Title)
    $request.add('RequestStatusValue', $xml.entry.content.properties.RequestStatusValue)
    $request.add('DevelopmentStartDate', $xml.entry.content.properties.DevelopmentStartDate.innerText)
    $request.add('DevelopmentCompletedDate', $xml.entry.content.properties.DevelopementCompletedDate.innerText)
    $request.add('ActualHoursDone', $xml.entry.content.properties.ActualHoursDone.innerText)

    [System.Reflection.Assembly]::LoadWithPartialName("System.web")
    $DefineFieldsNeeded = [System.Web.HttpUtility]::HtmlDecode($xml.entry.content.properties.DefineFieldsNeeded)
    $DefineFieldsNeeded = $DefineFieldsNeeded -replace "<br.*?>", ([Environment]::NewLine)
    $DefineFieldsNeeded = $DefineFieldsNeeded -replace "<.*?>", ''
    $request.add('DefineFieldsNeeded', $DefineFieldsNeeded)

    Context "Gets pertinent request data" {

        It "ID matches"  {
            $actual = $request['Id'] #$xml.entry.content.properties.Id.innerText
            $actual | Should Be "7122"
        }

        It "Title matches"  {
            $actual = $request['Title']    # $xml.entry.content.properties.Title
            $actual | Should Be "Staphylococcus Aureus Osteomyelitis Case Identification"
        }
        
        It "Status matches"  {
            $actual = $request['RequestStatusValue']    # $xml.entry.content.properties.RequestStatusValue
            $actual | Should Be "6 - Completed"
        }

        It "Development Start Date matches"  {
            $actual = $request['DevelopmentStartDate']    # $xml.entry.content.properties.DevelopmentStartDate.innerText
            $actual | Should Be "2014-12-10T00:00:00"
        }

        It "Developement Completed Date matches"  {
            $actual = $request['DevelopementCompletedDate']  # $xml.entry.content.properties.DevelopementCompletedDate.innerText
            $actual | Should Be $null
        }

        It "Actual Hours Done matches"  {
            $actual = $request['ActualHoursDone']  # $xml.entry.content.properties.ActualHoursDone.innerText
            $actual | Should Be "0.75"
        }

    }
}

# $xml.entry.content.properties | Foreach {$_} |  Format-Table Id, Title #, RequestStatusValue, BusinessAnalystPrimaryId, ReportDeveloperId
            #Where {[DateTime]$_.pubDate -gt (Get-Date).AddMonths(-1)} |  Format-Table Title
# $xml.SelectNodes("entry/content/properties/*") | Select-Object -Expand Name | Where-Object { ($_ -eq "Title") -or ($_ -eq "Id") } |  Format-Table Title
# $xml.entry.content.properties #| #.ChildNodes | Where-Object { $_.Name -match 'Id|Title|RequestStatusValue|ActualHoursDone' } | % { $_.Name; $_.InnerText } | Format-Table -Property Name,InnerText
# $xml.entry.link | % { $_.title; $_.href; $_.rel }
# $xml.entry.content.properties.childNodes | Where-Object { $_.Name -match '^[Id|Title]'}
