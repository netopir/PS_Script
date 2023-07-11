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
$FilePathDIZ = Open-File "C:\Users\Martin\Desktop\Usenet_Programms\ngPost_bluray\nzb"
#PowerShell: Write choisen File to PowerShell
Write-Output $FilePathDIZ
#PowerShell: Pause for 2 seconds
timeout /t 2 | Out-Null
#PowerShell: Returns the specified part of a path
$OutputFileName = Split-Path $FilePathDIZ -Leaf
#PowerShell: Combines objects from the pipeline into a single string 
#PowerShell: method is used to replace old characters with new characters or text in a given string
$Output_Name = $OutputFileName -replace ".diz","" ### $Output_Name = -join ($OutputFileName, "-XREL") -replace ".diz",""

### https://github.com/n2501r/spiderzebra/blob/master/PowerShell/GUI_Text_Box.ps1
#PowerShell: Input text box
Write-Host "`nGet Text to Read" -ForegroundColor Green
Function GUI_TextBox ($Input_Type){

    ### Creating the form with the Windows forms namespace
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
    $form = New-Object System.Windows.Forms.Form
    $form.Text = 'Enter the appropriate information' ### Text to be displayed in the title
    $form.Size = New-Object System.Drawing.Size(800,900) ### Size of the window
    $form.StartPosition = 'CenterScreen'  ### Optional - specifies where the window should start
    $form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedToolWindow  ### Optional - prevents resize of the window
    $form.TopMost = $True  ### Optional - Opens on top of other windows

    ### Adding an OK button to the text box window
    $OKButton = New-Object System.Windows.Forms.Button
    $OKButton.Location = New-Object System.Drawing.Point(400,825) ### Location of where the button will be
    $OKButton.Size = New-Object System.Drawing.Size(75,23) ### Size of the button
    $OKButton.Text = 'OK' ### Text inside the button
    $OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $form.AcceptButton = $OKButton
    $form.Controls.Add($OKButton)

    ### Adding a Cancel button to the text box window
    $CancelButton = New-Object System.Windows.Forms.Button
    $CancelButton.Location = New-Object System.Drawing.Point(320,825) ### Location of where the button will be
    $CancelButton.Size = New-Object System.Drawing.Size(75,23) ### Size of the button
    $CancelButton.Text = 'Cancel' ### Text inside the button
    $CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    $form.CancelButton = $CancelButton
    $form.Controls.Add($CancelButton)

    ### Putting a label above the text box
    $label = New-Object System.Windows.Forms.Label
    $label.Location = New-Object System.Drawing.Point(10,10) ### Location of where the label will be
    $label.AutoSize = $True
    $Font = New-Object System.Drawing.Font("Arial",12,[System.Drawing.FontStyle]::Bold) ### Formatting text for the label
    $label.Font = $Font
    $label.Text = $Input_Type ### Text of label, defined by the parameter that was used when the function is called
    $label.ForeColor = 'Black' ### Color of the label text
    $form.Controls.Add($label)

    ### Inserting the text box that will accept input
    $textBox = New-Object System.Windows.Forms.TextBox
    $textBox.Location = New-Object System.Drawing.Point(10,40) ### Location of the text box
    $textBox.Size = New-Object System.Drawing.Size(775,775) ### Size of the text box
    $textBox.Multiline = $true ### Allows multiple lines of data
    $textbox.AcceptsReturn = $true ### By hitting enter it creates a new line
    $textBox.ScrollBars = "Vertical" ### Allows for a vertical scroll bar if the list of text is too big for the window
    $form.Controls.Add($textBox)

    $form.Add_Shown({$textBox.Select()}) ### Activates the form and sets the focus on it
    $result = $form.ShowDialog() ### Displays the form 

    ### If the OK button is selected do the following
    if ($result -eq [System.Windows.Forms.DialogResult]::OK)
    {
        ### Removing all the spaces and extra lines
        $x = $textBox.Lines | Where{$_} | ForEach{ $_.Trim() }
        ### Putting the array together
        $array = @()
        ### Putting each entry into array as individual objects
        $array = $x -split "`r`n"
        ### Sending back the results while taking out empty objects
        Return $array | Where-Object {$_ -ne ''}
    }

    ### If the cancel button is selected do the following
    if ($result -eq [System.Windows.Forms.DialogResult]::Cancel)
    {
        Write-Host "User Canceled" -BackgroundColor Red -ForegroundColor White
        Write-Host "Press any key to exit..."
        #$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        Exit
    }

}

### Computer Name(s) example of how to utilize the GUI_TextBox function
$BDInfo = GUI_TextBox "Input Text:" ### Calls the text box function with a parameter and puts returned input in variable
$BDInfo_Count = $BDInfo | Measure-Object | % {$_.Count} ### Measures how many objects were inputted

#$BDInfo_Count = Select-String -InputObject $Computers -Pattern "Audio:" -AllMatches
#$BDInfo_Count.Matches.Count

