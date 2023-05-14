#PowerShell: Open a File
Write-Host "`nOpen first .nfo File" -ForegroundColor Green
function Open-FileOne([string] $initialDirectory){
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.filter = "NFO files (*.nfo)| *.nfo"
    $OpenFileDialog.ShowDialog() |  Out-Null
    return $OpenFileDialog.filename
} 

$OpenFileOne = Open-FileOne $env:Path += ";\\NASHDSERVER\MyPassport\BluRay\_REMUX_ALL_"
#PowerShell: Write choisen File to PowerShell
Write-Output $OpenFileOne
# read all lines into `$OpenFileOne`
$FileContentOne = Get-Content $OpenFileOne -Raw
Write-Output $FileContentOne
#PowerShell: Pause for 2 seconds
timeout /t 2 | Out-Null
#PowerShell: Open a File
Write-Host "`nOpen second .nfo File" -ForegroundColor Green
function Open-FileTwo([string] $initialDirectory){
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.filter = "NFO files (*.nfo)| *.nfo"
    $OpenFileDialog.ShowDialog() |  Out-Null
    return $OpenFileDialog.filename
} 

$OpenFileTwo = Open-FileOne $env:Path += ";\\NASHDSERVER\MyPassport\BluRay\_REMUX_ALL_"
#PowerShell: Write choisen File to PowerShell
Write-Output $OpenFileTwo
# read all lines into `$OpenFileTwo`
$FileContentTwo = Get-Content $OpenFileTwo -Raw
Write-Output $FileContentTwo
#PowerShell: Pause for 2 seconds
timeout /t 2 | Out-Null
#PowerShell: Enter the Name of the Output File
Write-Host "`nSet the Name of the Folder" -ForegroundColor Green
$OutputFile = Split-Path $OpenFileOne -leaf
$output_name = $OutputFile -replace ".nfo",""
# write all lines back to file
#[string]::Join(' `n',$FileContentOne,$FileContentTwo)
$Result = [string]::Concat($FileContentOne,$FileContentTwo)
Write-Output $Result
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
$SaveFil = Save-File "\\NASHDSERVER\MyPassport\BluRay\_REMUX_ALL_"
#PowerShell: Create the new File
Add-Content $SaveFil $Result