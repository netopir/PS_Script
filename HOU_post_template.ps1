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
$fileContentsTMDB = Get-Content $FilePathDIZ | Select-String -Pattern "TMDB=" -SimpleMatch
$DescriptionTMDBlink = $fileContentsTMDB -replace 'TMDB=',''
Write-Host $DescriptionTMDBlink -ForegroundColor Yellow
#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null

$DescriptionTMDBadd = '?language=de-DE'
$DescriptionTMDB = [string]::Join('',$DescriptionTMDBlink,$DescriptionTMDBadd)
Write-Host $DescriptionTMDB -ForegroundColor Yellow
$HTMLDescription = Invoke-RestMethod -Uri $DescriptionTMDB
#Write-Host $HTMLDescription
# (<meta name="description" content=")(\s*\S*\w*\W*\d*\D*\r*\n*\s*\S*\w*\W*\d*\D*)(">)
$Beschreibung = ''
$_i=0
$TMDBDescription = [regex]::Matches($HTMLDescription, '(?s)(<meta name="description" content=")(.*?)(">)' )
#Write-Host $TMDBDescription
foreach ($line in $TMDBDescription) {
    #Write-output($line.Groups[2].Value)
    $Beschreibung += $line.Groups[2].value + ", " + $(If ($_i -eq 15) {"`r`n"})
    if ($_i -eq 15) {
        $_i=0
        $Beschreibung += "`t "
    } 
    $_i++
}
Write-Host "`nDescription to String" -ForegroundColor Green
Write-Host $Beschreibung -ForegroundColor Yellow

#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null

Write-Host "`nRead .diz File to String" -ForegroundColor Green
$fileContentsTitel = Get-Content $FilePathDIZ | Select-String -Pattern "Folder=" -SimpleMatch
$TitelOhnePunkt = $fileContentsTitel -replace 'Folder=','' -replace '\.',' '
Write-Host $TitelOhnePunkt -ForegroundColor Yellow
#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null

Write-Host "`nRead .diz File to String" -ForegroundColor Green
$fileContentsPosterGER = Get-Content $FilePathDIZ | Select-String -Pattern "Poster_GER=" -SimpleMatch
$Cover = $fileContentsPosterGER -replace 'Poster_GER=',''
Write-Host $Cover -ForegroundColor Yellow
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

$TextToTemplate = "`n[CENTER]
[SIZE=8][B][COLOR=blue]$TitelOhnePunkt[/color][/B][/SIZE]

[IMGS=450]$Cover[/IMGS]

$Beschreibung

[SPOILER=BDInfo]$BDInfo[/SPOILER]

[SPOILER=NZB][COLOR=rgb(0, 255, 0)]Header: $Header [COLOR=rgb(255, 255, 255)]| [COLOR=rgb(255, 0, 0)]Passwort: $Password[/COLOR][/SPOILER]

[HR][/HR]

Bei Problemen mit dem Download bitte hier im Beitrag auf 'Melden' klicken.
[/Center]
"
Write-Host $TextToTemplate  -ForegroundColor DarkMagenta

Write-Host "`nRead .diz File to String" -ForegroundColor Green
$fileContentsIMDB = Get-Content $FilePathDIZ | Select-String -Pattern "IMDB=" -SimpleMatch
$IMDB = $fileContentsIMDB -replace 'IMDB=https://www.imdb.com/title/','' -replace '/',''
Write-Host $IMDB -ForegroundColor Yellow
#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null