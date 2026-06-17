# ============================================================================
# OpenCode Agent Team - Setup Windows (PowerShell)
# ============================================================================
# Uso: .\setup.ps1 install
#      .\setup.ps1 uninstall
#      .\setup.ps1 uninstall --hard   # Remove TUDO, inclusive ~/.opencode/
# ============================================================================
#Requires -Version 5.1

$ErrorActionPreference = "Stop"

$OpenCodeConfig = Join-Path $env:USERPROFILE ".config\opencode"
$OpenCodeData   = Join-Path $env:USERPROFILE ".opencode"
$SourceDir      = Split-Path -Parent $MyInvocation.MyCommand.Path

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
# FUNÇÃO: Instalar
# ============================================================================
function Do-Install {
    $skillDir = Join-Path $OpenCodeConfig "skills"
    $agentDir = Join-Path $OpenCodeConfig "agents"

    Write-Host ""
    Write-Host "╔══════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║   OpenCode Agent Team - Instalador Windows       ║" -ForegroundColor Cyan
    Write-Host "╚══════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""

    Write-Info "Verificando opencode..."
    try {
        $ver = & opencode --version 2>$null
        Write-Ok "opencode $ver"
    } catch {
        Write-Info "opencode não encontrado — instalando..."
        try {
            $null = Get-Command curl.exe 2>$null
            if ($?) {
                & curl.exe -fsSL https://opencode.ai/install | bash
            } else {
                Invoke-WebRequest -Uri "https://opencode.ai/install.ps1" -UseBasicParsing | Invoke-Expression
            }
            Write-Host ""
            $ver = & opencode --version 2>$null
            if (-not $?) {
                Write-Err "Instalação falhou. Tente manualmente: https://opencode.ai/docs/installation"
                exit 1
            }
            Write-Ok "opencode instalado com sucesso ($ver)"
        } catch {
            Write-Err "Falha na instalação automática. Instale manualmente: https://opencode.ai/docs/installation"
            exit 1
        }
    }

    Write-Info "Criando diretórios..."
    foreach ($d in @($OpenCodeConfig, $skillDir, $agentDir)) {
        if (-not (Test-Path $d)) { New-Item -ItemType Directory -Path $d -Force | Out-Null }
        Write-Ok $d
    }

    Write-Info "Instalando configuração..."
    $cfgSrc = Join-Path $SourceDir "opencode.json"
    $cfgDst = Join-Path $OpenCodeConfig "opencode.json"
    if (Copy-IfNew $cfgSrc $cfgDst) { Write-Ok "opencode.json" } else { Write-Ok "opencode.json (sem alterações)" }

    $agSrc = Join-Path $SourceDir "AGENTS.md"
    $agDst = Join-Path $OpenCodeConfig "AGENTS.md"
    if (Copy-IfNew $agSrc $agDst) { Write-Ok "AGENTS.md" } else { Write-Ok "AGENTS.md (sem alterações)" }

    Write-Info "Instalando skills..."
    $installed = 0; $skipped = 0
    $skillsSrc = Join-Path $SourceDir ".opencode\skills"
    if (Test-Path $skillsSrc) {
        Get-ChildItem $skillsSrc -Directory | ForEach-Object {
            $name = $_.Name
            $src = Join-Path $_.FullName "SKILL.md"
            $dstDir = Join-Path $skillDir $name
            $dst = Join-Path $dstDir "SKILL.md"

            if (-not (Test-Path $src)) {
                Write-Warn "Fonte não encontrada: $name"
                $skipped++
                return
            }
            if (Copy-IfNew $src $dst) {
                Write-Ok $name
                $installed++
            } else {
                Write-Ok "$name (sem alterações)"
                $skipped++
            }
        }
    }
    Write-Host "  Skills: $installed novas, $skipped mantidas" -ForegroundColor Cyan

    Write-Info "Instalando agentes..."
    $installed = 0; $skipped = 0
    $agentSrc = Join-Path $SourceDir ".opencode\agents"
    if (Test-Path $agentSrc) {
        Get-ChildItem "$agentSrc\*.md" | ForEach-Object {
            $name = $_.Name
            $dst = Join-Path $agentDir $name
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
        try { $null = & $t.Cmd --version 2>$null; Write-Ok $t.Name } catch { }
    }

    $totalSkills  = (Get-ChildItem $skillDir -Directory).Count
    $totalAgents  = (Get-ChildItem "$agentDir\*.md").Count

    Write-Host ""
    Write-Host "╔══════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║   Instalação Concluída                         ║" -ForegroundColor Green
    Write-Host "╚══════════════════════════════════════════════════╝" -ForegroundColor Green
    Write-Host ""
    Write-Host "  Config:   $OpenCodeConfig\opencode.json"
    Write-Host "  Skills:   $totalSkills em $skillDir\"
    Write-Host "  Agentes:  $totalAgents em $agentDir\"
    Write-Host "  Regras:   $OpenCodeConfig\AGENTS.md"
    Write-Host ""
    Write-Host "  Inicie com: opencode" -ForegroundColor Yellow
    Write-Host ""
}

# ============================================================================
# FUNÇÃO: Desinstalar
# ============================================================================
function Do-Uninstall {
    param([switch]$Hard)

    Write-Host ""
    Write-Host "╔══════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║   OpenCode Agent Team - Desinstalador Windows    ║" -ForegroundColor Cyan
    Write-Host "╚══════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""

    if ($Hard) {
        Write-Warn "MODO HARD: removendo TUDO (config + dados + providers + binário)"
        Write-Host ""
    } else {
        Write-Warn "Removendo config, skills, agentes e providers. Use --hard para remover também o binário."
        Write-Host ""
    }

    $confirm = Read-Host "Remover config skills agentes providers do opencode? (y/N)"
    if ($confirm -notin @("y","Y")) { Write-Host "Cancelado." -ForegroundColor Yellow; exit 0 }
    Write-Host ""

    # --- Remove ~/.config/opencode/ ---
    if (Test-Path $OpenCodeConfig) {
        Write-Info "Removendo $OpenCodeConfig..."
        Remove-Item $OpenCodeConfig -Recurse -Force
        Write-Ok "Configuração removida"
    } else {
        Write-Info "$OpenCodeConfig não encontrado, ignorando"
    }

    # --- Remove ~/.opencode/ (dados, providers, node_modules) ---
    if (Test-Path $OpenCodeData) {
        Write-Info "Removendo $OpenCodeData..."
        Remove-Item $OpenCodeData -Recurse -Force
        Write-Ok "Dados e providers do opencode removidos"
    } else {
        Write-Info "$OpenCodeData não encontrado, ignorando"
    }

    # --- Remove binário do PATH (apenas em --hard) ---
    if ($Hard) {
        $paths = @(
            "$env:LOCALAPPDATA\opencode\opencode.exe",
            "$env:USERPROFILE\.opencode\bin\opencode.exe"
        )
        foreach ($p in $paths) {
            if (Test-Path $p) {
                Remove-Item $p -Force
                Write-Ok "Binário removido: $p"
            }
        }
    }

    Write-Host ""
    Write-Host "╔══════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║   Desinstalação Concluída                      ║" -ForegroundColor Green
    Write-Host "╚══════════════════════════════════════════════════╝" -ForegroundColor Green
    Write-Host ""

    Write-Host "  Resumo:" -ForegroundColor Yellow
    Write-Host "  - ~\.config\opencode\  : removido"
    Write-Host "  - ~\.opencode\         : removido (config, skills, agentes, providers)"
    if ($Hard) {
        Write-Host "  - binário PATH         : removido"
    } else {
        Write-Host "  - binário PATH         : mantido"
    }
    Write-Host ""
    Write-Host "  Para reinstalar complete:" -ForegroundColor Cyan
    Write-Host "  » .\install.bat" -ForegroundColor Yellow
    Write-Host ""
}

# ============================================================================
# MAIN
# ============================================================================
switch ($args[0]) {
    "install" {
        Do-Install
    }
    "uninstall" {
        $hard = $args[1] -eq "--hard"
        Do-Uninstall -Hard:$hard
    }
    default {
        Write-Host ""
        Write-Host "╔══════════════════════════════════════════════════╗" -ForegroundColor Cyan
        Write-Host "║   OpenCode Agent Team - Setup Windows           ║" -ForegroundColor Cyan
        Write-Host "╚══════════════════════════════════════════════════╝" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "  Uso: .\setup.ps1 install           Instalar skills/agentes/config"
        Write-Host "       .\setup.ps1 uninstall         Remover config/skills/agentes/providers"
        Write-Host "       .\setup.ps1 uninstall --hard  Remover TUDO (+ binário do PATH)"
        Write-Host ""
        Write-Host "  Legenda:" -ForegroundColor Yellow
        Write-Host "  - install      : Instala opencode (se ausente), copia skills/agentes/config"
        Write-Host "  - uninstall    : Remove ~\.config\opencode\ + ~\.opencode\ (dados+providers)"
        Write-Host "  - uninstall --hard : Idem + remove binário do PATH"
        Write-Host ""
    }
}
