#PowerShell: Open a File
Write-Host "`nOpen .txt File" -ForegroundColor Green
function Open-File([string] $initialDirectory){
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $InitialDirectory
    $OpenFileDialog.filter = "TXT files (*.txt)| *.txt"
    $OpenFileDialog.ShowDialog() |  Out-Null
    return $OpenFileDialog.filename
} 
#PowerShell: 
$OpenFile = Open-File "C:\Users\Martin\Desktop\TXT"
#PowerShell: Write choisen File to PowerShell
Write-Output $OpenFile
#PowerShell: 
$FolderName= Get-Content $OpenFile
#PowerShell: 
Write-Output $FolderName
#PowerShell: Set the Save Path
Function Get-FolderName()
{   
    Add-Type -AssemblyName System.Windows.Forms
    $FolderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog -Property @{
        ShowNewFolderButton = $false
        #Description = "Select folder"
    }
    #If cancel is clicked the script will exit
    If ($FolderBrowser.ShowDialog() -eq "Cancel") {Exit}
    $FolderBrowser.SelectedPath
} #end function Get-FolderName
$source = Get-FolderName
#PowerShell: 
Write-Host $source -ForegroundColor Green
#PowerShell: 
foreach ($folder in $FolderName)
{
New-Item -ItemType Directory -Path "$source\$folder"
}