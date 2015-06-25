$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "Add-Attachments" {

    # arrange
    $url='http://apps/ReportRequests/'
    $list='ReportRequests'
    $id=7579
    $path='C:\Users\cb2215\Desktop\7579.txt'

    It "Should attach a new file" {

        # act
        $Response = Update-Attachments -WebUrl $url -ListName $list -ItemId $id -Paths $path -Verbose

        # assert
        $Response.StatusCode | Should Be 201 # Created

    }

}