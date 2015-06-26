$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"
. "$here\Get-PropertyValue"

Describe -Tag 'Attachment' "Get-Attachments" {

  #
  # arrange
  #

  $url='http://apps/ReportRequests'
  $list='ReportRequests'
  $Id=7579
  $props = @('Title','Url','ContentType')

  It -Skip "Should get the request's attachments" {

    #
    # act
    #

    # get the number of attachments /Attachments/$count
    $expected = [int](Get-PropertyValue $url $list $id 'Attachments' 'count' -Verbose).Content
    # get attachments
    $actual = Get-Attachments  -WebUrl $url -listName $list -ItemId $Id -Verbose

    #
    # assert
    #

    # array contains PsCustomObject
    @($actual)[0].GetType()| Should Be System.Management.Automation.PsCustomObject
    # matching totals
    @($actual).Count | Should Be $expected

  }

}