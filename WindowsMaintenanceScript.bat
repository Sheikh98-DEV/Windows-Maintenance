@ECHO OFF
SETLOCAL EnableDELayedExpansion
SET Version=1.0.0
Set ReleaseTime=Jul 20, 2025
Title Windows Maintenance Script - by S.H.E.I.K.H (V. %Version%)

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Check to see if this batch file is being run as Administrator. If it is not, then rerun the batch file ::
:: automatically as admin and terminate the initial instance of the batch file.                           ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

(Fsutil Dirty Query %SystemDrive%>Nul)||(PowerShell Start """%~f0""" -verb RunAs & Exit /B) > NUL 2>&1

::::::::::::::::::::::::::::::::::::::::::::::::
:: End Routine to check if being run as Admin ::
::::::::::::::::::::::::::::::::::::::::::::::::

CD /D "%~dp0"
CLS

ECHO :::::::::::::::::::::::::::::::::::::::
ECHO ::     Windows Maintenance Script    ::
ECHO ::                                   ::
ECHO ::      Version %Version% (Stable)       ::
ECHO ::                                   ::
ECHO ::   %ReleaseTime% by  S.H.E.I.K.H    ::
ECHO ::                                   ::
ECHO ::       GitHub: Sheikh98-DEV        ::
ECHO :::::::::::::::::::::::::::::::::::::::
ECHO .
ECHO Recommended to launch Monthly.
ECHO .
ECHO Press any key to start optimization ...
Pause >null


ECHO.
ECHO ::::::::::::::::::::::::::::::::
ECHO ::::: Starting Maintenance :::::
ECHO ::::::::::::::::::::::::::::::::
ECHO.

control wscui.cpl >nul 2>&1
MSchedExe.exe Start
ECHO Please wait until the end of maintenance,
ECHO Then return here and press any key to continue...
pause >nul
ECHO Running idle tasks, please wait...
rundll32.exe advapi32.dll,ProcessIdleTasks

ECHO Done!


ECHO.
ECHO ::::::::::::::::::::::::
ECHO ::::: Closing apps :::::
ECHO ::::::::::::::::::::::::
ECHO.

TaskKill /F /IM "msedge.exe" >nul 2>&1
TaskKill /F /IM "CrossDeviceResume.exe" >nul 2>&1

ECHO Done!


ECHO.
ECHO :::::::::::::::::::::::::
ECHO ::::: Checking Disk :::::
ECHO :::::::::::::::::::::::::
ECHO.

CHKDSK

ECHO Done!


ECHO.
ECHO ::::::::::::::::::::::::::::::
ECHO ::::: Cleaning DISM Temp :::::
ECHO ::::::::::::::::::::::::::::::
ECHO.

DISM /Online /Cleanup-Image /AnalyzeComponentStore
DISM /Online /Cleanup-Image /StartComponentCleanup
DISM /Online /Cleanup-Image /StartComponentcleanup /ResetBase

ECHO Done!


ECHO.
ECHO :::::::::::::::::::::::::::::
ECHO ::::: Repairing Windows :::::
ECHO :::::::::::::::::::::::::::::
ECHO.

DISM /Online /Cleanup-Image /CheckHealth >nul 2>&1
DISM /Online /Cleanup-Image /ScanHealth
DISM /Online /Cleanup-Image /RestoreHealth
SFC /VerifyOnly
SFC /ScanNow
DISM /Online /Cleanup-Image /AnalyzeComponentStore
DISM /Online /Cleanup-Image /StartComponentCleanup
DISM /Online /Cleanup-Image /StartComponentcleanup /ResetBase

ECHO Done!


ECHO.
ECHO :::::::::::::::::::::::::::::::::::::::
ECHO ::::: Calling Revo and PC Manager :::::
ECHO :::::::::::::::::::::::::::::::::::::::
ECHO.

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: If you don't have any of these applications, please remove this part ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

CMD.exe /C Cleanmgr /sageset:65535 & Cleanmgr /sagerun:65535 >nul 2>&1
Start RevoUninPro.exe >nul 2>&1
NET Start "PCManager Service Store" >nul 2>&1
Start shell:AppsFolder\Microsoft.MicrosoftPCManager_8wekyb3d8bbwe!App >nul 2>&1
ECHO After using Revo and MS PC Manager return here and press any key to continue ...
pause >nul
NET Stop "PCManager Service Store" >nul 2>&1
TaskKill /F /IM MSPCManager.exe >nul 2>&1
TaskKill /F /IM RevoUninPro.exe >nul 2>&1

