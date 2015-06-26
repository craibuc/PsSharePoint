$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"
. "$here\Get-PropertyValue.ps1"

Describe "Update-ListItem" {

    # arrange
    $url='http://apps/ReportRequests'
    $list='ReportRequests'
    $id=7353

    $fields=@('ProjectName','DevelopmentCompletedDate')
#    $fields+=@{ProjectName=$null}
#    $fields+=@{DevelopmentCompletedDate=$null}

    BeforeEach {
        # store original value
    }
    AfterEach {
        # reset field
    }

    It -Skip "Should modify a text field" {

        # arrange
        $payload=@{ProjectName="Lorem Ipsum: $(get-date -format o)"}

        # act
        $response = Update-ListItem -WebUrl $url -listName $list -itemId $id -properties $payload -verbose

        # assert
        $response.StatusCode | Should Be 204 # No Content 

    }

    It -Skip "Should modify a date/time field" {

        # arrange
        $Today = [DateTime](Get-Date -format 'yyyy-MM-dd')
        $Today = $Today.ToLocalTime()
        $payload=@{DevelopmentCompletedDate=$Today}

        # act
        $response = Update-ListItem -WebUrl $url -listName $list -itemId $id -properties $payload -verbose

        # assert
        $response.StatusCode | Should Be 204 # No Content 

    }

}
