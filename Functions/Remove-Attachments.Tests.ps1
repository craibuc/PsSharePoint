$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "Remove-Attachments" {

    # arrange

    It -Skip "Should do something useful" {

        # act

        # assert
        $False | Should Be $True

    }

}