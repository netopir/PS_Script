Write-Host "`nEnter the playlist number from the scaned BluRay" -ForegroundColor Green
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Enter the playlist number'
$form.Size = New-Object System.Drawing.Size(300,285)
$form.StartPosition = 'CenterScreen'

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(75,200)
$okButton.Size = New-Object System.Drawing.Size(75,25)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(150,200)
$cancelButton.Size = New-Object System.Drawing.Size(75,25)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,10)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Please Enter Play List:'
$form.Controls.Add($label)

$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = New-Object System.Drawing.Point(10,40)
$listBox.Size = New-Object System.Drawing.Size(260,20)
$listBox.Height = 140

[void] $listBox.Items.Add('1')
[void] $listBox.Items.Add('2')
[void] $listBox.Items.Add('3')
[void] $listBox.Items.Add('4')
[void] $listBox.Items.Add('5')
[void] $listBox.Items.Add('6')
[void] $listBox.Items.Add('7')
[void] $listBox.Items.Add('8')
[void] $listBox.Items.Add('9')

$form.Controls.Add($listBox)

$form.Topmost = $true

$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $playlist = $listBox.SelectedItem
}
Write-Host $playlist