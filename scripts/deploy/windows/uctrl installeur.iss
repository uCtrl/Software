
[Setup]

AppId={{555AFA91-CB5D-46B8-BD01-582771F5759B}
AppName=Uctrl
AppVersion=1.0.0
;AppVerName=Uctrl 1.0.0
AppPublisher=Uctrl Inc
AppPublisherURL=http://www.Uctrl.com/
AppSupportURL=http://www.Uctrl.com/
AppUpdatesURL=http://www.Uctrl.com/
DefaultDirName={pf}\Uctrl
DefaultGroupName=Uctrl
DisableProgramGroupPage=yes
OutputDir=C:\Users\thomas\Desktop\installeur uctrl
OutputBaseFilename=Uctrl
SetupIconFile=C:\Users\thomas\Desktop\Uctrl\src\uCtrlDesktop\Images\uctrl.ico
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}";   Flags: unchecked 
Name: "quicklaunchicon";   Description: "{cm:CreateQuickLaunchIcon}";   GroupDescription: "{cm:AdditionalIcons}";   Flags: unchecked;   OnlyBelowVersion: 0,6.1

[Files]
Source: "C:\Users\thomas\Desktop\Uctrl\build-uCtrl-Desktop_Qt_5_3_MinGW_32bit-Debug\uCtrlDesktop\debug\uCtrlDesktop.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\thomas\Desktop\Uctrl\build-uCtrl-Desktop_Qt_5_3_MinGW_32bit-Debug\uCtrlDesktop\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\Uctrl"; Filename: "{app}\uCtrlDesktop.exe"
Name: "{group}\{cm:UninstallProgram,Uctrl}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\Uctrl"; Filename: "{app}\uCtrlDesktop.exe"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\Uctrl"; Filename: "{app}\uCtrlDesktop.exe"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\uCtrlDesktop.exe"; Description: "{cm:LaunchProgram,Uctrl}"; Flags: nowait postinstall skipifsilent