ECHO Done!


ECHO.
ECHO ::::::::::::::::::::::::::::::
ECHO ::::: Cleaning Edge Temp :::::
ECHO ::::::::::::::::::::::::::::::
ECHO.

DEL /S /Q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\History*" >nul 2>&1
DEL /S /Q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Media History*" >nul 2>&1
DEL /S /Q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Visited Links*" >nul 2>&1
DEL /S /Q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Top Sites*" >nul 2>&1
DEL /S /Q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\NETwork Action Predictor*" >nul 2>&1
DEL /S /Q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Shortcuts*" >nul 2>&1
DEL /S /Q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\NETwork\Cookies*" >nul 2>&1
DEL /S /Q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Web Data*" >nul 2>&1
PushD "%LocalAppData%\Microsoft\Edge\User Data\Default\Session Storage" && (RD /S /Q "%LocalAppData%\Microsoft\Edge\User Data\Default\Session Storage" 2>nul & popd)
PushD "%LocalAppData%\Microsoft\Edge\User Data\Default\Sync Data" && (RD /S /Q "%LocalAppData%\Microsoft\Edge\User Data\Default\Sync Data" 2>nul & popd)
PushD "%LocalAppData%\Microsoft\Edge\User Data\Default\Telemetry" && (RD /S /Q "%LocalAppData%\Microsoft\Edge\User Data\Default\Telemetry" 2>nul & popd)
PushD "%LocalAppData%\Microsoft\Edge\User Data\CrashReports" && (RD /S /Q "%LocalAppData%\Microsoft\Edge\User Data\CrashReports" 2>nul & popd)
PushD "%LocalAppData%\Microsoft\EdgeUpdate\Log" && (RD /S /Q "%LocalAppData%\Microsoft\EdgeUpdate\Log" 2>nul & popd)
PushD "%LocalAppData%\Microsoft\EdgeUpdate\Download" && (RD /S /Q "%LocalAppData%\Microsoft\EdgeUpdate\Download" 2>nul & popd)
PushD "%LocalAppData%\Microsoft\EdgeUpdate\Install" && (RD /S /Q "%LocalAppData%\Microsoft\EdgeUpdate\Install" 2>nul & popd)
PushD "%LocalAppData%\Microsoft\EdgeUpdate\Offline" && (RD /S /Q "%LocalAppData%\Microsoft\EdgeUpdate\Offline" 2>nul & popd)
PushD "%LocalAppData%\Microsoft\Edge\User Data\BrowserMetrics" && (RD /S /Q "%LocalAppData%\Microsoft\Edge\User Data\BrowserMetrics" 2>nul & popd)
PushD "%LocalAppData%\Microsoft\Edge\User Data\Crashpad\reports" && (RD /S /Q "%LocalAppData%\Microsoft\Edge\User Data\Crashpad\reports" 2>nul & popd)
PushD "%LocalAppData%\Microsoft\Edge\User Data\Stability" && (RD /S /Q "%LocalAppData%\Microsoft\Edge\User Data\Stability" 2>nul & popd)
PushD "%LocalAppData%\Microsoft\Edge\User Data\Stability" && (RD /S /Q "%LocalAppData%\Microsoft\Edge\User Data\Stability" 2>nul & popd)
PushD "%LocalAppData%\Microsoft\Edge\User Data\Feature Engagement Tracker" && (RD /S /Q "%LocalAppData%\Microsoft\Edge\User Data\Feature Engagement Tracker" 2>nul & popd)

ECHO Done!


ECHO.
ECHO ::::::::::::::::::::::::::::::::
ECHO ::::: Cleaning Office Temp :::::
ECHO ::::::::::::::::::::::::::::::::
ECHO.

