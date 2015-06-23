<#
.SYNOPSIS
Attach one or more documents to a list item.

.PARAMETER WebUrl
The SharePoint list's base Url (e.g. 'http://contoso.intranet.com/')

.PARAMETER ListName
The name of the SharePoint list (e.g. 'Tasks')

.PARAMETER ItemId
The list item.

.PARAMETER Paths
String array of file paths.

.EXAMPLE
PS> Add-Attachments -WebUrl "http://contoso.intranet.com/" -ListName "Tasks" -ItemId 1 -Paths "~\Documents\SharePointUserGuide.docx"

.EXAMPLE
PS> Get-ChildItem '*.txt' | Add-Attachments -WebUrl "http://contoso.intranet.com/" -ListName "Tasks" -ItemId 1

#>
Function Add-Attachments()
{

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

        $endpointUri = New-Object System.Uri("$WebUrl/_vti_bin/listdata.svc/Attachments")
        Write-Verbose "Endpoint Uri: $endpointUri"
    }
    PROCESS {
        Write-Verbose "$($MyInvocation.MyCommand.Name)::Process"

        Foreach ($Path In $Paths) {
            Write-Verbose "Path: $Path"

            $fileName = (Split-Path $Path -Leaf)
            $fileContent = ([IO.File]::ReadAllBytes($Path))

            $headers = @{
                     'Slug' = "$ListName|$ItemId|$fileName";
            }
            Write-Verbose "'Slug' = $ListName|$ItemId|$fileName"

            try {
                # reset each pass to ensure that prior response isn't reused
                $response=$null
                # returns Microsoft.PowerShell.Commands.HtmlWebResponseObject
                $response = Invoke-WebRequest -Uri $endpointUri -Method POST -UseDefaultCredentials -Body $fileContent -Headers $headers -ContentType "*/*"
            }

            # Invoke-WebRequest throws System.Net.WebException
            catch [System.Net.WebException] {
                write-host $_.Exception.Message
                Write-Host $_.Exception.Response.StatusCode.Value__
                Write-Host $_.Exception.Response.StatusDescription
            }

            finally {
                # return response object
                $response
            }

        } # Foreach

    } # PROCESS
    END {
        Write-Verbose "$($MyInvocation.MyCommand.Name)::End"
    }

}

Set-Alias spaa Add-Attachments
