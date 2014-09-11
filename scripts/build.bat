@ECHO OFF
REM You need to add mingw32 bin to your PATH (C:\Qt\Tools\mingw482_32\bin)

set CURRENT_DIR=%CD%
set BATCH_DIR=%~dp0
set BUILD_DIR=%BATCH_DIR%\..\build\release

echo Creating build folder
if not exist "%BUILD_DIR%" mkdir "%BUILD_DIR%"

echo Moving to build folder
cd "%BUILD_DIR%"

echo Starting build
qmake.exe "..\..\src\uCtrl.pro" -r -spec win32-g++
mingw32-make.exe

echo Moving back to starting directory
cd "%CURRENT_DIR%"