@echo off
:: ============================================================================
:: OpenCode Agent Team - Wrapper Windows
:: ============================================================================
:: Executa o instalador PowerShell. Clique duas vezes ou rode no cmd.
:: ============================================================================
cd /d "%~dp0"
powershell -ExecutionPolicy Bypass -File "%~dp0install.ps1"
pause
