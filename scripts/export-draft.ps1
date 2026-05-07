[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 | Out-Null

$env:Path = "C:\Model\tools\quarto-1.9.37\bin;" + $env:Path
$projectRoot = "C:\Model\decision-centred-modelling"
Set-Location $projectRoot

$label = if ($args[0]) { $args[0] } else { "draft" }

$drafts = "$projectRoot\drafts"
New-Item -ItemType Directory -Path $drafts -Force | Out-Null

Write-Host "Rendering DOCX..." -ForegroundColor Cyan
quarto render --to docx

Start-Sleep -Seconds 2

$source = "$projectRoot\_output\Decision-Centred-Modelling--DCM-.docx"

if (Test-Path $source) {
    $ts = Get-Date -Format "yyyy-MM-dd_HHmm"
    $dest = "$drafts\DCM_${ts}_${label}.docx"
    Copy-Item $source $dest -Force
    $kb = [math]::Round((Get-Item $dest).Length / 1KB, 1)
    Write-Host ""
    Write-Host "Saved: $dest ($kb KB)" -ForegroundColor Green
    Add-Content "$drafts\export-log.txt" "$(Get-Date -Format 'yyyy-MM-dd HH:mm') | $label | $kb KB"
    Write-Host "Log updated: $drafts\export-log.txt" -ForegroundColor Gray
} else {
    Write-Host ""
    Write-Host "Render succeeded but DOCX not found at expected path:" -ForegroundColor Yellow
    Write-Host "  $source"
    Write-Host "All files in _output:" -ForegroundColor Gray
    Get-ChildItem "$projectRoot\_output" | Select-Object Name, LastWriteTime
}

