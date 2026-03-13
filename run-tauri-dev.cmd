@echo off
REM OnePlace Development Script
REM This script sets up the Visual Studio build environment and runs Tauri in development mode

REM Initialize Visual Studio Developer Command Prompt environment
call "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\Common7\Tools\VsDevCmd.bat" -arch=x64 -host_arch=x64 >nul

REM Add Cargo (Rust) to PATH
set PATH=%USERPROFILE%\.cargo\bin;%PATH%

REM Change to project directory
cd /d "%~dp0"

REM Run Tauri development server and log output
npm run dev > tauri-dev.log 2>&1
