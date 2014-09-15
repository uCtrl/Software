@ECHO OFF
REM You need to add QT bin to your PATH (C:\Qt\5.3\mingw482_32\bin)
REM and Inno Setup Install Dir (C:\Program Files (x86)\Inno Setup 5)

set BATCH_DIR=%~dp0
set BUILD_SCRIPT=%BATCH_DIR%..\..\build.bat
set BUILD_DIR=%BATCH_DIR%..\..\..\build
set RELEASE_DIR=%BUILD_DIR%\release
set INSTALLER_DIR=%BUILD_DIR%\release\installer\source
set INNO_SCRIPT=%BATCH_DIR%create-installer.iss
set ICON=%BATCH_DIR%..\..\..\src\uCtrlDesktop\Images\uctrl.ico
set BONJOUR=%BATCH_DIR%Bonjour.msi

rmdir /s /q "%BUILD_DIR%"

REM Call build script
call "%BUILD_SCRIPT%"

echo Creating Installer folder
mkdir "%INSTALLER_DIR%\qml"

echo Copying needed files to installer folder
xcopy /s/e "%RELEASE_DIR%\uCtrlDesktop\qml" "%INSTALLER_DIR%\qml"
xcopy /s/e "%RELEASE_DIR%\uCtrlDesktop\release\uCtrlDesktop.exe" "%INSTALLER_DIR%"
xcopy /s/e "%INNO_SCRIPT%" "%INSTALLER_DIR%\.."
xcopy /s/e "%ICON%" "%INSTALLER_DIR%\.."
xcopy /s/e "%Bonjour%" "%INSTALLER_DIR%\.."

echo Bringing dependencies in installer folder
windeployqt --qmldir "%INSTALLER_DIR%\qml" "%INSTALLER_DIR%\uCtrlDesktop.exe"

iscc /qp "%INSTALLER_DIR%\..\create-installer.iss"