#$data = [RegEx]::Matches($file, "(QUICK SUMMARY:)[\r\n]{1,}((\s.*\S.*)+(\w.*\W.*)+(\d.*\D.*))")
$input_file = Read-Host -Prompt (Write-Color "Enter File Name:" -Color DarkMagenta -NoNewLine)
$input_path = "C:\BRtools\BDInfo\REMUX\$input_file"
$output_path = Read-Host -Prompt (Write-Color "`nEnter Path:" -Color DarkMagenta -NoNewLine)
$output_name = Read-Host -Prompt (Write-Color "`nEnter Name:" -Color DarkMagenta -NoNewLine)
$file = Get-Content $OpenFile -raw
$data = [RegEx]::Matches($file, "((QUICK SUMMARY:)[\r\n]{1,}((\s.*\S.*)+(\w.*\W.*)(\d.*\D.*)))")
$output = ""
foreach($line in $data) {
    Write-output($line.Groups[1].value)
    $output += $line[0].Groups[1].value
}
Add-Content "$output_path\$output_name.nfo" $output 