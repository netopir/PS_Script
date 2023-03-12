Write-Host "`nEnter the Source path" -ForegroundColor Green
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Enter the Source path'
$form.Size = New-Object System.Drawing.Size(300,270)
$form.StartPosition = 'CenterScreen'

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(75,180)
$okButton.Size = New-Object System.Drawing.Size(75,25)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(150,180)
$cancelButton.Size = New-Object System.Drawing.Size(75,25)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,10)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Please Enter Source path:'
$form.Controls.Add($label)

$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = New-Object System.Drawing.Point(10,40)
$listBox.Size = New-Object System.Drawing.Size(260,20)
$listBox.Height = 130

[void] $listBox.Items.Add('\\NASHDSERVER\TV Shows 2')
[void] $listBox.Items.Add('\\NASHDSERVER\TV Shows 3')
[void] $listBox.Items.Add('\\NASHDSERVER\TV Shows 4')
[void] $listBox.Items.Add('\\NASHDSERVER\Movie 2')
[void] $listBox.Items.Add('\\NASHDSERVER\Movie 3')
[void] $listBox.Items.Add('\\NASHDSERVER\Movie 4')
[void] $listBox.Items.Add('\\NASHDSERVER\Cartoon 1')

$form.Controls.Add($listBox)

$form.Topmost = $true

$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $source = $listBox.SelectedItem
}
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
Write-Host "$LogFile" -ForegroundColor Green
Invoke-Item "$LogFile"