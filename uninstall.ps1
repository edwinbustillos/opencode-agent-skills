# ============================================================================
# OpenCode Agent Team - Desinstalador Windows (PowerShell)
# ============================================================================
# Delegates to setup.ps1 for the actual logic.
# Uso: .\uninstall.ps1           (remove config/skills/agentes)
#      .\uninstall.ps1 --hard    (remove TUDO)
# ============================================================================
$SourceDir = Split-Path -Parent $MyInvocation.MyCommand.Path
& (Join-Path $SourceDir "setup.ps1") uninstall @args
