$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "Get-PropertyValue" {

  # arrange
  $url='http://apps/ReportRequests'
  $list='ReportRequests'
  $id=7353

  Context "Function parameter is 'value' (default)" {

    $property='ActualHoursDone'

    It "Should returns a field's value" {
        # act
        $Response = Get-PropertyValue -WebUrl $url -listName $list -itemId $id -property $property -verbose

        # asset
        $Response.StatusCode | Should Be 200
    }

  }

  Context "Function parameter is 'count'" {

    $property='Attachments'

    It "Should return a count of a collection" {
        # act
        $Response = Get-PropertyValue -WebUrl $url -listName $list -itemId $id -property $property -function 'count' -verbose

        # asset
        $Response.StatusCode | Should Be 200
    }

    It "Should ignore case" {
        # act
        $Response = Get-PropertyValue -WebUrl $url -listName $list -itemId $id -property $property -function 'COunt' -verbose

        # asset
        $Response.StatusCode | Should Be 200
    }

  }

}
