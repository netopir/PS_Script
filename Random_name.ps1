$foldername = "The.Wolverine.2013.Extended.Blu-ray.EUR.1080p.DTS-HD.MA.7.1-GMslbenfica"
$archivename = $foldername.Replace('.',''). `
                           Replace('-',''). `
                           Replace(' ',''). `
                           Replace('0',''). `
                           Replace('1',''). `
                           Replace('2',''). `
                           Replace('3',''). `
                           Replace('4',''). `
                           Replace('5',''). `
                           Replace('6',''). `
                           Replace('7',''). `
                           Replace('8',''). `
                           Replace('9','')
timeout /t 2 | Out-Null
#([regex]::Matches($archivename,'.','RightToLeft') | ForEach {$_.value}) -join ''
$test = (Get-Random -Count 250 -InputObject ([char[]]$archivename)) -join ''
Write-Output $test
