$BRdecripted = '[PRiVATE]-[WtFnZb]-[00000.bdjo]-[2+595] - '' yEnc  166 (1+1)
[PRiVATE]-[WtFnZb]-[00000.bdjo]-[217+595] - '' yEnc  166 (1+1)
[PRiVATE]-[WtFnZb]-[00000.clpi]-[3+595] - '' yEnc  464 (1+1)
[PRiVATE]-[WtFnZb]-[00000.clpi]-[218+595] - '' yEnc  464 (1+1)
[PRiVATE]-[WtFnZb]-[00000.jar]-[107+595] - '' yEnc  350631 (1+1)
[PRiVATE]-[WtFnZb]-[00000.jar]-[374+595] - '' yEnc  350631 (1+1)'

$BRfile = ''
$Out_BR = ''
$BRfile = [regex]::Matches($BRdecripted, '(\[PRiVATE\]-\[WtFnZb\]-\[)([a-zA-Z0-9]*.\w{3,4})(\]-\[\d{1,4}\+\d{1,4}\]\s-\s''\syEnc\s*\d{1,11}\s\(\d{1}\+\d{1,5}\))' )
foreach ($line in $BRfile) {
    #Write-output($line.Groups[2].Value)
    $Out_BR += $line.Groups[2].value + "`n"
}
Write-Host $Out_BR

Get-ChildItem -Path . | ForEach-Object { Rename-Item -Path $_ -NewName $(($_.Name -replace '^filename_+','') -replace '_+',' ') }
gci -Recurse -file | where { $_.Name -match '^\(?\d+\)? .+' } | Rename-Item -NewName { $_.Name -replace '^\(?(\d+)\)? (.+)' , '$1-$2' }