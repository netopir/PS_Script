#PowerShell: Open a .diz File
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

#PowerShell: Open a .nfo File
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
Write-Host "`nBDInfo to String" -ForegroundColor Green
Write-Host `n$BDInfo -ForegroundColor Yellow

#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null

Write-Host "`nRead .diz File to String" -ForegroundColor Green
$FileContentsTMDBlink = Get-Content $FilePathDIZ | Select-String -Pattern "TMDB=" -SimpleMatch
$TMDBlink = $FileContentsTMDBlink -replace 'TMDB=',''
Write-Host $TMDBlink -ForegroundColor Yellow
#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null

$TMDBaddlink = '?language=de-DE'
$TMDBurl = [string]::Join('',$TMDBlink,$TMDBaddlink)
Write-Host $TMDBurl -ForegroundColor Yellow

$Beschreibung = ''
$Out_TMDBrt = ''
$Out_TMDBrd = ''
$Out_TMDBv = ''
$GenersOut = ''
$ProgressPreference = 'SilentlyContinue'
$HTML = Invoke-RestMethod "$TMDBurl"

$_i=0
$TMDBDescription = [regex]::Matches($HTML, '(?s)(<meta name="description" content=")(.*?)(">)' )
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

#PowerShell: Release Date
$HTMLTMDBrt = [regex]::Matches($HTML, '<span class="runtime">\r*\n*\s*((\d{0,})h\s*(\d{1,})m)\r*\n*\s*<\/span>' )
foreach ($line in $HTMLTMDBrt) {
    #Write-output($line.Groups[1].Value)
    $Out_TMDBrt = $line.Groups[1].value
}
# Write-Host $Out_TMDB
$TimeString = $Out_TMDBrt -replace "h","" -replace " ",":" -replace "m",""
$TimeStringWithPeriod = $TimeString.Replace(",",".")
$TimeSpan = [TimeSpan]::Parse($TimeStringWithPeriod)
$TotalMinutes = $TimeSpan.TotalMinutes
$RoundMinutes = [Math]::Round($TotalMinutes)
Write-Host "`nMinutes to String" -ForegroundColor Green
Write-Host $RoundMinutes min -ForegroundColor Yellow

#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null

$HTMLTMDBrd = [regex]::Matches($HTML, '<span class="release">\r*\n*\s*(\d{1,2}.\d{1,2}.\d{4})\s*.*\r*\n*\s*<\/span>' )
foreach ($line in $HTMLTMDBrd) {
    #Write-output($line.Groups[1].Value)
    $Out_TMDBrd = $line.Groups[1].value
}
# Write-Host $Out_TMDBrd
# Get-Date $Out_TMDBrd -Format 'yyyy-MM-dd'
# $DateStr = $Out_TMDBrd.ToString("yyyy-MM-dd")
$FormatDate = (Get-Date $Out_TMDBrd).ToString('yyyy-MM-dd')
Write-Host "`nDate to String" -ForegroundColor Green
Write-Host $FormatDate -ForegroundColor Yellow

#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null

$HTMLTMDBs = [regex]::Matches($HTML, '<div class="user_score_chart" data-percent="(\d{1,}.\d{1,})" data-track-color="#.*" data-bar-color="#.*">' )
foreach ($line in $HTMLTMDBs) {
    #Write-output($line.Groups[1].Value)
    $Out_TMDBs = $line.Groups[1].value
}
#Write-Host $Out_TMDBs
$Score = $Out_TMDBs
$FormatScore = "{0:N2}" -f $Score/10 -replace ",","."
Write-Host "`nScore to String" -ForegroundColor Green
Write-Host $FormatScore -ForegroundColor Yellow

#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null

