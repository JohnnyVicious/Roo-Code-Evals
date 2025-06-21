# Description: Downloads all Exercism PowerShell exercises and prepares them for use.
# Usage: Run this script in a PowerShell environment where the Exercism CLI is installed.
# Prerequisites: Ensure you have the Exercism CLI installed and configured with your API key.
$slugs = (Invoke-RestMethod `
            -Uri "https://exercism.org/api/v2/tracks/powershell/exercises"`
         ).exercises.slug

foreach ($slug in $slugs) {
    # --- skip if the exercise folder is already there ---
    if (Test-Path -LiteralPath $slug -PathType Container) {
        Write-Host "✓  $slug   (already downloaded – skipping)" -ForegroundColor Yellow
        continue
    }

    # Build an array of arguments
    $args = @('download', '--track=powershell', "--exercise=$slug")

    # Show the exact command for your records
    Write-Host "exercism $($args -join ' ')"

    # Call the CLI with the arguments separated
    & exercism @args

    Start-Sleep -s 5
}

# Iterate *only* the first-level folders (one per slug)
Get-ChildItem -Directory | ForEach-Object {

    $exercisePath = $_.FullName

    # 1. Create "docs" if it isn't there yet
    $docsPath = Join-Path $exercisePath 'docs'
    if (-not (Test-Path $docsPath)) {
        New-Item -ItemType Directory -Path $docsPath | Out-Null
    }

    # 2. Move README.md inside docs
    $readme = Join-Path $exercisePath 'README.md'
    if (Test-Path $readme) {
        Move-Item -Path $readme -Destination $docsPath -Force
    }

    # 3. Remove the .exercism metadata folder
    $meta = Join-Path $exercisePath '.exercism'
    if (Test-Path $meta) {
        Remove-Item -Path $meta -Recurse -Force
    }

    # 4. Delete the boilerplate HELP.md file
    $help = Join-Path $exercisePath 'HELP.md'
    if (Test-Path $help) {
        Remove-Item -Path $help -Force
    }
}