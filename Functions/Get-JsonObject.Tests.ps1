$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "Get-JsonObject" {

    # arrange
    $EndpointUrl='http://apps/ReportRequests'
    $ListName='ReportRequests'
    $ItemId=7579

    It "Should return a Json-formatted string" {

        # act
        $actual = Get-JsonObject -Url "$EndpointUrl/_vti_bin/listdata.svc/$ListName($ItemId)"

        # assert
        ($actual).GetType() | Should Be String
        ($actual | ConvertFrom-Json).GetType() | Should Be System.Management.Automation.PsCustomObject

    }

}
