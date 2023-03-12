$source = 'C:\BRtools\BDInfo\REMUX'
$destination = 'C:\BRtools\BDInfo\REMUX\Scene'
$pattern = 'COMPLETE'

$bdinfo = Get-ChildItem $source -filter *.txt -recurse 

foreach($item in $bdinfo) {
    if (Select-String -list -pattern $pattern -path $item.fullname) {
        Move-Item -Path $item.fullname -Destination $destination
    }
}