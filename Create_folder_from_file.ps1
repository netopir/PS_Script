$foldername= Get-Content -Path 'C:\BRtools\PowerShell\A-Z.txt' #Provide the Path where the list is kept
$dirpath='\\NASHDSERVER\MyPassport\BluRay\_REMUX_ALL_' #The Path where you need to create the folders
foreach ($folder in $foldername)
{
New-Item -ItemType Directory -Path $dirpath\$folder
}