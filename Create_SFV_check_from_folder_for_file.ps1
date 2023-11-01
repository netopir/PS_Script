$sfvdirectory = "C:\Users\Martin\Desktop\Usenet_Programms\ngPost_bluray\sfv_md5.exe"

$archivename = 'SdLNoPDSLiAEpasUMhbLRiEETECRTDYMlTDMFEnBinSEXAADaERoEOUCaDsA'

$destination = "C:\Users\Martin\Desktop\Usenet_Programms\ngPost_bluray\tmp\Mondbasis.Alpha.1.1975.S01.DiSC.6.EXTENDED.REMASTERED.DUAL.COMPLETE.BLURAY-Fiona"

Set-Location $destination

& $sfvdirectory c /u "$archivename.sfv" *.rar