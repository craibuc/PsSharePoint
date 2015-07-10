Write-Host "Importing module PsSharePoint..."

#
# load (dot-source) *.PS1 files, excluding unit-test scripts (*.Tests.*), and disabled scripts (__*)
#
Get-ChildItem "$PSScriptRoot\Functions\*.ps1" | 
    Where-Object { $_.Name -like '*.ps1' -and $_.Name -notlike '__*' -and $_.Name -notlike '*.Tests*' } | 
    % { . $_ }

Export-ModuleMember Get-PsCustomObject, Get-JsonObject

# ListItem
Export-ModuleMember Get-ListItem, Update-ListItem, Get-PropertyValue
#Export-ModuleMember -Alias spgli, spuli

# ListItem Attachments
Export-ModuleMember Add-Attachments, Update-Attachments, Remove-Attachments, Get-Attachments, Save-Attachments
#Export-ModuleMember -Alias spaa, spua
