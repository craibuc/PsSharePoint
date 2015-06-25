$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "Update-ListItem" {

    # arrange

    It "Should do something useful" {

        # act

        # assert
        $False | Should Be $True

    }

}
