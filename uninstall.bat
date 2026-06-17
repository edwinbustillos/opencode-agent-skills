@echo off
:: ============================================================================
:: OpenCode Agent Team - Desinstalador Windows
:: ============================================================================
cd /d "%~dp0"
powershell -ExecutionPolicy Bypass -File "%~dp0uninstall.ps1"
pause
