Write-Host "`nEnter the Rate of redundancy to use" -ForegroundColor Green
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Select Rate of redundancy'
$form.Size = New-Object System.Drawing.Size(300,450)
$form.StartPosition = 'CenterScreen'

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(75,365)
$okButton.Size = New-Object System.Drawing.Size(75,25)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(150,365)
$cancelButton.Size = New-Object System.Drawing.Size(75,25)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,10)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Please Select the Rate of redundancy:'
$form.Controls.Add($label)

$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = New-Object System.Drawing.Point(10,40)
$listBox.Size = New-Object System.Drawing.Size(260,20)
$listBox.Height = 310

[void] $listBox.Items.Add('5')
[void] $listBox.Items.Add('10')
[void] $listBox.Items.Add('15')
[void] $listBox.Items.Add('20')
[void] $listBox.Items.Add('25')
[void] $listBox.Items.Add('30')
[void] $listBox.Items.Add('35')
[void] $listBox.Items.Add('40')
[void] $listBox.Items.Add('45')
[void] $listBox.Items.Add('50')
[void] $listBox.Items.Add('55')
[void] $listBox.Items.Add('60')
[void] $listBox.Items.Add('65')
[void] $listBox.Items.Add('70')
[void] $listBox.Items.Add('75')
[void] $listBox.Items.Add('80')
[void] $listBox.Items.Add('85')
[void] $listBox.Items.Add('90')
[void] $listBox.Items.Add('95')
[void] $listBox.Items.Add('100')

$form.Controls.Add($listBox)

$form.Topmost = $true

$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $par2redundancy = $listBox.SelectedItem
}
Write-Host $par2redundancy