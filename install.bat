@echo off
:: ============================================================================
:: OpenCode Agent Team - Wrapper Windows
:: ============================================================================
cd /d "%~dp0"
powershell -ExecutionPolicy Bypass -File "%~dp0setup.ps1" install
pause
