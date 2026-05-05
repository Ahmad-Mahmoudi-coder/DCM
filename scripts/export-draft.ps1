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

$ts = Get-Date -Format "yyyy-MM-dd_HHmm"
$out = "$drafts\DCM_${ts}_${label}.docx"

Write-Host "Exporting: $out" -ForegroundColor Cyan
quarto render --to docx --output $out

if (Test-Path $out) {
    $kb = [math]::Round((Get-Item $out).Length / 1KB, 1)
    Write-Host "Done: $out ($kb KB)" -ForegroundColor Green
    Add-Content "$drafts\export-log.txt" "$(Get-Date -Format 'yyyy-MM-dd HH:mm') | $label | $kb KB"
} else {
    Write-Host "Check root folder for DOCX file." -ForegroundColor Yellow
    Get-ChildItem $projectRoot -Filter "*.docx" | Select-Object Name, Length
}
