function Open-File([string] $initialDirectory){

    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.filter = "All files (*.*)| *.*"
    $OpenFileDialog.ShowDialog() |  Out-Null

    return $OpenFileDialog.filename
} 

$OpenFile = Open-File $env:USERPROFILE

Write-Output $OpenFile

Add-Type -AssemblyName System.Windows.Forms
$Folder = New-Object System.Windows.Forms.FolderBrowserDialog
$Folder.ShowNewFolderButton = $true
$Folder.SelectedPath = [System.Environment]::GetFolderPath("NetworkShortcuts")
[void]$Folder.ShowDialog()
$Folder.SelectedPath