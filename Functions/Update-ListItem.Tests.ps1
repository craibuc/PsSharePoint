$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "Update-ListItem" {

    # arrange
    $url='http://apps/ReportRequests'
    $list='ReportRequests'
    $id=7353
    $payload=@{ProjectName="Lorem Ipsum: $(get-date -format o)"}

    It "Should modify a list item's state" {

        # act
        $response = Update-ListItem -WebUrl $url -listName $list -itemId $id -properties $payload -verbose

        # assert
        $response.StatusCode | Should Be 204 # No Content 

    }

}
