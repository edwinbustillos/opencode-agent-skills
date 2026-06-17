# ============================================================================
# OpenCode Agent Team - Desinstalador Windows (PowerShell)
# ============================================================================
#Requires -Version 5.1

$ErrorActionPreference = "Stop"
$OpenCodeDir = Join-Path $env:USERPROFILE ".config\opencode"

Write-Host ""
Write-Host "╔══════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║   OpenCode Agent Team - Desinstalador Windows    ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

$confirm = Read-Host "Remover skills, agentes e config do opencode? (y/N)"
if ($confirm -notin @("y","Y")) { Write-Host "Cancelado." -ForegroundColor Yellow; exit 0 }

Write-Host ""

# Skills
$skillsDir = Join-Path $OpenCodeDir "skills"
if (Test-Path $skillsDir) {
    $count = (Get-ChildItem $skillsDir -Directory).Count
    Remove-Item $skillsDir -Recurse -Force
    Write-Host "  ✓ $count skills removidas" -ForegroundColor Green
}

# Agents
$agentsDir = Join-Path $OpenCodeDir "agents"
if (Test-Path $agentsDir) {
    $count = (Get-ChildItem "$agentsDir\*.md").Count
    Remove-Item "$agentsDir\*.md" -Force
    Write-Host "  ✓ $count agentes removidos" -ForegroundColor Green
}

# Config
foreach ($f in @("opencode.json", "AGENTS.md")) {
    $path = Join-Path $OpenCodeDir $f
    if (Test-Path $path) {
        Remove-Item $path -Force
        Write-Host "  ✓ $f removido" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "Desinstalação concluída." -ForegroundColor Green
Write-Host ""
