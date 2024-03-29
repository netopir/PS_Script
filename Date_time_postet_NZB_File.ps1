﻿# https://learn.microsoft.com/en-us/powershell/scripting/samples/creating-a-custom-input-box?view=powershell-7.3
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Set the UNIXTIME'
$form.Size = New-Object System.Drawing.Size(350,150)
$form.StartPosition = 'CenterScreen'

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(100,70)
$okButton.Size = New-Object System.Drawing.Size(75,25)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(180,70)
$cancelButton.Size = New-Object System.Drawing.Size(75,25)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(17.5,10)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Please Enter UNIXTIME:'
$form.Controls.Add($label)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(17.5,30)
$textBox.Size = New-Object System.Drawing.Size(300,60)
$form.Controls.Add($textBox)

$form.Topmost = $true

$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $unixTimeStamp = $textBox.Text
    Write-Host $unixTimeStamp -ForegroundColor Yellow
}
#$unixTimeStamp = "1683189358"  
$date=(Get-Date 01.01.1970)+([System.TimeSpan]::fromseconds($unixTimeStamp))  
$DateStr = $date.ToString("dd-MM-yyyy HH:mm:ss")
Write-Host "`n$DateStr" -ForegroundColor Green