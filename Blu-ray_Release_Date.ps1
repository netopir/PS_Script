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
#PowerShell: Returns the specified part of a path
$OutputFileName = Split-Path $FilePathDIZ -Leaf

#PowerShell: 
Write-Host "`nRead .diz File to String" -ForegroundColor Green
$fileContentsBR = Get-Content $FilePathDIZ | Select-String -Pattern "B-R=" -SimpleMatch
$fileContentBR = $fileContentsBR -replace "B-R=",""
Write-Host $fileContentBR
#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null

#PowerShell: 
$HTML = Invoke-RestMethod "$fileContentBR"
#PowerShell: Release Date
$HTMLRD = [regex]::Matches($HTML, "(>(\w{3}) (0[1-9]|1\d|2\d|3[01]), ((19|20)\d{2})<\/a>)" )
$HTMLRD2 = [regex]::Matches($HTML, '((title=")\s*\S*\w*\W*\d*\D*(Release Date)\s(\w[A-Z,a-z]{3,9})\s([1-9]{1,2}),\s((19|20)\d{2})")' )
Write-Host $HTMLRD
Write-Host $HTMLRD2
#$BDInfoRD = $HTMLRD -replace ">","" -replace ",","" -replace "</a",""
foreach ($line in $HTMLRD) {
    #Write-output($line.Groups[1].Value, $line.Groups[2].Value, $line.Groups[3].Value)
    $Out_RD = $line.Groups[3].value + " " + $line.Groups[2].value + " " + $line.Groups[4].value
}
foreach ($line in $HTMLRD2) {
    #Write-output($line.Groups[1].Value, $line.Groups[2].Value, $line.Groups[3].Value)
    $Out_RD2 = $line.Groups[5].value + " " + $line.Groups[4].value + " " + $line.Groups[6].value
}
Write-Host $Out_RD
Write-Host $Out_RD2