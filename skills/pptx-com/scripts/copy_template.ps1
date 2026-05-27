param(
    [Parameter(Mandatory = $true)]
    [string]$InputPath,
    [Parameter(Mandatory = $true)]
    [string]$OutputPath,
    [switch]$Overwrite
)

$ErrorActionPreference = 'Stop'
$source = (Resolve-Path -LiteralPath $InputPath).Path
$target = [System.IO.Path]::GetFullPath($OutputPath)

if ((Test-Path -LiteralPath $target) -and -not $Overwrite) {
    throw "Output already exists. Obtain overwrite confirmation or choose a new output path: $target"
}

$directory = Split-Path -Parent $target
if (-not (Test-Path -LiteralPath $directory)) {
    throw "Output directory does not exist: $directory"
}

Copy-Item -LiteralPath $source -Destination $target -Force:$Overwrite

[PSCustomObject]@{
    Source = $source
    Output = $target
    OriginalUntouched = $true
} | ConvertTo-Json

