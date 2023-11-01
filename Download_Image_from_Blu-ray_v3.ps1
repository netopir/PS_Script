$Prenosi = "C:\Users\Martin\Downloads"

$ImageURL = "https://images.static-bluray.com/movies/covers/354_front.jpg"

$FileName = ([uri]"$ImageURL").Segments[-1]

Write-Output $FileName

Invoke-WebRequest $ImageURL -OutFile "$Prenosi\$FileName"
