# ============================================================================
# OpenCode Agent Team - Instalador Windows (PowerShell)
# ============================================================================
# Delegates to setup.ps1 for the actual logic.
# ============================================================================
$SourceDir = Split-Path -Parent $MyInvocation.MyCommand.Path
& (Join-Path $SourceDir "setup.ps1") install
