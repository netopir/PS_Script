# Install from Powershell Gallery https://www.powershellgallery.com/packages/PSWriteColor
# Install-Module -Name PSWriteColor
#PowerShell: Open a File
Write-Host "`nOpen reup .nzb File" -ForegroundColor Green
function Open-File([string] $initialDirectory){
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $InitialDirectory
    $OpenFileDialog.filter = "NZB files (*.nzb)| *.nzb"
    $OpenFileDialog.ShowDialog() |  Out-Null
    return $OpenFileDialog.filename
} 
#PowerShell: 
$filePathNZBreup = Open-File "C:\Users\Martin\Desktop\Usenet_Programms\ngPost_bluray\nzb"
#PowerShell: Write choisen File to PowerShell
Write-Output $filePathNZBreup
#PowerShell: 
$OutputFile = Split-Path $filePathNZBreup -leaf
$output_name = $OutputFile -replace "_reup","" -replace ".nzb",""
# read all lines into `$filePathNZBx`
Write-Host "`nRead reup .nzb File to String" -ForegroundColor Green
$fileContentReup = Get-Content $filePathNZBreup | Select-Object -Skip 3 | Select -SkipLast 1
Write-Output $fileContentReup
#PowerShell: Open a File
Write-Host "`nOpen org .nzb File" -ForegroundColor Green
function Open-File([string] $initialDirectory){
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $InitialDirectory
    $OpenFileDialog.filter = "NZB files (*.nzb)| *.nzb"
    $OpenFileDialog.ShowDialog() |  Out-Null
    return $OpenFileDialog.filename
} 
#PowerShell: 
$filePathNZBorg = Open-File "C:\Users\Martin\Desktop\Usenet_Programms\ngPost_bluray\nzb"
#PowerShell: Write choisen File to PowerShell
Write-Output $filePathNZBorg
# read all lines into `$fileContents`
$fileContentOrg = Get-Content $filePathNZBorg -Raw
Write-Host $fileContentOrg
# append text to desired line
$textToAdd = $fileContentReup
#PowerShell: 
$fileContentOrg[-2] += "`n$textToAdd"
#PowerShell: 
$fileContentNew = $fileContentOrg
# write all lines back to file
$fileContentNew | Set-Content $fileContentOrg
#PowerShell: Set the Save Path
function Save-File([string] $initialDirectory){
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $SaveFileDialog = New-Object System.Windows.Forms.SaveFileDialog
    $SaveFileDialog.initialDirectory = $InitialDirectory
    $SaveFileDialog.FileName = "$($output_name).nzb"
    $SaveFileDialog.filter = "NZB files (*.nzb)| *.nzb"
    $SaveFileDialog.ShowDialog() |  Out-Null
    return $SaveFileDialog.filename
}
#PowerShell: 
$SaveFil = Save-File "C:\Users\Martin\Desktop\Usenet_Programms\ngPost_bluray\nzb"
#PowerShell: Create the new File
Add-Content $SaveFil $fileContentNew