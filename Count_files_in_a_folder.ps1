﻿Write-Host "`nCount all files in Folder" -ForegroundColor Green
Write-Host ( Get-ChildItem -File -Recurse 'C:\Users\Martin\Desktop\Usenet_Programms\ngPost_bluray\tmp\Bad.Boys.For.Life.2020.MULTi.COMPLETE.BLURAY-GLiMMER' | Measure-Object ).Count -NoNewline 'files'