PushD "%LOCALAPPDATA%\Microsoft\Office\16.0\Wef\" && (RD /S /Q "%LOCALAPPDATA%\Microsoft\Office\16.0\Wef\" 2>nul & popd)
PushD "%userprofile%\AppData\Local\Packages\Microsoft.Win32WebViewHost_cw5n1h2txyewy\AC\#!123\INETCache\" && (RD /S /Q "%userprofile%\AppData\Local\Packages\Microsoft.Win32WebViewHost_cw5n1h2txyewy\AC\#!123\INETCache\" 2>nul & popd)
PushD "%userprofile%\AppData\Local\Microsoft\Outlook\HubAppFileCache" && (RD /S /Q "%userprofile%\AppData\Local\Microsoft\Outlook\HubAppFileCache" 2>nul & popd)
RD /S /Q "%USERPROFILE%\Documents\Custom Office Templates" >nul 2>&1

ECHO Done!


ECHO.
ECHO :::::::::::::::::::::::::::::
ECHO ::::: Resetting NETwork :::::
ECHO :::::::::::::::::::::::::::::
ECHO.

netsh winhttp reset proxy >nul
ipconfig /release >nul
ipconfig /flushdns >nul
ipconfig /renew >nul
netsh int ip reset >nul
netsh winsock reset >nul

ECHO Done!


ECHO.
ECHO :::::::::::::::::::::::::::::::::
ECHO ::::: Cleaning Windows Temp :::::
ECHO :::::::::::::::::::::::::::::::::
ECHO.

