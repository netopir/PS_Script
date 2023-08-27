# https://learn.microsoft.com/en-us/powershell/scripting/samples/selecting-items-from-a-list-box?view=powershell-7.3

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'enter the playlist number from the scaned BluRay'
$form.Size = New-Object System.Drawing.Size(300,170)
$form.StartPosition = 'CenterScreen'

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(75,90)
$okButton.Size = New-Object System.Drawing.Size(75,25)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(150,90)
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
$listBox.Height = 40

[void] $listBox.Items.Add('Open Folder')
[void] $listBox.Items.Add('Open File')

$form.Controls.Add($listBox)

$form.Topmost = $true

$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $Selecting = $listBox.SelectedItem
    $Selecting
}

if ($Selecting -contains "Open Folder") { 
  # Do something
    $AssemblyFullName = 'System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'
    $Assembly = [System.Reflection.Assembly]::Load($AssemblyFullName)
    $OpenFileDialog = [System.Windows.Forms.OpenFileDialog]::new()
    $OpenFileDialog.AddExtension = $false
    $OpenFileDialog.CheckFileExists = $false
    $OpenFileDialog.DereferenceLinks = $true
    $OpenFileDialog.Filter = "Folders|`n"
    $OpenFileDialog.Multiselect = $false
    $OpenFileDialog.Title = "Select folder"
    $OpenFileDialogType = $OpenFileDialog.GetType()
    $FileDialogInterfaceType = $Assembly.GetType('System.Windows.Forms.FileDialogNative+IFileDialog')
    $IFileDialog = $OpenFileDialogType.GetMethod('CreateVistaDialog',@('NonPublic','Public','Static','Instance')).Invoke($OpenFileDialog,$null)
    $OpenFileDialogType.GetMethod('OnBeforeVistaDialog',@('NonPublic','Public','Static','Instance')).Invoke($OpenFileDialog,$IFileDialog)
    [uint32]$PickFoldersOption = $Assembly.GetType('System.Windows.Forms.FileDialogNative+FOS').GetField('FOS_PICKFOLDERS').GetValue($null)
    $FolderOptions = $OpenFileDialogType.GetMethod('get_Options',@('NonPublic','Public','Static','Instance')).Invoke($OpenFileDialog,$null) -bor $PickFoldersOption
    $FileDialogInterfaceType.GetMethod('SetOptions',@('NonPublic','Public','Static','Instance')).Invoke($IFileDialog,$FolderOptions)
    $VistaDialogEvent = [System.Activator]::CreateInstance($AssemblyFullName,'System.Windows.Forms.FileDialog+VistaDialogEvents',$false,0,$null,$OpenFileDialog,$null,$null).Unwrap()
    [uint32]$AdviceCookie = 0
    $AdvisoryParameters = @($VistaDialogEvent,$AdviceCookie)
    $AdviseResult = $FileDialogInterfaceType.GetMethod('Advise',@('NonPublic','Public','Static','Instance')).Invoke($IFileDialog,$AdvisoryParameters)
    $AdviceCookie = $AdvisoryParameters[1]
    $Result = $FileDialogInterfaceType.GetMethod('Show',@('NonPublic','Public','Static','Instance')).Invoke($IFileDialog,[System.IntPtr]::Zero)
    $FileDialogInterfaceType.GetMethod('Unadvise',@('NonPublic','Public','Static','Instance')).Invoke($IFileDialog,$AdviceCookie)
    if ($Result -eq [System.Windows.Forms.DialogResult]::OK) {
        $FileDialogInterfaceType.GetMethod('GetResult',@('NonPublic','Public','Static','Instance')).Invoke($IFileDialog,$null)
    }
    Write-Output $OpenFileDialog.FileName
}

if ($Selecting -contains "Open File") { 
  # Do something
  function Open-File([string] $initialDirectory){

    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.filter = "All files (*.*)| *.*"
    $OpenFileDialog.ShowDialog() |  Out-Null

    return $OpenFileDialog.filename
  } 

  $OpenFile = Open-File $env:USERPROFILE

  Write-Output $OpenFile

}