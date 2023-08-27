Function Get-FolderName
{
[CmdletBinding()]
    [OutputType([string])]
    Param
    (
        # InitialDirectory help description
        [Parameter(
            Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Initial Directory for browsing",
            Position = 0)]
        [String]$SelectedPath,

        # Description help description
        [Parameter(
            Mandatory = $false,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Message Box Title")]
        [String]$Description="Select a Folder",

        # ShowNewFolderButton help description
        [Parameter(
            Mandatory = $false,
            HelpMessage = "Show New Folder Button when used")]
        [Switch]$ShowNewFolderButton
    )

    # Load Assembly
    Add-Type -AssemblyName System.Windows.Forms

    # Open Class
    $FolderBrowser= New-Object System.Windows.Forms.FolderBrowserDialog

   # Define Title
    $FolderBrowser.Description = $Description

    # Define Initial Directory
    if (-Not [String]::IsNullOrWhiteSpace($SelectedPath))
    {
        $FolderBrowser.SelectedPath=$SelectedPath
    }

    if($folderBrowser.ShowDialog() -eq "OK")
    {
        $Folder += $FolderBrowser.SelectedPath
    }
    return $Folder
}
Write-Output $FolderBrowser