TakeOwn /S %computername% /U %username% /F "%WinDir%\System32\smartscreen.exe" >nul 2>&1
icacls "%WinDir%\System32\smartscreen.exe" /grant:r %username%:F >nul 2>&1
TaskKill /F /IM "smartscreen.exe" >nul 2>&1
DEL "%WinDir%\System32\smartscreen.exe" /S /F /Q >nul 2>&1
TaskKill /F /IM "CrossDeviceResume.exe" >nul 2>&1
cd "%WINDIR%\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy" >nul 2>&1
TakeOwn /F "Microsoft.Web.WebView2.Core.dll" >nul 2>&1
icacls "Microsoft.Web.WebView2.Core.dll" /grant administrators:F >nul 2>&1
DEL /F /Q "%WINDIR%\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\Microsoft.Web.WebView2.Core.dll" >nul 2>&1
CD /D "%WINDIR%\System32" >nul 2>&1
rundll32.exe pnpclean.dll,RunDLL_PnpClean /drivers /maxclean >nul 2>&1
cleanmgr /sagerun 1 >nul 2>&1
cleanmgr /verylowdisk >nul 2>&1
RD /S /Q "%SystemDrive%\$GetCurrent" >nul 2>&1
RD /S /Q "%SystemDrive%\$SysReset" >nul 2>&1
RD /S /Q "%SystemDrive%\$Windows.~BT" >nul 2>&1
RD /S /Q "%SystemDrive%\$Windows.~WS" >nul 2>&1
RD /S /Q "%SystemDrive%\$WinREAgent" >nul 2>&1
RD /S /Q "%SystemDrive%\OneDriveTemp" >nul 2>&1
RD /S /Q "%SystemDrive%\Windows.old" >nul 2>&1
PushD "%SystemDrive%\Recovery" && (RD /S /Q "%SystemDrive%\Recovery" 2>nul & popd)
PushD "D:\WUDownloadCache" && (RD /S /Q "D:\WUDownloadCache" 2>nul & popd)
%WINDIR%\System32\rundll32.exe INETCpl.cpl, ClearMyTracksByProcess 1 >nul 2>&1
%WINDIR%\System32\rundll32.exe INETCpl.cpl, ClearMyTracksByProcess 2 >nul 2>&1
%WINDIR%\System32\rundll32.exe INETCpl.cpl, ClearMyTracksByProcess 4 >nul 2>&1
%WINDIR%\System32\rundll32.exe INETCpl.cpl, ClearMyTracksByProcess 8 >nul 2>&1
%WINDIR%\System32\rundll32.exe INETCpl.cpl, ClearMyTracksByProcess 10 >nul 2>&1
%WINDIR%\System32\rundll32.exe INETCpl.cpl, ClearMyTracksByProcess 16 >nul 2>&1
%WINDIR%\System32\rundll32.exe INETCpl.cpl, ClearMyTracksByProcess 20 >nul 2>&1
%WINDIR%\System32\rundll32.exe INETCpl.cpl, ClearMyTracksByProcess 32 >nul 2>&1
%WINDIR%\System32\rundll32.exe INETCpl.cpl, ClearMyTracksByProcess 64 >nul 2>&1
%WINDIR%\System32\rundll32.exe INETCpl.cpl, ClearMyTracksByProcess 40 >nul 2>&1
%WINDIR%\System32\rundll32.exe INETCpl.cpl, ClearMyTracksByProcess 80 >nul 2>&1
%WINDIR%\System32\rundll32.exe INETCpl.cpl, ClearMyTracksByProcess 128 >nul 2>&1
%WINDIR%\System32\rundll32.exe INETCpl.cpl, ClearMyTracksByProcess 255 >nul 2>&1
%WINDIR%\System32\rundll32.exe INETCpl.cpl, ClearMyTracksByProcess 800 >nul 2>&1
%WINDIR%\System32\rundll32.exe INETCpl.cpl, ClearMyTracksByProcess 4351 >nul 2>&1
PushD "%LocalAppData%\Microsoft\Windows\WER" && (RD /S /Q "%LocalAppData%\Microsoft\Windows\WER" 2>nul & popd)
PushD "%LocalAppData%\Microsoft\Windows\INETCache" && (RD /S /Q "%LocalAppData%\Microsoft\Windows\INETCache" 2>nul & popd)
PushD "%LocalAppData%\Microsoft\Windows\INETCookies" && (RD /S /Q "%LocalAppData%\Microsoft\Windows\INETCookies" 2>nul & popd)
PushD "%LocalAppData%\Microsoft\Windows\IECompatCache" && (RD /S /Q "%LocalAppData%\Microsoft\Windows\IECompatCache" 2>nul & popd)
PushD "%LocalAppData%\Microsoft\Windows\IECompatUaCache" && (RD /S /Q "%LocalAppData%\Microsoft\Windows\IECompatUaCache" 2>nul & popd)
PushD "%LocalAppData%\Microsoft\Windows\IEDownloadHistory" && (RD /S /Q "%LocalAppData%\Microsoft\Windows\IEDownloadHistory" 2>nul & popd)
PushD "%LocalAppData%\Microsoft\Windows\Temporary InterNET Files" && (RD /S /Q "%LocalAppData%\Microsoft\Windows\Temporary InterNET Files" 2>nul & popd)
PushD "%LocalAppData%\Microsoft\Windows\WebCache" && (RD /S /Q "%LocalAppData%\Microsoft\Windows\WebCache" 2>nul & popd)
PushD "%WINDIR%\Prefetch" && (RD /S /Q "%WINDIR%\Prefetch" 2>nul & popd)
PushD "%WINDIR%\SoftwareDistribution\Download" && (RD /S /Q "%WINDIR%\SoftwareDistribution\Download" 2>nul & popd)
PushD "%SystemDrive%\$Recycle.Bin" && (RD /S /Q "%SystemDrive%\$Recycle.Bin" 2>nul & popd)
PushD "D:\$Recycle.Bin" && (RD /S /Q "D:\$Recycle.Bin" 2>nul & popd)
PushD "E:\$Recycle.Bin" && (RD /S /Q "E:\$Recycle.Bin" 2>nul & popd)
PushD "F:\$Recycle.Bin" && (RD /S /Q "F:\$Recycle.Bin" 2>nul & popd)
PushD "G:\$Recycle.Bin" && (RD /S /Q "G:\$Recycle.Bin" 2>nul & popd)
PushD "D:\Temp\" && (RD /S /Q "D:\Temp\" 2>nul & popd)
PushD "%WINDIR%\System32\winevt\Logs" && (RD /S /Q "%WINDIR%\System32\winevt\Logs" 2>nul & popd)
PushD "%WINDIR%\Logs" && (RD /S /Q "%WINDIR%\Logs" 2>nul & popd)
PushD "%temp%" && (RD /S /Q "%temp%" 2>nul & popd)
PushD "%SystemDrive%\Temp\" && (RD /S /Q "%SystemDrive%\Temp\" 2>nul & popd)
PushD "%LOCALAPPDATA%\Temp" && (RD /S /Q "%LOCALAPPDATA%\Temp" 2>nul & popd)
PushD "%WINDIR%\Temp" && (RD /S /Q "%WINDIR%\Temp" 2>nul & popd)

