# ============================================================================
# OpenCode Agent Team - Instalador Windows (PowerShell)
# ============================================================================
# Instala skills, agentes e configuração global do opencode.
# Requer: opencode já instalado e funcionando.
# ============================================================================
#Requires -Version 5.1

$ErrorActionPreference = "Stop"

# --- Diretórios ---
$OpenCodeDir = Join-Path $env:USERPROFILE ".config\opencode"
$SkillsDir   = Join-Path $OpenCodeDir "skills"
$AgentsDir   = Join-Path $OpenCodeDir "agents"
$SourceDir   = Split-Path -Parent $MyInvocation.MyCommand.Path

# --- Helpers ---
function Write-Info  { param($Msg) Write-Host "▸ $Msg" -ForegroundColor Cyan }
function Write-Ok    { param($Msg) Write-Host "  ✓ $Msg" -ForegroundColor Green }
function Write-Warn  { param($Msg) Write-Host "  ⚠ $Msg" -ForegroundColor Yellow }
function Write-Err   { param($Msg) Write-Host "  ✗ $Msg" -ForegroundColor Red }

function Copy-IfNew {
    param([string]$Src, [string]$Dst)
    $dstDir = Split-Path -Parent $Dst
    if (-not (Test-Path $dstDir)) { New-Item -ItemType Directory -Path $dstDir -Force | Out-Null }
    if (-not (Test-Path $Dst) -or (Get-FileHash $Src).Hash -ne (Get-FileHash $Dst).Hash) {
        Copy-Item $Src $Dst -Force
        return $true
    }
    return $false
}

# ============================================================================
# Header
# ============================================================================
Write-Host ""
Write-Host "╔══════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║   OpenCode Agent Team - Instalador Windows       ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# ============================================================================
# Verificar opencode
# ============================================================================
Write-Info "Verificando opencode..."
try {
    $ver = & opencode --version 2>$null
    Write-Ok "opencode $ver"
} catch {
    Write-Err "opencode não encontrado no PATH"
    Write-Host "  Instale: https://opencode.ai/docs/installation" -ForegroundColor Yellow
    exit 1
}

# ============================================================================
# Criar diretórios
# ============================================================================
Write-Info "Criando diretórios..."
foreach ($d in @($OpenCodeDir, $SkillsDir, $AgentsDir)) {
    if (-not (Test-Path $d)) { New-Item -ItemType Directory -Path $d -Force | Out-Null }
    Write-Ok $d
}

# ============================================================================
# Copiar configuração
# ============================================================================
Write-Info "Instalando configuração..."

$cfgSrc = Join-Path $SourceDir "opencode.json"
$cfgDst = Join-Path $OpenCodeDir "opencode.json"
if (Copy-IfNew $cfgSrc $cfgDst) { Write-Ok "opencode.json" } else { Write-Ok "opencode.json (sem alterações)" }

$agSrc = Join-Path $SourceDir "AGENTS.md"
$agDst = Join-Path $OpenCodeDir "AGENTS.md"
if (Copy-IfNew $agSrc $agDst) { Write-Ok "AGENTS.md" } else { Write-Ok "AGENTS.md (sem alterações)" }

# ============================================================================
# Instalar Skills (20)
# ============================================================================
Write-Info "Instalando skills..."

$SkillNames = @(
    "python-backend", "javascript-typescript", "flutter-mobile",
    "java-backend", "golang-backend", "rust-systems", "cpp-systems",
    "react-frontend", "angular-frontend", "api-design",
    "database-orm", "cloud-aws", "cloud-azure",
    "devops-cicd", "ui-ux-design", "security-audit",
    "testing-strategy", "performance-optimization", "project-setup",
    "arduino-embedded"
)

$installed = 0; $skipped = 0

foreach ($skill in $SkillNames) {
    $src = Join-Path $SourceDir ".opencode\skills\$skill\SKILL.md"
    $dstDir = Join-Path $SkillsDir $skill
    $dst = Join-Path $dstDir "SKILL.md"

    if (-not (Test-Path $src)) {
        Write-Warn "Fonte não encontrada: $skill"
        $skipped++
        continue
    }

    if (Copy-IfNew $src $dst) {
        Write-Ok $skill
        $installed++
    } else {
        Write-Ok "$skill (sem alterações)"
        $skipped++
    }
}

Write-Host "  Skills: $installed novas, $skipped mantidas" -ForegroundColor Cyan

# ============================================================================
# Instalar Agentes (6)
# ============================================================================
Write-Info "Instalando agentes..."

$installed = 0; $skipped = 0
$agentSrc = Join-Path $SourceDir ".opencode\agents"

if (Test-Path $agentSrc) {
    Get-ChildItem "$agentSrc\*.md" | ForEach-Object {
        $name = $_.Name
        $dst = Join-Path $AgentsDir $name

        if (Copy-IfNew $_.FullName $dst) {
            Write-Ok ($name -replace '\.md$','')
            $installed++
        } else {
            Write-Ok "$($name -replace '\.md$','') (sem alterações)"
            $skipped++
        }
    }
}

Write-Host "  Agentes: $installed novos, $skipped mantidos" -ForegroundColor Cyan

# ============================================================================
# Verificar ferramentas
# ============================================================================
Write-Info "Verificando ferramentas opcionais..."

$tools = @(
    @{ Name = "pyright";        Cmd = "pyright" },
    @{ Name = "gopls";          Cmd = "gopls" },
    @{ Name = "rust-analyzer";  Cmd = "rust-analyzer" },
    @{ Name = "clangd";         Cmd = "clangd" },
    @{ Name = "arduino-cli";    Cmd = "arduino-cli" },
    @{ Name = "PlatformIO";     Cmd = "pio" }
)

foreach ($t in $tools) {
    try {
        $null = & $t.Cmd --version 2>$null
        Write-Ok $t.Name
    } catch { }
}

# ============================================================================
# Resumo
# ============================================================================
$totalSkills  = (Get-ChildItem $SkillsDir -Directory).Count
$totalAgents  = (Get-ChildItem "$AgentsDir\*.md").Count

Write-Host ""
Write-Host "╔══════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║   ✅ Instalação Concluída                       ║" -ForegroundColor Green
Write-Host "╚══════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "  Config:   $OpenCodeDir\opencode.json"
Write-Host "  Skills:   $totalSkills instaladas em $SkillsDir\"
Write-Host "  Agentes:  $totalAgents instalados em $AgentsDir\"
Write-Host "  Regras:   $OpenCodeDir\AGENTS.md"
Write-Host ""
Write-Host "  Inicie com: opencode" -ForegroundColor Yellow
Write-Host ""
