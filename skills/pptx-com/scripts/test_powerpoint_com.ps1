param(
    [switch]$Visible
)

$ErrorActionPreference = 'Stop'
$ppt = $null
$pres = $null

try {
    $ppt = New-Object -ComObject PowerPoint.Application
    if ($Visible) {
        $ppt.Visible = -1
    }
    $pres = $ppt.Presentations.Add()
    $slide = $pres.Slides.Add(1, 1)
    $slide.Shapes.Title.TextFrame.TextRange.Text = 'COM availability test'

    [PSCustomObject]@{
        ComAvailable = $true
        SlidesCreated = $pres.Slides.Count
        SavedFile = $false
    } | ConvertTo-Json
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

