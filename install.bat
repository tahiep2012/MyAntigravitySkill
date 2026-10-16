@echo off
chcp 65001 >nul
title Antigravity Skills Suite Installer

echo ================================================================================
echo    ANTIGRAVITY SKILLS SUITE - TRINH CAI DAT TU DONG CHO MAY MOI
echo ================================================================================
echo.

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install.ps1"

echo.
pause
