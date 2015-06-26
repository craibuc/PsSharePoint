$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "Update-Attachments" {

    # arrange
    $url='http://apps/ReportRequests/'
    $list='ReportRequests'
    $id=7579
    $path='C:\Users\cb2215\Desktop\7579.txt'

    It -Skip "Should update an existing attachment" {

        # act
        $Response = Update-Attachments -WebUrl $url -ListName $list -ItemId $id -Paths $Path -verbose

        # assert
        $Response.statuscode | Should Be 200

    }

}

<#
url:     $WebUrl/_vti_bin/listdata.svc/$ListName($ItemId)/Attachments
method:  POST
headers: "X-HTTP-Method" = "MERGE";"If-Match" = "*"
result:  (405) Method Not Allowed
ContentType: "*/*"
#>