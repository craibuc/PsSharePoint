$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "Get-PropertyValue" {

    # arrange
    $url='http://apps/ReportRequests'
    $list='ReportRequests'
    $id=7353
    $property='ActualHoursDone'

    It "Should returns a field's value" {
        # act
        $Response = Get-PropertyValue -WebUrl $url -listName $list -itemId $id -property $property -verbose

        # asset
        $Response.StatusCode | Should Be 200
    }

}
