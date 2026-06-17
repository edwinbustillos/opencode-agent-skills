@echo off
:: ============================================================================
:: OpenCode Agent Team - Wrapper Windows
:: ============================================================================
:: Uso: setup install
::      setup uninstall
::      setup uninstall --hard
:: ============================================================================
cd /d "%~dp0"
powershell -ExecutionPolicy Bypass -File "%~dp0setup.ps1" %*
pause
