[Setup]
AppId={{555AFA91-CB5D-46B8-BD01-582771F5759B}
AppName=µCtrl
AppVersion=1.0.0
AppPublisher=µCtrl
DefaultDirName={pf}\uCtrl
DefaultGroupName=uCtrl
DisableProgramGroupPage=yes
OutputBaseFilename=uCtrl
SetupIconFile=uctrl.ico
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}";   Flags: unchecked 
Name: "quicklaunchicon";   Description: "{cm:CreateQuickLaunchIcon}";   GroupDescription: "{cm:AdditionalIcons}";   Flags: unchecked;   OnlyBelowVersion: 0,6.1


[Files]
Source: "source\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Bonjour.msi"; DestDir: "{app}"; Flags: deleteafterinstall; AfterInstall: InstallBonjour; Check: BonjourIsNotInstalled;

[Icons]
Name: "{group}\uCtrl"; Filename: "{app}\uCtrlDesktop.exe"
Name: "{group}\{cm:UninstallProgram,uCtrl}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\uCtrl"; Filename: "{app}\uCtrlDesktop.exe"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\uCtrl"; Filename: "{app}\uCtrlDesktop.exe"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\uCtrlDesktop.exe"; Description: "{cm:LaunchProgram,Uctrl}"; Flags: nowait postinstall skipifsilent

[Code]
procedure InstallBonjour;
var
  ResultCode: Integer;
begin
  if not Exec(ExpandConstant('msiexec /i {app}\Bonjour.msi'), '/quiet', '', SW_SHOW, ewWaitUntilTerminated, ResultCode) then
  begin
    // you can interact with the user that the installation failed
    MsgBox('Bonjour not installed: ' + IntToStr(ResultCode) + '.',
      mbError, MB_OK);
  end;
end;

function BonjourIsNotInstalled: Boolean;
  begin
    Result := not RegKeyExists(HKEY_LOCAL_MACHINE, 'SOFTWARE\Apple Inc.\Bonjour');
end;
