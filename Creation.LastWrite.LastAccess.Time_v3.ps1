#PowerShell: Open a File
function Open-File([string] $initialDirectory){
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $InitialDirectory
    $OpenFileDialog.filter = "All files (*.*)| *.*"
    $OpenFileDialog.ShowDialog() |  Out-Null
    return $OpenFileDialog.filename
} 
#PowerShell: 
$OpenFile = Open-File "\\NASHDSERVER\Public\SabNzb\BluRay"
#PowerShell: Write choisen File to PowerShell
Write-Output $OpenFile
#PowerShell: 
$GetCreationTime = (Get-Item "$OpenFile").CreationTime.ToString('MM/dd/yyyy HH:mm:ss')
$GetLastWriteTime = (Get-Item "$OpenFile").LastWriteTime.ToString('MM/dd/yyyy HH:mm:ss')
$GetLastAccessTime = (Get-Item "$OpenFile").LastAccessTime.ToString('MM/dd/yyyy HH:mm:ss')
Write-Host $GetCreationTime
Write-Host $GetLastWriteTime
Write-Host $GetLastAccessTime
#PowerShell: Open a File
function Open-File([string] $initialDirectory){
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $InitialDirectory
    $OpenFileDialog.filter = "All files (*.*)| *.*"
    $OpenFileDialog.ShowDialog() |  Out-Null
    return $OpenFileDialog.filename
} 
#PowerShell: 
$SaveFile = Open-File "\\NASHDSERVER\Public\SabNzb\BluRay"
#PowerShell: 
Write-Host "`nSet Creation, LastWrite, LastAccess Time" -ForegroundColor Green
Get-Item  "$SaveFile" | % {$_.CreationTime = $GetCreationTime}
Get-Item  "$SaveFile" | % {$_.LastWriteTime = $GetLastWriteTime}
Get-Item  "$SaveFile" | % {$_.LastAccessTime = $GetLastAccessTime}