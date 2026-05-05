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

$source = "$projectRoot\_output\Decision-Centred-Thinking-and-Modelling.docx"
$ts = Get-Date -Format "yyyy-MM-dd_HHmm"
$dest = "$drafts\DCM_${ts}_${label}.docx"

if (Test-Path $source) {
    Copy-Item $source $dest
    $kb = [math]::Round((Get-Item $dest).Length / 1KB, 1)
    Write-Host "Saved: $dest ($kb KB)" -ForegroundColor Green
    Add-Content "$drafts\export-log.txt" "$(Get-Date -Format 'yyyy-MM-dd HH:mm') | $label | $kb KB"
} else {
    Write-Host "DOCX not found. Quarto output files:" -ForegroundColor Yellow
    Get-ChildItem "$projectRoot\_output" -Filter "*.docx" | Select-Object Name, LastWriteTime
}
