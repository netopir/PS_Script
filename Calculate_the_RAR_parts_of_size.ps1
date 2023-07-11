$source = "\\NASHDSERVER\Public4\SabNzb\BluRay\Imax.Sea.Rex.3D.2010.AVC.DTS.HD-MA5.1-Untouched"
$rarvolumes = 150

Write-Host "`nShow the Size of Source Folder" -ForegroundColor Green
$FolderSize = "{0:N0}" -f ((Get-ChildItem $source -Recurse | Measure-Object -Property Length -Sum -ErrorAction Stop).Sum / 1MB)
Write-Output $FolderSize

Write-Host "`nRemove dots from the Numbers" -ForegroundColor Green
$OnlyNumbers = $folderSize.Replace('.','')
Write-Output $OnlyNumbers

Write-Host "`nShow the Resolt of Rar" -ForegroundColor Green
$RarFiles = ( $OnlyNumbers / $rarvolumes )
[math]::round($RarFiles)