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
Write-Host $source -ForegroundColor Green
$LogFile = "$source\All.rar.txt"
if (Test-Path $LogFile) 
    {
        Remove-Item -Verbose -Force $LogFile
        Write-Host "`n$LogFile has been deleted" -ForegroundColor DarkRed
    }
else 
    {
        Write-Host "`n$LogFile doesn't exist" -ForegroundColor DarkYellow
    }
Get-ChildItem "$source" -Filter '*.rar' -Recurse |
Where {$_.Name.substring($_.Name.length -3, 3)  -Match 'rar'} | % {$_.FullName} | Out-File -FilePath "$LogFile" -Append
Invoke-Item "$LogFile"