If ($BDInfo_Count -eq 0){ ### If the count returns 0 it will throw and error
    Write-Host "Nothing was inputed..." -BackgroundColor Red -ForegroundColor White -NoNewline;   write-host ([char]0xA0)
    Return
}
Else { ### If there was actual data returned in the input, the script will continue
    Write-Host "Number of text entered:" $BDInfo_Count -BackgroundColor Cyan -ForegroundColor Black -NoNewline;   write-host ([char]0xA0)
    #$BDInfo
    ### Here is where you would put your specific code to take action on those computers inputted
}
#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null

Write-Host "`nRead .diz File to String" -ForegroundColor Green
$fileContentsName = Get-Content $FilePathDIZ | Select-String -Pattern "Folder=" -SimpleMatch
$fileContentName = $fileContentsName -replace "Folder=",""
Write-Host $fileContentName
#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null

Write-Host "`nRead .diz File to String" -ForegroundColor Green
$fileContentsIMDB = Get-Content $FilePathDIZ | Select-String -Pattern "IMDB=" -SimpleMatch
$fileContentIMDB = $fileContentsIMDB -replace "IMDB=",""
Write-Host $fileContentIMDB -ForegroundColor Yellow
#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null

Write-Host "`nRead .diz File to String" -ForegroundColor Green
$fileContentsBR = Get-Content $FilePathDIZ | Select-String -Pattern "B-R=" -SimpleMatch
$fileContentBR = $fileContentsBR -replace "B-R=",""
Write-Host $fileContentBR -ForegroundColor Yellow
#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null

$BDInfoAudio_Count = ([regex]::Matches($BDInfo, "Audio:" )).count ### Regex how many objects were found
Write-Host $BDInfoAudio_Count "Audio Files" -ForegroundColor Yellow
#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null

$BDInfoSubtitle_Count = ([regex]::Matches($BDInfo, "Subtitle:" )).count ### Regex how many objects were found
Write-Host $BDInfoSubtitle_Count "Subtitle Files" -ForegroundColor Yellow
#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null

$BDInfo_DiscSize = [regex]::Matches($BDInfo, "(Disc\sSize:)\s*(\d{2},\d{3},\d{3},\d{3})" )
Write-Host $BDInfo_DiscSize -ForegroundColor Yellow
#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null
$BDInfo_DiscSizeReplace = $BDInfo_DiscSize -replace "Disc Size: ","" -replace ",",""
Write-Host $BDInfo_DiscSizeReplace -ForegroundColor Green
#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null
$BDInfo_DiscSizeConvert = "$BDInfo_DiscSizeReplace"
$BDInfo_DiscSizeGB = [math]::Round(($BDInfo_DiscSizeConvert / 1GB),2)
Write-Host $BDInfo_DiscSizeGB -ForegroundColor Yellow
#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null
$BDInfo_DiscSizeMB = [math]::Round($BDInfo_DiscSizeConvert / 1MB)
Write-Host $BDInfo_DiscSizeMB -ForegroundColor Yellow
#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null

$BDInfo_Length = [regex]::Matches($BDInfo, "(Length:)\s(\d{1,}:\d{2}:\d{2}.\d{3})" )
Write-Host $BDInfo_Length -ForegroundColor Yellow
#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null
$BDInfo_LengthReplace = $BDInfo_Length -replace "Length: ","" -replace ",",""
Write-Host $BDInfo_LengthReplace -ForegroundColor Green
$BDInfo_Length_Formatting = Get-Date "$BDInfo_LengthReplace"
$BDInfo_Length_Duration = '{0:hh} h {0:mm} min' -f $BDInfo_Length_Formatting
#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null

$Out_Video = ''
#Regex (Video:)\s*\S*\w*\W*\d*\D*(AVC|MVC|HEVC|VC-1|MPEG-2)\s*\S*\w*\W*\d*\D*(\d{5,6}\D*kbps)\s*\S*\w*\W*\d*\D*(1080i|1080p|2160p)\s*\S*\w*\W*\d*\D*((\d{2}|\d{2}.\d{3})\D*fps)
$BDInfo_Video = [regex]::Matches($BDInfo, "(Video:)\s*\w*\W*\d*\s*(AVC|MVC|HEVC|VC-1|MPEG-2)\s*\S*\w*\W*\d*\D*(\d{1,2},\d{3}\s*kbps|\d{5,6}\D*kbps)\s*\S*\w*\W*\d*\D*(1080i|1080p|2160p)\s*\S*\w*\W*\d*\D*((\d{2}|\d{2}.\d{3})\D*fps)" )
foreach ($line in $BDInfo_Video) {
    #Write-output($line.Groups[1].Value, $line.Groups[2].Value, $line.Groups[3].Value)
    $Out_Video = $line.Groups[2].value + " | " + $line.Groups[3].value + " | " + $line.Groups[4].value
    $Out_Framerate = $line.Groups[5].value
}
#Write-Host $BDInfo_Video -ForegroundColor Yellow
Write-Host $Out_Video -ForegroundColor Green
#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null
#Write-Host $BDInfo_Video -ForegroundColor Yellow
Write-Host $Out_Framerate -ForegroundColor Green
#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null

