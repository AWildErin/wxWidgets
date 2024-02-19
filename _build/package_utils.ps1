function CopyDirectory
{
    param
    (
        [string]$InDir,
        [string]$OutDir
    )

    Write-Debug "Operation for CopyDirectory -InDir $InDir -OutDir $OutDir"

    # Create the destination folder if it doesn't exist
    if (-not (Test-Path $OutDir)) {
        New-Item -ItemType Directory -Force -Path $OutDir | Out-Null
    }

    # Copy the entire directory and its contents recursively
    Copy-Item -Path $InDir -Destination $OutDir -Recurse -Force | Out-Null
}

function CopyGlob
{
    param
    (
        [string]$InDir,
        [string]$OutDir,
        [string]$Filter = "wxmsw*.dll"
    )

    Write-Debug "Operation for CopyGlob -InDir $InDir -OutDir $OutDir -Ext $Filter"

    # Create the output folder if it doesn't exist
    if (-not (Test-Path $OutDir)) {
        New-Item -ItemType Directory -Force -Path $OutDir | Out-Null
    }

    # Get all DLL files in the source folder
    $Files = Get-ChildItem -Path $InDir -Filter "$Filter"

    # Loop over each DLL file
    foreach ($File in $Files)
    {
        Write-Debug "Copying $($File.Name)"
        Copy-Item -Path $File.FullName -Destination $OutDir -Force
    }

}
