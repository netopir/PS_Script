$sfvdirectory = "C:\Users\Martin\Desktop\Usenet_Programms\ngPost_bluray\sfv_md5.exe"

$archivename = 'SdLNoPDSLiAEpasUMhbLRiEETECRTDYMlTDMFEnBinSEXAADaERoEOUCaDsA'

$destination = "C:\Users\Martin\Desktop\Usenet_Programms\"

Set-Location $destination

& $sfvdirectory c /u "$archivename.sfv" *.rar
