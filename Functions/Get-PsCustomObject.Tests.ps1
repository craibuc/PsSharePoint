$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "Get-PsCustomObject" {

  $EndpointUrl='http://apps/ReportRequests'
  $ListName='ReportRequests'
  $ItemId=7579

  It "Should return a PsCustomObject" {
      # act
      $actual = Get-PsCustomObject -Url "$EndpointUrl/_vti_bin/listdata.svc/$ListName($ItemId)"

      # assert
      ($actual).GetType() | Should Be System.Management.Automation.PsCustomObject

  }

}
