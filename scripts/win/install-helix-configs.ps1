## Define source and destination paths
$sourceDir = Join-Path "." -ChildPath "helix"
$helixConfigDir = Join-Path $env:APPDATA "helix"

## Ensure the destination directory exists
if (-not (Test-Path $helixConfigDir)) {
    New-Item -ItemType Directory -Path $helixConfigDir -Force | Out-Null
}

## Define files to copy
$filesToCopy = @("config.toml", "languages.toml")

## Copy files
foreach ($file in $filesToCopy) {
    $sourcePath = Join-Path $sourceDir $file
    $destPath = Join-Path $helixConfigDir $file

    if (Test-Path $sourcePath) {
        Copy-Item -Path $sourcePath -Destination $destPath -Force
        Write-Host "Copied $file to $helixConfigDir" -ForegroundColor Green
    }
    else {
        Write-Host "$file not found in $sourceDir" -ForegroundColor Yellow
    }
}
