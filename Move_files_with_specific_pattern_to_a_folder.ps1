# Install from Powershell Gallery https://www.powershellgallery.com/packages/PSWriteColor
# Install-Module -Name PSWriteColor
#PowerShell: Set the directory of the Source Path
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
Write-Host "`nSource Path" -ForegroundColor Green
Write-Output $source
#PowerShell: Set the directory of the Destination Path
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
$destination = Get-FolderName
Write-Host "`nDestination Path" -ForegroundColor Green
Write-Output $destination

# https://learn.microsoft.com/en-us/powershell/scripting/samples/selecting-items-from-a-list-box?view=powershell-7.3

Write-Host "`nEnter the Pattern to use" -ForegroundColor Green
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

$nzb = Get-ChildItem $source -Recurse | Where-Object {$_.Name -match $pattern}

Write-Host $nzb -ForegroundColor Red
#PowerShell: Pause for 2 seconds
timeout /t 2 | Out-Null
#Move-Item -Path $nzb.FullName -Destination $destination -Confirm

