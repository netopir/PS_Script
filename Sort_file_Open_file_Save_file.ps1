#PowerShell: Open a File
function Open-File([string] $initialDirectory){
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $InitialDirectory
    $OpenFileDialog.filter = "All files (*.*)| *.*"
    $OpenFileDialog.ShowDialog() |  Out-Null
    return $OpenFileDialog.filename
} 
#PowerShell: 
$OpenFile = Open-File "\\NASHDSERVER\Public\SabNzb\BluRay\_REMUX_FULL"
#PowerShell: Write choisen File to PowerShell
Write-Output $OpenFile
#PowerShell: 
$GetCreationTime = (Get-Item "$OpenFile").CreationTime.ToString('MM/dd/yyyy HH:mm:ss')
$GetLastWriteTime = (Get-Item "$OpenFile").LastWriteTime.ToString('MM/dd/yyyy HH:mm:ss')
$GetLastAccessTime = (Get-Item "$OpenFile").LastAccessTime.ToString('MM/dd/yyyy HH:mm:ss')
Write-Host $GetCreationTime
Write-Host $GetLastWriteTime
Write-Host $GetLastAccessTime
function Sort-STNumerical {
    [CmdletBinding()]
    Param(
        [Parameter(
            Mandatory = $True,
            ValueFromPipeline = $True,
            ValueFromPipelineBypropertyName = $True)]
        [System.Object[]]
        $InputObject,
        
        [ValidateRange(2, 100)]
        [Byte]
        $MaximumDigitCount = 100,

        [Switch] $Descending
    )
    
    Begin {
        [System.Object[]] $InnerInputObject = @()

        [Bool] $SortDescending = $False
        if ($Descending) {
            $SortDescending = $True
        }
    }
    
    Process {
        $InnerInputObject += $InputObject
    }

    End {
        $InnerInputObject |
            Sort-Object -Property `
                @{ Expression = {
                    [Regex]::Replace($_, '(\d+)', {
                        "{0:D$MaximumDigitCount}" -f [Int] $Args[0].Value })
                    }
                },
                @{ Expression = { $_ } } -Descending:$SortDescending
    }
}
#PowerShell: Sort Open file
Write-Host "`nSort Open file" -ForegroundColor Green
(Get-Content "$OpenFile") | Sort-STNumerical | Set-Content "$OpenFile"
#PowerShell: Remove blank lines from a file
Write-Host "`nRemove blank lines from a file" -ForegroundColor Green
(Get-Content "$OpenFile") | Where-Object {$_.trim() -ne "" } | Set-Content "$OpenFile"
#PowerShell: 
Write-Host "`nSet Creation, LastWrite, LastAccess Time" -ForegroundColor Green
Get-Item  "$OpenFile" | % {$_.CreationTime = $GetCreationTime}
Get-Item  "$OpenFile" | % {$_.LastWriteTime = $GetLastWriteTime}
Get-Item  "$OpenFile" | % {$_.LastAccessTime = $GetLastAccessTime}
#(Get-Item "$OpenFile").CreationTime=($GetCreationTime)
#(Get-Item "$OpenFile").LastWriteTime=($GetLastWriteTime) 
#(Get-Item "$OpenFile").LastAccessTime=($GetLastAccessTime)