$HTMLTMDBg = [regex]::Matches($HTML, '<span class="genres">\r*\n*\s*<a href="(.*)\r*\n*\s*<\/span>' )
foreach ($line in $HTMLTMDBg) {
    #Write-output($line.Groups[1].Value)
    $Out_TMDBg = $line.Groups[1].value
}
$RegexGenre = $Out_TMDBg
$Genre01 = [RegEx]::Matches($RegexGenre, "(>Abenteuer<)")
$Genre02 = [RegEx]::Matches($RegexGenre, "(>Action<)")
$Genre03 = [RegEx]::Matches($RegexGenre, "(>Animation<)")
$Genre04 = [RegEx]::Matches($RegexGenre, "(>Biographie<)")
$Genre05 = [RegEx]::Matches($RegexGenre, "(>Bollywood<)")
$Genre06 = [RegEx]::Matches($RegexGenre, "(>Doku<)")
$Genre07 = [RegEx]::Matches($RegexGenre, "(>Dokumentarfilm<)")
$Genre08 = [RegEx]::Matches($RegexGenre, "(>Erotik<)")
$Genre09 = [RegEx]::Matches($RegexGenre, "(>Familie<)")
$Genre10 = [RegEx]::Matches($RegexGenre, "(>Fantasy<)")
$Genre11 = [RegEx]::Matches($RegexGenre, "(>Historie<)")
$Genre12 = [RegEx]::Matches($RegexGenre, "(>Horror<)")
$Genre13 = [RegEx]::Matches($RegexGenre, "(>Komödie<)")
$Genre14 = [RegEx]::Matches($RegexGenre, "(>Krieg<)")
$Genre15 = [RegEx]::Matches($RegexGenre, "(>Krimi<)")
$Genre16 = [RegEx]::Matches($RegexGenre, "(>Kurzfilm<)")
$Genre17 = [RegEx]::Matches($RegexGenre, "(>Liebe<)")
$Genre18 = [RegEx]::Matches($RegexGenre, "(>Liebesfilm<)")
$Genre19 = [RegEx]::Matches($RegexGenre, "(>Musik<)")
$Genre20 = [RegEx]::Matches($RegexGenre, "(>Mystery<)")
$Genre21 = [RegEx]::Matches($RegexGenre, "(>Reality<)")
$Genre22 = [RegEx]::Matches($RegexGenre, "(>Romantik<)")
$Genre23 = [RegEx]::Matches($RegexGenre, "(>Science-Fiction<)")
$Genre24 = [RegEx]::Matches($RegexGenre, "(>Sci-Fi<)")
$Genre25 = [RegEx]::Matches($RegexGenre, "(>Sport<)")
$Genre26 = [RegEx]::Matches($RegexGenre, "(>Talk<)")
$Genre27 = [RegEx]::Matches($RegexGenre, "(>Thriller<)")
$Genre28 = [RegEx]::Matches($RegexGenre, "(>TV-Film<)")
$Genre29 = [RegEx]::Matches($RegexGenre, "(>Western<)")
foreach($line in $Genre01) {
    $GenersOut += $line.Groups[1].value.replace(">","").replace("<"," ") + ", "
}
foreach($line in $Genre02) {
    $GenersOut += $line.Groups[1].value.replace(">","").replace("<"," ") + ", "
}
foreach($line in $Genre03) {
    $GenersOut += $line.Groups[1].value.replace(">","").replace("<"," ") + ", "
}
foreach($line in $Genre04) {
    $GenersOut += $line.Groups[1].value.replace(">","").replace("<"," ") + ", "
}
foreach($line in $Genre05) {
    $GenersOut += $line.Groups[1].value.replace(">","").replace("<"," ") + ", "
}
foreach($line in $Genre06) {
    $GenersOut += $line.Groups[1].value.replace(">","").replace("<"," ") + ", "
}
foreach($line in $Genre07) {
    $GenersOut += $line.Groups[1].value.replace(">","").replace("<"," ") + ", "
}
foreach($line in $Genre08) {
    $GenersOut += $line.Groups[1].value.replace(">","").replace("<"," ") + ", "
}
foreach($line in $Genre09) {
    $GenersOut += $line.Groups[1].value.replace(">","").replace("<"," ") + ", "
}
foreach($line in $Genre10) {
    $GenersOut += $line.Groups[1].value.replace(">","").replace("<"," ") + ", "
}
foreach($line in $Genre11) {
    $GenersOut += $line.Groups[1].value.replace(">","").replace("<"," ") + ", "
}
foreach($line in $Genre12) {
    $GenersOut += $line.Groups[1].value.replace(">","").replace("<"," ") + ", "
}
foreach($line in $Genre13) {
    $GenersOut += $line.Groups[1].value.replace(">","").replace("<"," ") + ", "
}
foreach($line in $Genre14) {
    $GenersOut += $line.Groups[1].value.replace(">","").replace("<"," ") + ", "
}
foreach($line in $Genre15) {
    $GenersOut += $line.Groups[1].value.replace(">","").replace("<"," ") + ", "
}
foreach($line in $Genre16) {
    $GenersOut += $line.Groups[1].value.replace(">","").replace("<"," ") + ", "
}
foreach($line in $Genre17) {
    $GenersOut += $line.Groups[1].value.replace(">","").replace("<"," ") + ", "
}
foreach($line in $Genre18) {
    $GenersOut += $line.Groups[1].value.replace(">","").replace("<"," ") + ", "
}
foreach($line in $Genre19) {
    $GenersOut += $line.Groups[1].value.replace(">","").replace("<"," ") + ", "
}
foreach($line in $Genre20) {
    $GenersOut += $line.Groups[1].value.replace(">","").replace("<"," ") + ", "
}
foreach($line in $Genre21) {
    $GenersOut += $line.Groups[1].value.replace(">","").replace("<"," ") + ", "
}
foreach($line in $Genre22) {
    $GenersOut += $line.Groups[1].value.replace(">","").replace("<"," ") + ", "
}
foreach($line in $Genre23) {
    $GenersOut += $line.Groups[1].value.replace(">","").replace("<"," ") + ", "
}
foreach($line in $Genre24) {
    $GenersOut += $line.Groups[1].value.replace(">","").replace("<"," ") + ", "
}
foreach($line in $Genre25) {
    $GenersOut += $line.Groups[1].value.replace(">","").replace("<"," ") + ", "
}
foreach($line in $Genre26) {
    $GenersOut += $line.Groups[1].value.replace(">","").replace("<"," ") + ", "
}
foreach($line in $Genre27) {
    $GenersOut += $line.Groups[1].value.replace(">","").replace("<"," ") + ", "
}
foreach($line in $Genre28) {
    $GenersOut += $line.Groups[1].value.replace(">","").replace("<"," ") + ", "
}
foreach($line in $Genre29) {
    $GenersOut += $line.Groups[1].value.replace(">","").replace("<"," ") + ", "
}
$Geners = $GenersOut -replace ".{2}$"
Write-Host "`nGeners to String" -ForegroundColor Green
Write-Host ($Geners) -ForegroundColor Yellow

