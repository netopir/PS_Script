# Install from Powershell Gallery https://www.powershellgallery.com/packages/PSWriteColor
# Install-Module -Name PSWriteColor
#PowerShell: Open a File
Write-Host "`nOpen a File" -ForegroundColor Green
function Open-File([string] $initialDirectory){
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $InitialDirectory
    $OpenFileDialog.filter = "All files (*.*)| *.*"
    $OpenFileDialog.ShowDialog() |  Out-Null
    return $OpenFileDialog.filename
} 
#PowerShell: 
$OpenFile = Open-File "C:\BRtools\BDInfo\REMUX"
#PowerShell: Write choisen File to PowerShell
Write-Output $OpenFile
#PowerShell: Pause for 2 seconds
timeout /t 2 | Out-Null
#PowerShell: Enter the Name of the Output File
# $output_name = Read-Host -Prompt (Write-Color "`nEnter Name:" -Color DarkMagenta -NoNewLine)
Write-Host "`nSet the Name of the Folder" -ForegroundColor Green
$OutputFile = Split-Path $OpenFile -leaf
#PowerShell: 
Write-Host $OutputFile
#PowerShell: Pause for 2 seconds
timeout /t 2 | Out-Null
#PowerShell: Strip some text fom the File
Write-Host "`nStrip Text fom the File" -ForegroundColor Green
$output_name = $OutputFile -replace "BDINFO.","" -replace ".txt",""
#PowerShell: 
Write-Host $output_name
#PowerShell: Pause for 2 seconds
timeout /t 2 | Out-Null
#PowerShell: Read the content of the opened File
$file = Get-Content $OpenFile -raw
$data = [RegEx]::Matches($file, "((QUICK SUMMARY:)[\r\n]{1,}((\s.*\S.*)+(\w.*\W.*)(\d.*\D.*))[\r\n])")
$output = ""
foreach($line in $data) {
    Write-output($line.Groups[1].value) |  Out-Null
    $output += $line[0].Groups[1].value
}
#PowerShell: Set the Save Path
function Save-File([string] $initialDirectory){
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $SaveFileDialog = New-Object System.Windows.Forms.SaveFileDialog
    $SaveFileDialog.initialDirectory = $InitialDirectory
    $SaveFileDialog.FileName = "$($output_name).nfo"
    $SaveFileDialog.filter = "NFO files (*.nfo)| *.nfo"
    $SaveFileDialog.ShowDialog() |  Out-Null
    return $SaveFileDialog.filename
}
#PowerShell: 
$SaveFil = Save-File "\\NASHDSERVER\Public\SabNzb\BluRay\_REMUX_FULL"
#PowerShell: Create the new File
Add-Content $SaveFil $output
#PowerShell: 
# Add-Content "C:\Users\Martin\Desktop\Usenet_Programms\ngPost_bluray\nzb\$output_name.nfo" $output