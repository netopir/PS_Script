# C:\Users\Martin\Desktop\Usenet_Programms\nzbCheck\nzbCheck.ps1
#
# Syntax: nzbcheck (options)* -i <nzb file>
# --help             : Help: display syntax
# -v or --version    : app version
# --progress         : display progress bar
# -d or --debug      : display debug information
# -q or --quit       : quiet mode (no output on stdout)
# -i or --input      : input file : nzb file to check
#
# you can provide servers in one string using -S and/or split the parameters for ONE SINGLE server
# -S or --server     : NNTP server following the format (<user>:<pass>@@@)?<host>:<port>:<nbCons>:(no)?ssl
# -h or --host       : NNTP server hostname (or IP)
# -P or --port       : NNTP server port
# -s or --ssl        : use SSL
# -u or --user       : NNTP server username
# -p or --pass       : NNTP server password
# -n or --connection : number of NNTP connections
#
# Examples:
# nzbcheck --progress -S "user:password@@@news.usenetserver.com:563:50:ssl" -i /nzb/myNzbFile.nzb
# nzbcheck --quiet -h news.usenetserver.com -P 563 -u user -p password -n 50 -s -i /nzb/myNzbFile.nzb
#

$StartTime = (Get-Date)

$nzbCheckEXE = "C:\Users\Martin\Desktop\Usenet_Programms\nzbCheck\nzbcheck.exe"

$Server = ""
$Hosts = 'post.eweka.nl'
$Port = '119'
$SSL  = 'false'
$User = ''
$Pass = ''
$Connection = '25'

Write-Host "`nOpen .nzb File" -ForegroundColor Green
function Open-File([string] $initialDirectory){
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $InitialDirectory
    $OpenFileDialog.filter = "NZB files (*.nzb)| *.nzb"
    $OpenFileDialog.ShowDialog() |  Out-Null
    return $OpenFileDialog.filename
} 
$filePathNZB = Open-File "C:\Users\Martin\Desktop\Usenet_Programms\ngPost_bluray\nzb"
Write-Output $filePathNZB

& "$nzbCheckEXE" --progress -h "$Hosts" -P "$Port" -u "$User" -p "$Pass" -n "$Connection" -i "$filePathNZB"

$EndTime = (Get-Date) 
Write-Host "`nShow duration of the Script" -ForegroundColor Green
$ElapsedTime = $EndTime-$StartTime
'Duration: {0:hh} h {0:mm} min {0:ss} sec' -f $ElapsedTime
$EndTimeOut = Get-Date -UFormat %T
Write-Output $EndTimeOut
