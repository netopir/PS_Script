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
$OpenFile = Open-File "\\NASHDSERVER\Public\SabNzb\BluRay\_REMUX_FULL"
#PowerShell: Write choisen File to PowerShell
Write-Output $OpenFile
#PowerShell: Creation.LastWrite.LastAccess.Time_v1
$GetCreationTime = (Get-Item "$OpenFile").CreationTime.ToString('MM/dd/yyyy HH:mm:ss')
$GetLastWriteTime = (Get-Item "$OpenFile").LastWriteTime.ToString('MM/dd/yyyy HH:mm:ss')
$GetLastAccessTime = (Get-Item "$OpenFile").LastAccessTime.ToString('MM/dd/yyyy HH:mm:ss')
Write-Host $GetCreationTime
Write-Host $GetLastWriteTime
Write-Host $GetLastAccessTime