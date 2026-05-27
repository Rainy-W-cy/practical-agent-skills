param(
    [Parameter(Mandatory = $true)]
    [string]$Path
)

$ErrorActionPreference = 'Stop'
$resolved = (Resolve-Path -LiteralPath $Path).Path
$ppt = $null
$pres = $null

try {
    $ppt = New-Object -ComObject PowerPoint.Application
    $pres = $ppt.Presentations.Open($resolved, -1, 0, 0)
    $slides = @()

    foreach ($slide in $pres.Slides) {
        $texts = @()
        foreach ($shape in $slide.Shapes) {
            try {
                if ($shape.HasTextFrame -eq -1 -and $shape.TextFrame.HasText -eq -1) {
                    $value = $shape.TextFrame.TextRange.Text.Trim()
                    if ($value) {
                        $texts += $value
                    }
                }
            }
            catch {
            }
        }

        $slides += [PSCustomObject]@{
            Index = $slide.SlideIndex
            ShapeCount = $slide.Shapes.Count
            Text = $texts
        }
    }

    [PSCustomObject]@{
        Path = $resolved
        SlideCount = $pres.Slides.Count
        PageWidth = $pres.PageSetup.SlideWidth
        PageHeight = $pres.PageSetup.SlideHeight
        Slides = $slides
    } | ConvertTo-Json -Depth 5
}
finally {
    if ($pres -ne $null) {
        $pres.Close()
        [void][System.Runtime.InteropServices.Marshal]::ReleaseComObject($pres)
    }
    if ($ppt -ne $null) {
        $ppt.Quit()
        [void][System.Runtime.InteropServices.Marshal]::ReleaseComObject($ppt)
    }
    [GC]::Collect()
    [GC]::WaitForPendingFinalizers()
}

