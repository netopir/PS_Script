Function Get-FolderName()
{   
    Add-Type -AssemblyName System.Windows.Forms
    $FolderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog -Property @{
        #SelectedPath = 'I:\Temp\Exam data files\’
        ShowNewFolderButton = $false
        Description = "Select folder"
    }
    #If cancel is clicked the script will exit
    If ($FolderBrowser.ShowDialog() -eq "Cancel") {Exit}
    $FolderBrowser.SelectedPath
} #end function Get-FolderName

$DirectoryPath = Get-FolderName

Write-Output $DirectoryPath