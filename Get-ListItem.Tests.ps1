$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "Get-ListItem" {

    # arrange

    It "Should do something useful" {

        # act

        # assert
        $False | Should Be $True

    }

}