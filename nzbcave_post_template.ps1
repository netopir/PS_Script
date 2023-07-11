#PowerShell: Open a File
Write-Host "`nOpen .diz File" -ForegroundColor Green
function Open-File([string] $initialDirectory){
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $InitialDirectory
    $OpenFileDialog.filter = "DIZ files (*.diz)| *.diz"
    $OpenFileDialog.ShowDialog() |  Out-Null
    return $OpenFileDialog.filename
} 
#PowerShell: 
$FilePathDIZ = Open-File "C:\Users\Martin\Desktop\Usenet_Programms\ngPost_bluray\nzb"
#PowerShell: Write choisen File to PowerShell
Write-Output $FilePathDIZ
#PowerShell: Pause for 2 seconds
timeout /t 2 | Out-Null

#PowerShell: Open a File
Write-Host "`nOpen .nfo File" -ForegroundColor Green
function Open-File([string] $initialDirectory){
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $InitialDirectory
    $OpenFileDialog.filter = "NFO files (*.nfo)| *.nfo"
    $OpenFileDialog.ShowDialog() |  Out-Null
    return $OpenFileDialog.filename
} 
#PowerShell: 
$FilePathNFO = Open-File "C:\Users\Martin\Desktop\Usenet_Programms\ngPost_bluray\nzb"
#PowerShell: Write choisen File to PowerShell
Write-Output $FilePathNFO
#PowerShell: Pause for 2 seconds
timeout /t 2 | Out-Null
#PowerShell: 
$FileNFO = Get-ChildItem "$FilePathNFO"
#PowerShell: 
$DataNFO = Get-Content $FileNFO -Raw
$BDInfo = [RegEx]::Matches($DataNFO, "((QUICK SUMMARY:)[\r\n]{1,}((\s.*\S.*)+(\w.*\W.*)(\d.*\D.*)))").Groups[1].Value
#PowerShell:
Write-Host `n$BDInfo -ForegroundColor Yellow

#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null

Write-Host "`nRead .diz File to String" -ForegroundColor Green
$fileContentsTitel = Get-Content $FilePathDIZ | Select-String -Pattern "Folder=" -SimpleMatch
$TitelOhnePunkt = $fileContentsTitel -replace 'Folder=','' -replace '\.',' '
Write-Host $TitelOhnePunkt -ForegroundColor Yellow
#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null

Write-Host "`nRead .diz File to String" -ForegroundColor Green
$fileContentsIMDB = Get-Content $FilePathDIZ | Select-String -Pattern "IMDB=" -SimpleMatch
$IMDB = $fileContentsIMDB -replace 'IMDB=',''
Write-Host $IMDB -ForegroundColor Yellow
#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null

Write-Host "`nRead .diz File to String" -ForegroundColor Green
$fileContentsBluRay = Get-Content $FilePathDIZ | Select-String -Pattern "B-R=" -SimpleMatch
$BluRay = $fileContentsBluRay -replace 'B-R=',''
Write-Host $BluRay -ForegroundColor Yellow
#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null

Write-Host "`nRead .diz File to String" -ForegroundColor Green
$fileContentsHeader = Get-Content $FilePathDIZ | Select-String -Pattern "Archive=" -SimpleMatch
$Header = $fileContentsHeader -replace 'Archive=',''
Write-Host $Header -ForegroundColor Yellow
#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null

Write-Host "`nRead .diz File to String" -ForegroundColor Green
$fileContentsPassword = Get-Content $FilePathDIZ | Select-String -Pattern "Password=" -SimpleMatch
$Password = $fileContentsPassword -replace 'Password=',''
Write-Host $Password -ForegroundColor Yellow
#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null

#Write-Host "`nRead Input Box to String" -ForegroundColor Green
#Write-Host $BDInfo`n

$TextToTemplate = "[COLOR=rgb(0, 0, 255)][SIZE=6]$TitelOhnePunkt[/SIZE][/COLOR]

$IMDB

$BluRay

[SPOILER=BDInfo]$BDInfo[/SPOILER]

[HIDETHANKS][COLOR=rgb(0, 255, 0)]Header: $Header [COLOR=rgb(255, 255, 255)]| [COLOR=rgb(255, 0, 0)]Passwort: $Password[/HIDETHANKS]
"
Write-Host $TextToTemplate -ForegroundColor DarkMagenta
