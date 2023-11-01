Write-Host "`nCount all files in Folder" -ForegroundColor Green
Write-Host ( Get-ChildItem -File -Recurse 'C:\Users\Martin\Desktop\Usenet_Programms\ngPost_bluray\tmp\' | Measure-Object ).Count -NoNewline 'files'
