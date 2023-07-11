# https://learn.microsoft.com/en-us/powershell/scripting/samples/selecting-items-from-a-list-box?view=powershell-7.3

Write-Host "`nEnter the eac3to version to use" -ForegroundColor Green
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Select eac3to version'
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

[void] $listBox.Items.Add('C:\BRtools\eac3to\eac3to.exe')
[void] $listBox.Items.Add('C:\BRtools\eac3to\eac3to_v3.34.exe')
[void] $listBox.Items.Add('C:\BRtools\eac3to\eac3to_v3.36.exe')

$form.Controls.Add($listBox)

$form.Topmost = $true

$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $eac3toPath = $listBox.SelectedItem
}
Write-Host $eac3toPath