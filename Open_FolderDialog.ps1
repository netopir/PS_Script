Function Select-FolderDialog($Description="Select Folder", $RootFolder="MyComputer"){
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null     
        
    $objForm = New-Object System.Windows.Forms.FolderBrowserDialog
    $objForm.RootFolder = $RootFolder
    $objForm.ShowNewFolderButton = $true
    $objForm.Description = "Please choose a folder"
    $Show = $objForm.ShowDialog()
    If ($Show -eq "OK")
    {
        Return $objForm.SelectedPath
    }
    Else
    {
        Write-Error "Operation cancelled by user."
    }
}
$source = Select-FolderDialog
Write-Host $source -ForegroundColor Cyan