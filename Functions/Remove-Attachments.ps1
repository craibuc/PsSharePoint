Function Remove-Attachments
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
        [Parameter(Mandatory=$True,Position=4,ValueFromPipeline=$True)]
        [string[]]$Names
    )

    BEGIN {
        Write-Verbose "$($MyInvocation.MyCommand.Name)::Begin"

        $endpointUri = New-Object System.Uri("$WebUrl/_vti_bin/listdata.svc/Attachments")
        Write-Verbose "Endpoint Uri: $endpointUri"
    }
    PROCESS {
        Write-Verbose "$($MyInvocation.MyCommand.Name)::Process"

        Foreach ($Name In $Names) {
            Write-Verbose "Name: $Name"

            $headers = @{
                "X-HTTP-Method" = "DELETE";
                "If-Match" = "*"
            }

            try {
                # reset each pass to ensure that prior response isn't reused
                $response=$null
                # $response = Invoke-WebRequest -Uri $endpointUri -Method POST -UseDefaultCredentials -Headers $headers -ContentType "*/*"
            }

            # Invoke-WebRequest throws System.Net.WebException
            catch [System.Net.WebException] {
                throw
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

Set-Alias spra Remove-Attachments
