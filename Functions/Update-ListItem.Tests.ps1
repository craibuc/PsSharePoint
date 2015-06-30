$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"
. "$here\Get-PropertyValue.ps1"

Describe "Update-ListItem" {

    # arrange
    $url='http://apps/ReportRequests'
    $list='ReportRequests'
    $id=7353

    $Today = [DateTime](Get-Date -format 'yyyy-MM-dd')
    $Today = $Today.ToLocalTime()
    Write-Host "Today: $Today"

    $testCases = @(
        #@{ Name='ProjectName'; Expected=$("Lorem Ipsum: $(get-date -format o)"); Type=[string] }
        @{ Name='DevelopmentCompletedDate'; Expected=$Today; Type=[datetime] }
        #@{ Name='ActualHoursDone'; Expected=15.75; Type=[decimal] }
    )
<#
    BeforeEach {
        # store original value
        # $orignal = Get-PropertyValue -WebUrl $url -listName $list -itemId $id -Property $Name -Verbose
        # Write-Host "Original: $Original"
    }
    AfterEach {
        # restore field's orignial value
        # $payload=@{$Name=$Original}
        # $response = Update-ListItem -WebUrl $url -listName $list -itemId $id -properties $payload -verbose
    }
#>
    It -Skip "Should modify a <Name> to be <Expected>" -TestCases $testCases {
        param ($Name, $Expected, $Type)

        # archive
        $original = (Get-PropertyValue -WebUrl $url -listName $list -itemId $id -Property $Name).Content

        #
        # act
        #

        # update
        # convert values that resemble dates to UTC?
            
        $payload=@{$Name=$Expected}
        $response = Update-ListItem -WebUrl $url -listName $list -itemId $id -properties $payload #-verbose

        # get results
        $actual = (Get-PropertyValue -WebUrl $url -listName $list -itemId $id -Property $Name).Content
        #if ($Type -eq [datetime]) {$actual = ([datetime]$actual).ToLocalTime()}

        # restore
        $payload=@{$Name=$original}
        Update-ListItem -WebUrl $url -listName $list -itemId $id -properties $payload #-verbose

        # assert
        $response.StatusCode | Should Be 204 # No Content 
        $actual | Should Be $Expected

    } # It

}
