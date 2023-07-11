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
Write-Host `n$BDInfo