Write-Host "`nRead .diz File to String" -ForegroundColor Green
$fileContentsTitel = Get-Content $FilePathDIZ | Select-String -Pattern "Folder=" -SimpleMatch
$TitelOhnePunkt = $fileContentsTitel -replace 'Folder=','' -replace '\.',' '
$Tite = $fileContentsTitel -replace 'Folder=',''
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

$StringToTemplate = "<center><b>$TitelOhnePunkt</b></center>
<p><br></p>
<br>
<center><img src=`"$Cover`" width=`"220`" height=`"330`"></center>
<p><br></p>
<center><b>Beschreibung</b></center
<br><center><em><span style=`"font-size: 10pt`">$FormatDate  -   $Geners   -  $RoundMinutes min  -  $FormatScore</span></em></center
<p><br></p><p><br></p>
<p></p><center>$Beschreibung</center>
<br>
<pre data-file=`"NFO`" data-highlighter=`"plain`">$BDInfo</pre>


<sc-hide>
	<center>
		<p>$TitelOhnePunkt</p>
		<p>[headertable='$Header','$Password'][/headertable]</p>
		<br>
		<p>
			<strong>NZB-Datei beim Indexer:</strong><br>
			<a href=`"https://nzbindex.nl/?q=$Header`" target=`"_blank`">NZBIndex</a>
			–
			<a href=`"https://binsearch.info/?q=$Header`" target=`"_blank`">Binsearch</a>
			–
			<a href=`"https://nzbking.com/?q=$Header`" target=`"_blank`">NZBKing</a>
		</p>
		<p>
			<strong>NZBLNK™ Link:</strong><br>
			[nzblnk]nzblnk:?t=$Tite&amp;h=$Header&amp;p=$Password[/nzblnk]
		</p>
	</center>
</sc-hide>
"
Write-Host $StringToTemplate -ForegroundColor DarkMagenta

Set-Clipboard -Value $StringToTemplate