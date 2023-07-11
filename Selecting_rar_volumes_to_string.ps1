Write-Host "`nEnter the rar volumes to use" -ForegroundColor Green
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Select rar volumes'
$form.Size = New-Object System.Drawing.Size(300,300)
$form.StartPosition = 'CenterScreen'

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(75,215)
$okButton.Size = New-Object System.Drawing.Size(75,25)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(150,215)
$cancelButton.Size = New-Object System.Drawing.Size(75,25)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,10)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Please Select the rar volumes:'
$form.Controls.Add($label)

$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = New-Object System.Drawing.Point(10,40)
$listBox.Size = New-Object System.Drawing.Size(260,20)
$listBox.Height = 160

[void] $listBox.Items.Add('50')
[void] $listBox.Items.Add('100')
[void] $listBox.Items.Add('150')
[void] $listBox.Items.Add('200')
[void] $listBox.Items.Add('250')
[void] $listBox.Items.Add('300')
[void] $listBox.Items.Add('350')
[void] $listBox.Items.Add('400')
[void] $listBox.Items.Add('450')
[void] $listBox.Items.Add('500')

$form.Controls.Add($listBox)

$form.Topmost = $true

$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $rarvolumes = $listBox.SelectedItem
}
Write-Host $rarvolumes