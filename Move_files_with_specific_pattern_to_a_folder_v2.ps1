#PowerShell: Creates a record of all or part of a PowerShell session to a text file.
#Start-Transcript -Path "C:\BRtools\PowerShell\_LOG_Move_files_with_specific_pattern_to_a_folder_v2.txt" -UseMinimalHeader
#PowerShell: 
Function Select-FolderDialog($Description="Select Folder", $RootFolder="MyComputer"){
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null     
        
    $objForm = New-Object System.Windows.Forms.FolderBrowserDialog
    $objForm.RootFolder = $RootFolder
    $objForm.ShowNewFolderButton = $true
    #$objForm.Description = "Please choose a folder"
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
Write-Host "`nSource Path" -ForegroundColor DarkCyan
Write-Host $source -ForegroundColor Magenta
#PowerShell: Pause for 2 seconds
timeout /t 2 | Out-Null
Function Select-FolderDialog($Description="Select Folder", $RootFolder="MyComputer"){
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null     
        
    $objForm = New-Object System.Windows.Forms.FolderBrowserDialog
    $objForm.RootFolder = $RootFolder
    $objForm.ShowNewFolderButton = $true
    #$objForm.Description = "Please choose a folder"
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
$destination = Select-FolderDialog
Write-Host "`nDestination Path" -ForegroundColor DarkCyan
Write-Host $destination -ForegroundColor Magenta
#PowerShell: Pause for 2 seconds
timeout /t 2 | Out-Null
# https://learn.microsoft.com/en-us/powershell/scripting/samples/selecting-items-from-a-list-box?view=powershell-7.3
Write-Host "`nEnter the Pattern to use" -ForegroundColor DarkCyan
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Select a Pattern'
$form.Size = New-Object System.Drawing.Size(300,270)
$form.StartPosition = 'CenterScreen'

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(75,185)
$okButton.Size = New-Object System.Drawing.Size(75,25)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(150,185)
$cancelButton.Size = New-Object System.Drawing.Size(75,25)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,10)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Please Select the eac3to version:'
$form.Controls.Add($label)

$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = New-Object System.Drawing.Point(10,80)
$listBox.Size = New-Object System.Drawing.Size(260,20)
$listBox.Height = 50

[void] $listBox.Items.Add('3D')
[void] $listBox.Items.Add('UHD')
[void] $listBox.Items.Add('COMPLETE')

$form.Controls.Add($listBox)

$form.Topmost = $true

$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $pattern = $listBox.SelectedItem
}
Write-Host $pattern -ForegroundColor Yellow
#PowerShell: Pause for 2 seconds
timeout /t 2 | Out-Null
#PowerShell: 
$nzb = Get-ChildItem $source -Recurse | Where-Object {$_.Name -match "\.$pattern\."}
#PowerShell: 
#Write-Host $nzb -ForegroundColor Red

Write-Host (Get-ChildItem $nzb -Recurse -Directory | Measure-Object).Count "Directorys" -ForegroundColor Yellow
#$directory_count = [System.IO.Directory]::GetDirectories("$nzb").Count
#Write-Host $directory_count "Directorys" -ForegroundColor DarkYellow

Write-Host (Get-ChildItem $nzb -Recurse -File | Measure-Object).Count "Files" -ForegroundColor Yellow
#$file_count = [System.IO.Directory]::GetFiles("$nzb").Count
#Write-Host $file_count "Files" -ForegroundColor DarkYellow

Get-ChildItem $nzb | ForEach-Object -Process {[System.IO.Path]::GetFileNameWithoutExtension($_)}
#PowerShell: Pause for 2 seconds
timeout /t 2 | Out-Null
#Move-Item -Path $nzb.FullName -Destination $destination -Confirm
#PowerShell: The Stop-Transcript cmdlet stops a transcript that was started by the Start-Transcript cmdlet.
#Stop-Transcript