$Out_Audio = ''
$_i=1
$BDInfo_Audio = [regex]::Matches($BDInfo, "(Audio:)\s*(\w*)\s\/\s(\w*\D*\s*\w*\s*\w*)\s\/\s(\d.\d)" )
foreach ($line in $BDInfo_Audio) {
    #Write-output($line.Groups[1].Value, $line.Groups[2].Value, $line.Groups[3].Value, $line.Groups[4].Value)
    if ($_i -eq 1) {
        $Out_Audio += "`tAudio.........: "+$line.Groups[2].Value, $line.Groups[3].Value, $line.Groups[4].Value + "`n"
    } else {
        $Out_Audio += "`t                "+$line.Groups[2].Value, $line.Groups[3].Value, $line.Groups[4].Value + "`n"
    }
    $_i++
}
#Write-Host $BDInfo_Audio -ForegroundColor Yellow
Write-Host $Out_Audio -ForegroundColor Green
#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null

$Out_Subtitle = ''
$_i=0
$BDInfo_Subtitle = [regex]::Matches($BDInfo, "(Subtitle:)\s*(\w*)" )
foreach ($line in $BDInfo_Subtitle) {
    #Write-output($line.Groups[2].Value)
    $Out_Subtitle += $line.Groups[2].Value + ", " + $(If ($_i -eq 5) {"`r`n"})
    if ($_i -eq 5) {
        $_i=0
        $Out_Subtitle += "`t                "
    } 
    $_i++
}
#Write-Host $BDInfo_Subtitle -ForegroundColor Yellow
Write-Host $out_Subtitle -ForegroundColor Green
#PowerShell: Pause for 1 seconds
timeout /t 1 | Out-Null

#PowerShell: 
$Out_RD = ''
$ProgressPreference = 'SilentlyContinue'
$HTML = Invoke-RestMethod "$fileContentBR"
#PowerShell: Release Date
$HTMLRD = [regex]::Matches($HTML, "(>(\w{3}) (0[1-9]|1\d|2\d|3[01]), ((19|20)\d{2})<\/a>)" )
#$HTMLRD2 = [regex]::Matches($HTML, '((title=")\s*\S*\w*\W*\d*\D*(Release Date)\s(\w[A-Z,a-z]{3,9})\s([1-9]{1,2}),\s((19|20)\d{2})")' )
foreach ($line in $HTMLRD) {
    #Write-output($line.Groups[1].Value, $line.Groups[2].Value, $line.Groups[3].Value)
    $Out_RD = $line.Groups[3].value + " " + $line.Groups[2].value + " " + $line.Groups[4].value
}
#foreach ($line in $HTMLRD2) {
    #Write-output($line.Groups[1].Value, $line.Groups[2].Value, $line.Groups[3].Value)
    #$Out_RD2 = $line.Groups[5].value + " " + $line.Groups[4].value + " " + $line.Groups[6].value
#}

#PowerShell: 
$Out_IMDB = ''
$ProgressPreference = 'SilentlyContinue'
$HTMLGenres = Invoke-RestMethod "$fileContentIMDB"
#PowerShell: Release Date
$HTMLIMDB = [regex]::Matches($HTMLGenres, '(<span class="ipc-chip__text">(\w+|\S+)<\/span>)' )
foreach ($line in $HTMLIMDB) {
    #Write-output($line.Groups[2].Value)
    $Out_IMDB += $line.Groups[2].value + " "
}

#Audio.Σ.......: $BDInfoAudio_Count Audios
#Subtitles.Σ...: $BDInfoSubtitle_Count Subtitles
$TextToNFO = "$fileContentName

`tIMDB..........: $fileContentIMDB
`tBlu-ray.......: $fileContentBR

`tRelease.Date..: $Out_RD
`tGenres........: $Out_IMDB

`tRuntime.......: $BDInfo_Length_Duration
`tSize..........: $BDInfo_DiscSizeGB GB - [$BDInfo_DiscSizeMB MB]

`tVideo.........: $Out_Video
`tFramerate.....: $Out_Framerate

$Out_Audio
`tSubtitles.....: $out_Subtitle
"
Write-Host $TextToNFO -ForegroundColor DarkMagenta
#PowerShell: Set the Save Path
function Save-File([string] $initialDirectory){
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $SaveFileDialog = New-Object System.Windows.Forms.SaveFileDialog
    $SaveFileDialog.initialDirectory = $InitialDirectory
    $SaveFileDialog.FileName = "$($Output_Name).nfo"
    $SaveFileDialog.filter = "NFO files (*.nfo)| *.nfo"
    $SaveFileDialog.ShowDialog() |  Out-Null
    return $SaveFileDialog.filename
}
#PowerShell: 
$SaveFil = Save-File "C:\Users\Martin\Desktop\Usenet_Programms\ngPost_bluray\nzb\xREL"
#PowerShell: Create the new File
Set-Content $SaveFil $TextToNFO

#PowerShell: 
Remove-Variable * -Force -ErrorAction SilentlyContinue