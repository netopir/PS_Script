$TimeString = "2:03:14.387"
$TimeStringWithPeriod = $TimeString.Replace(",",".")
$TimeSpan = [TimeSpan]::Parse($TimeStringWithPeriod)
$TotalMinutes = $TimeSpan.TotalMinutes
$Round = [Math]::Round($TotalMinutes)
Write-Host $Round