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
Write-Output $source
$FolderSize = "{0:N2} MB" -f ((Get-ChildItem $source -Recurse | Measure-Object -Property Length -Sum -ErrorAction Stop).Sum / 1MB)
Write-Output $FolderSize