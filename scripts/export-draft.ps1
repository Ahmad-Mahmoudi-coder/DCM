[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 | Out-Null

$env:Path = "C:\Model\tools\quarto-1.9.37\bin;" + $env:Path
$projectRoot = "C:\Model\decision-centred-modelling"
Set-Location $projectRoot

$label = if ($args[0]) { $args[0] } else { "draft" }

$drafts = "$projectRoot\_output\drafts"
if (-not (Test-Path $drafts)) {
    New-Item -ItemType Directory -Path $drafts | Out-Null
}

Write-Host "Rendering DOCX..." -ForegroundColor Cyan
quarto render --to docx

Start-Sleep -Seconds 2

$source = Get-ChildItem $projectRoot -Filter "*.docx" -Recurse |
          Where-Object { $_.FullName -notlike "*\_output\drafts\*" } |
          Sort-Object LastWriteTime -Descending |
          Select-Object -First 1

if ($source) {
    $ts = Get-Date -Format "yyyy-MM-dd_HHmm"
    $dest = "$drafts\DCM_${ts}_${label}.docx"
    Copy-Item $source.FullName $dest -Force
    $kb = [math]::Round((Get-Item $dest).Length / 1KB, 1)
    Write-Host ""
    Write-Host "Saved: $dest ($kb KB)" -ForegroundColor Green
    Add-Content "$drafts\export-log.txt" "$(Get-Date -Format 'yyyy-MM-dd HH:mm') | $label | $kb KB | $($source.FullName)"
    Write-Host "Log updated." -ForegroundColor Gray
} else {
    Write-Host ""
    Write-Host "No DOCX found after render. All files in _output:" -ForegroundColor Yellow
    Get-ChildItem "$projectRoot\_output" | Select-Object Name, LastWriteTime
}
