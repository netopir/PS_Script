#PowerShell: Open a File
Write-Host "`nOpen .diz File" -ForegroundColor Green
function Open-File([string] $initialDirectory){
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $InitialDirectory
    $OpenFileDialog.filter = "DIZ files (*.diz)| *.diz"
    $OpenFileDialog.ShowDialog() |  Out-Null
    return $OpenFileDialog.filename
} 
#PowerShell: 
$filePathPW = Open-File "C:\Users\Martin\Desktop\Usenet_Programms\ngPost_bluray\nzb"
#PowerShell: Write choisen File to PowerShell
Write-Output $filePathPW
#PowerShell: Pause for 2 seconds
timeout /t 2 | Out-Null
# read all lines into `$passwordContents`
Write-Host "`nRead .diz File to String" -ForegroundColor Green
$fileContentsPW = Get-Content $filePathPW | Select-String -Pattern "Password=" -SimpleMatch
$fileContentPW = $fileContentsPW -replace "Password=",""
Write-Host $fileContentPW
#PowerShell: Pause for 2 seconds
timeout /t 2 | Out-Null
#PowerShell: 
Write-Host "`nRead .diz File to String" -ForegroundColor Green
$fileContentsF = Get-Content $filePathPW | Select-String -Pattern "Folder=" -SimpleMatch
$fileContentF = $fileContentsF -replace "Folder=",""
Write-Host $fileContentF
#PowerShell: Pause for 2 seconds
timeout /t 2 | Out-Null
#PowerShell: Open a File
Write-Host "`nOpen .nzb File" -ForegroundColor Green
function Open-File([string] $initialDirectory){
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $InitialDirectory
    $OpenFileDialog.filter = "NZB files (*.nzb)| *.nzb"
    $OpenFileDialog.ShowDialog() |  Out-Null
    return $OpenFileDialog.filename
} 
#PowerShell: 
$filePathNZB = Open-File "C:\Users\Martin\Desktop\Usenet_Programms\ngPost_bluray\nzb"
#PowerShell: Write choisen File to PowerShell
Write-Output $filePathNZB
#PowerShell: Pause for 2 seconds
timeout /t 2 | Out-Null
#PowerShell: 
Write-Host "`nShow first 10 Lines of .nzb File" -ForegroundColor Green
$fileShow = Get-Content $filePathNZB -TotalCount 10
foreach ($line in $fileShow) {
    Write-Host $line
}
# read all lines into `$fileContents`
$fileContents = Get-Content $filePathNZB
# Write-Host $fileContents
#PowerShell: Pause for 2 seconds
timeout /t 2 | Out-Null
#PowerShell: 
Write-Host "`nEnter the Line Position" -ForegroundColor Green
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Enter the Line Position'
$form.Size = New-Object System.Drawing.Size(300,290)
$form.StartPosition = 'CenterScreen'

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(75,210)
$okButton.Size = New-Object System.Drawing.Size(75,25)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(150,210)
$cancelButton.Size = New-Object System.Drawing.Size(75,25)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,10)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Please Enter Line Position:'
$form.Controls.Add($label)

$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = New-Object System.Drawing.Point(10,40)
$listBox.Size = New-Object System.Drawing.Size(260,20)
$listBox.Height = 160

[void] $listBox.Items.Add('0')
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
        $LinePosition = $listBox.SelectedItem
    }
Write-Host $LinePosition
#PowerShell: Pause for 2 seconds
timeout /t 2 | Out-Null
# append text to desired line
$lineNumber = $LinePosition
Write-Host "`nShow add Text to .nzb File" -ForegroundColor Magenta
$textToAdd = "<head>
    <meta type=""password"">$fileContentPW</meta>
    <meta type=""title"">$fileContentF</meta>
</head>"
Write-Host $textToAdd
$fileContents[$lineNumber] += "`n$textToAdd"
# write all lines back to file
$fileContents | Set-Content $filePathNZB
#PowerShell: Pause for 2 seconds
timeout /t 2 | Out-Null
#PowerShell: 
Write-Host "`nShow new first 10 Lines of .nzb File" -ForegroundColor Magenta
$fileShowNew = Get-Content $filePathNZB -TotalCount 10
foreach ($line in $fileShowNew) {
    Write-Host $line
}