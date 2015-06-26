Function Update-Attachments() {

    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True,Position=1)]
        [string]$WebUrl, 

        [Parameter(Mandatory=$True,Position=2)]
        [string]$ListName, 

        [Parameter(Mandatory=$True,Position=3)]
        [int]$ItemId,

        # pipeline support
        [Parameter(Mandatory=$True,Position=4,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)]
        # associate FileInfo object's FullName property to be bound to parameter
        [Alias('FullName')]
        [string[]]$Paths
    )

    BEGIN {
        Write-Verbose "$($MyInvocation.MyCommand.Name)::Begin"
    }
    PROCESS {
        Write-Verbose "$($MyInvocation.MyCommand.Name)::Process"

        # 
        #$endpointUri = New-Object System.Uri("$WebUrl/_vti_bin/listdata.svc/$ListName($ItemId)/Attachments")
        #$endpointUri = New-Object System.Uri("$WebUrl/_vti_bin/listdata.svc/Attachments")

        Foreach ($Path In $Paths) {
            Write-Verbose "Path: $Path"

            $fileName = (Split-Path $Path -Leaf)
            $fileContent = ([IO.File]::ReadAllBytes($Path))
            $headers = @{
                "X-HTTP-Method" = "MERGE";
                "If-Match" = "*"
            }

            # http://apps/ReportRequests/_vti_bin/listdata.svc/Attachments(EntitySet='ReportRequests',ItemId=7579,Name='7579.txt')
            $endpointUri = New-Object System.Uri("$WebUrl/_vti_bin/listdata.svc/Attachments(EntitySet='$ListName',ItemId=$ItemId,Name='$fileName')")
            # http://apps/ReportRequests/Lists/Report%20Requests/Attachments/7579/7579.txt
            #$endpointUri = New-Object System.Uri("$WebUrl/_vti_bin/listdata.svc/$ListName/Attachments/$ItemId/$fileName")
            Write-Verbose "Endpoint Uri: $endpointUri"

            try {
                # reset each pass to ensure that prior response isn't reused
                $response=$null
                $response = Invoke-WebRequest -Uri $endpointUri -Method POST -UseDefaultCredentials -Body $fileContent -Headers $headers -ContentType "*/*"
            }

            # Invoke-WebRequest throws System.Net.WebException
            catch [System.Net.WebException] {
                throw $_
            }

            finally {
                # returns Microsoft.PowerShell.Commands.HtmlWebResponseObject
                $response
            }

        } # Foreach

    } # PROCESS
    END {
        Write-Verbose "$($MyInvocation.MyCommand.Name)::End"
    }

}

Set-Alias spua Update-Attachments
