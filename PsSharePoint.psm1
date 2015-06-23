Write-Host "Importing module PsSharePoint..."

#
# load (dot-source) *.PS1 files, excluding unit-test scripts (*.Tests.*), and disabled scripts (__*)
#
Get-ChildItem "$PSScriptRoot\*.ps1" | 
    Where-Object { $_.Name -like '*.ps1' -and $_.Name -notlike '__*' -and $_.Name -notlike '*.Tests*' } | 
    % { . $_ }

Export-ModuleMember Add-Attachments, Update-ListItem, Get-ListItem

Export-ModuleMember -Alias spaa, spuli, spgli 