ECHO Done!


ECHO.
ECHO :::::::::::::::::::::::::::::
ECHO ::::: Disk Optimization :::::
ECHO :::::::::::::::::::::::::::::
ECHO.

Defrag /C /O

ECHO.
ECHO.
ECHO :: Optimization completed successfully. :: Script by S.H.E.I.K.H (GitHub: Sheikh98-DEV)
ECHO .
ECHO :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
ECHO :::: Warning. Press any key to shutdown or simply close this batch file. ::::
ECHO :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
ECHO .

Pause >null

RD /S /Q "%SystemDrive%\$GetCurrent" >nul 2>&1
RD /S /Q "%SystemDrive%\$SysReset" >nul 2>&1
RD /S /Q "%SystemDrive%\$Windows.~BT" >nul 2>&1
RD /S /Q "%SystemDrive%\$Windows.~WS" >nul 2>&1
RD /S /Q "%SystemDrive%\$WinREAgent" >nul 2>&1
RD /S /Q "%SystemDrive%\OneDriveTemp" >nul 2>&1
RD /S /Q "%SystemDrive%\Windows.old" >nul 2>&1
PushD "%SystemDrive%\Recovery" && (RD /S /Q "%SystemDrive%\Recovery" 2>nul & popd)
PushD "%ProgramData%\USOShared\Logs" && (RD /S /Q "%ProgramData%\USOShared\Logs" 2>nul & popd)
PushD "%LocalAppData%\Microsoft\Windows\WER" && (RD /S /Q "%LocalAppData%\Microsoft\Windows\WER" 2>nul & popd)
PushD "%LocalAppData%\Microsoft\Windows\INetCache" && (RD /S /Q "%LocalAppData%\Microsoft\Windows\INetCache" 2>nul & popd)
PushD "%LocalAppData%\Microsoft\Windows\INetCookies" && (RD /S /Q "%LocalAppData%\Microsoft\Windows\INetCookies" 2>nul & popd)
PushD "%LocalAppData%\Microsoft\Windows\IECompatCache" && (RD /S /Q "%LocalAppData%\Microsoft\Windows\IECompatCache" 2>nul & popd)
PushD "%LocalAppData%\Microsoft\Windows\IECompatUaCache" && (RD /S /Q "%LocalAppData%\Microsoft\Windows\IECompatUaCache" 2>nul & popd)
PushD "%LocalAppData%\Microsoft\Windows\IEDownloadHistory" && (RD /S /Q "%LocalAppData%\Microsoft\Windows\IEDownloadHistory" 2>nul & popd)
PushD "%LocalAppData%\Microsoft\Windows\Temporary Internet Files" && (RD /S /Q "%LocalAppData%\Microsoft\Windows\Temporary Internet Files" 2>nul & popd)
PushD "%LocalAppData%\Microsoft\Windows\WebCache" && (RD /S /Q "%LocalAppData%\Microsoft\Windows\WebCache" 2>nul & popd)
PushD "%WINDIR%\Prefetch" && (RD /S /Q "%WINDIR%\Prefetch" 2>nul & popd)
PushD "%WINDIR%\SoftwareDistribution\Download" && (RD /S /Q "%WINDIR%\SoftwareDistribution\Download" 2>nul & popd)
PushD "%SystemDrive%\$Recycle.Bin" && (RD /S /Q "%SystemDrive%\$Recycle.Bin" 2>nul & popd)
PushD "%WINDIR%\System32\winevt\Logs" && (RD /S /Q "%WINDIR%\System32\winevt\Logs" 2>nul & popd)
PushD "%WINDIR%\Logs" && (RD /S /Q "%WINDIR%\Logs" 2>nul & popd)
PushD "%temp%" && (RD /S /Q "%temp%" 2>nul & popd)
PushD "%SystemDrive%\Temp\" && (RD /S /Q "%SystemDrive%\Temp\" 2>nul & popd)
PushD "%LOCALAPPDATA%\Temp" && (RD /S /Q "%LOCALAPPDATA%\Temp" 2>nul & popd)
PushD "%WINDIR%\Temp" && (RD /S /Q "%WINDIR%\Temp" 2>nul & popd)
Shutdown /S /T 0
