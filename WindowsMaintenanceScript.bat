@echo off

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: This Script will repair Windows with SFC and DISM commands and then runs a deep clean command to       ::
:: delete temporary files.                                                                                ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Check to see if this batch file is being run as Administrator. If it is not, then rerun the batch file ::
:: automatically as admin and terminate the initial instance of the batch file.                           ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

(Fsutil Dirty Query %SystemDrive%>Nul)||(PowerShell start """%~f0""" -verb RunAs & Exit /B) > NUL 2>&1

::::::::::::::::::::::::::::::::::::::::::::::::
:: End Routine to check if being run as Admin ::
::::::::::::::::::::::::::::::::::::::::::::::::

cd /d "%~dp0"
cls

echo :::::::::::::::::::::::::::::::::::::::
echo ::  Windows Optimizer Script         ::
echo ::                                   ::
echo ::  Version 3.0.0 (Stable)           ::
echo ::                                   ::
echo ::  Jul 04, 2025 by  S.H.E.I.K.H     ::
echo :::::::::::::::::::::::::::::::::::::::
echo.
echo.
pause


echo.
echo ::::::::::::::::::::::::::::::::
echo ::::: Starting Maintenance :::::
echo ::::::::::::::::::::::::::::::::
echo.

control wscui.cpl >nul 2>&1
MSchedExe.exe Start
echo Please wait until the end of maintenance,
echo Then return here and
pause
echo Running Idle Tasks, Please wait...
rundll32.exe advapi32.dll,ProcessIdleTasks

echo Done!

echo.
echo ::::::::::::::::::::::::
echo ::::: Closing apps :::::
echo ::::::::::::::::::::::::
echo.

taskkill /F /IM "msedge.exe" >nul 2>&1
taskkill /F /IM "CrossDeviceResume.exe" >nul 2>&1

echo Done!

echo.
echo :::::::::::::::::::::::::
echo ::::: Checking Disk :::::
echo :::::::::::::::::::::::::
echo.

chkdsk

echo Done!

echo.
echo ::::::::::::::::::::::::::::::
echo ::::: Cleaning DISM Temp :::::
echo ::::::::::::::::::::::::::::::
echo.

dism /online /cleanup-image /analyzecomponentstore
dism /online /cleanup-image /startcomponentcleanup
dism /online /cleanup-image /startcomponentcleanup /resetbase

echo Done!

echo.
echo :::::::::::::::::::::::::::::
echo ::::: Repairing Windows :::::
echo :::::::::::::::::::::::::::::
echo.

dism /online /cleanup-image /checkhealth >nul 2>&1
dism /online /cleanup-image /scanhealth
dism /online /cleanup-image /restorehealth
sfc /verifyonly
sfc /scannow
dism /online /cleanup-image /analyzecomponentstore
dism /online /cleanup-image /startcomponentcleanup
dism /online /cleanup-image /startcomponentcleanup /resetbase

echo Done!

echo.
echo :::::::::::::::::::::::::::::::::::::::
echo ::::: Calling Revo and PC Manager :::::
echo :::::::::::::::::::::::::::::::::::::::
echo.

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: If you don't have any of these applications, please remove this part ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

cmd.exe /c Cleanmgr /sageset:65535 & Cleanmgr /sagerun:65535 >nul 2>&1
start RevoUninPro.exe >nul 2>&1
net start "PCManager Service Store" >nul 2>&1
start shell:AppsFolder\Microsoft.MicrosoftPCManager_8wekyb3d8bbwe!App >nul 2>&1
pause
net stop "PCManager Service Store" >nul 2>&1
taskkill /F /IM MSPCManager.exe >nul 2>&1
taskkill /F /IM RevoUninPro.exe >nul 2>&1

echo Done!

echo.
echo ::::::::::::::::::::::::::::::
echo ::::: Cleaning Edge Temp :::::
echo ::::::::::::::::::::::::::::::
echo.

del /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\History*" >nul 2>&1
del /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Media History*" >nul 2>&1
del /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Visited Links*" >nul 2>&1
del /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Top Sites*" >nul 2>&1
del /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Network Action Predictor*" >nul 2>&1
del /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Shortcuts*" >nul 2>&1
del /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Network\Cookies*" >nul 2>&1
del /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Web Data*" >nul 2>&1
pushd "%LocalAppData%\Microsoft\Edge\User Data\Default\Session Storage" && (rd /s /q "%LocalAppData%\Microsoft\Edge\User Data\Default\Session Storage" 2>nul & popd)
pushd "%LocalAppData%\Microsoft\Edge\User Data\Default\Sync Data" && (rd /s /q "%LocalAppData%\Microsoft\Edge\User Data\Default\Sync Data" 2>nul & popd)
pushd "%LocalAppData%\Microsoft\Edge\User Data\Default\Telemetry" && (rd /s /q "%LocalAppData%\Microsoft\Edge\User Data\Default\Telemetry" 2>nul & popd)
pushd "%LocalAppData%\Microsoft\Edge\User Data\CrashReports" && (rd /s /q "%LocalAppData%\Microsoft\Edge\User Data\CrashReports" 2>nul & popd)
pushd "%LocalAppData%\Microsoft\EdgeUpdate\Log" && (rd /s /q "%LocalAppData%\Microsoft\EdgeUpdate\Log" 2>nul & popd)
pushd "%LocalAppData%\Microsoft\EdgeUpdate\Download" && (rd /s /q "%LocalAppData%\Microsoft\EdgeUpdate\Download" 2>nul & popd)
pushd "%LocalAppData%\Microsoft\EdgeUpdate\Install" && (rd /s /q "%LocalAppData%\Microsoft\EdgeUpdate\Install" 2>nul & popd)
pushd "%LocalAppData%\Microsoft\EdgeUpdate\Offline" && (rd /s /q "%LocalAppData%\Microsoft\EdgeUpdate\Offline" 2>nul & popd)
pushd "%LocalAppData%\Microsoft\Edge\User Data\BrowserMetrics" && (rd /s /q "%LocalAppData%\Microsoft\Edge\User Data\BrowserMetrics" 2>nul & popd)
pushd "%LocalAppData%\Microsoft\Edge\User Data\Crashpad\reports" && (rd /s /q "%LocalAppData%\Microsoft\Edge\User Data\Crashpad\reports" 2>nul & popd)
pushd "%LocalAppData%\Microsoft\Edge\User Data\Stability" && (rd /s /q "%LocalAppData%\Microsoft\Edge\User Data\Stability" 2>nul & popd)
pushd "%LocalAppData%\Microsoft\Edge\User Data\Stability" && (rd /s /q "%LocalAppData%\Microsoft\Edge\User Data\Stability" 2>nul & popd)
pushd "%LocalAppData%\Microsoft\Edge\User Data\Feature Engagement Tracker" && (rd /s /q "%LocalAppData%\Microsoft\Edge\User Data\Feature Engagement Tracker" 2>nul & popd)

echo Done!

echo.
echo ::::::::::::::::::::::::::::::::
echo ::::: Cleaning Office Temp :::::
echo ::::::::::::::::::::::::::::::::
echo.

pushd "%LOCALAPPDATA%\Microsoft\Office\16.0\Wef\" && (rd /s /q "%LOCALAPPDATA%\Microsoft\Office\16.0\Wef\" 2>nul & popd)
pushd "%userprofile%\AppData\Local\Packages\Microsoft.Win32WebViewHost_cw5n1h2txyewy\AC\#!123\INetCache\" && (rd /s /q "%userprofile%\AppData\Local\Packages\Microsoft.Win32WebViewHost_cw5n1h2txyewy\AC\#!123\INetCache\" 2>nul & popd)
pushd "%userprofile%\AppData\Local\Microsoft\Outlook\HubAppFileCache" && (rd /s /q "%userprofile%\AppData\Local\Microsoft\Outlook\HubAppFileCache" 2>nul & popd)
rd /s /q "%USERPROFILE%\Documents\Custom Office Templates" >nul 2>&1

echo Done!

echo.
echo :::::::::::::::::::::::::::::
echo ::::: Resetting Network :::::
echo :::::::::::::::::::::::::::::
echo.

netsh winhttp reset proxy >nul
ipconfig /release >nul
ipconfig /flushdns >nul
ipconfig /renew >nul
netsh int ip reset >nul
netsh winsock reset >nul

echo Done!

echo.
echo :::::::::::::::::::::::::::::::::
echo ::::: Cleaning Windows Temp :::::
echo :::::::::::::::::::::::::::::::::
echo.

takeown /s %computername% /u %username% /f "%WinDir%\System32\smartscreen.exe"
icacls "%WinDir%\System32\smartscreen.exe" /grant:r %username%:F
taskkill /im smartscreen.exe /f
del "%WinDir%\System32\smartscreen.exe" /s /f /q
taskkill /F /IM "CrossDeviceResume.exe" >nul 2>&1
cd "%WINDIR%\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy" >nul 2>&1
takeown /f "Microsoft.Web.WebView2.Core.dll" >nul 2>&1
icacls "Microsoft.Web.WebView2.Core.dll" /grant administrators:F >nul 2>&1
del /f /q "%WINDIR%\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\Microsoft.Web.WebView2.Core.dll" >nul 2>&1
cd /d "%WINDIR%\System32" >nul 2>&1
rundll32.exe pnpclean.dll,RunDLL_PnpClean /drivers /maxclean >nul 2>&1
cleanmgr /sagerun 1 >nul 2>&1
cleanmgr /verylowdisk >nul 2>&1
rd /s /q "%SystemDrive%\$GetCurrent" >nul 2>&1
rd /s /q "%SystemDrive%\$SysReset" >nul 2>&1
rd /s /q "%SystemDrive%\$Windows.~BT" >nul 2>&1
rd /s /q "%SystemDrive%\$Windows.~WS" >nul 2>&1
rd /s /q "%SystemDrive%\$WinREAgent" >nul 2>&1
rd /s /q "%SystemDrive%\OneDriveTemp" >nul 2>&1
rd /s /q "%SystemDrive%\Windows.old" >nul 2>&1
pushd "%SystemDrive%\Recovery" && (rd /s /q "%SystemDrive%\Recovery" 2>nul & popd)
pushd "D:\WUDownloadCache" && (rd /s /q "D:\WUDownloadCache" 2>nul & popd)
%WINDIR%\System32\rundll32.exe InetCpl.cpl, ClearMyTracksByProcess 1 >nul 2>&1
%WINDIR%\System32\rundll32.exe InetCpl.cpl, ClearMyTracksByProcess 2 >nul 2>&1
%WINDIR%\System32\rundll32.exe InetCpl.cpl, ClearMyTracksByProcess 4 >nul 2>&1
%WINDIR%\System32\rundll32.exe InetCpl.cpl, ClearMyTracksByProcess 8 >nul 2>&1
%WINDIR%\System32\rundll32.exe InetCpl.cpl, ClearMyTracksByProcess 10 >nul 2>&1
%WINDIR%\System32\rundll32.exe InetCpl.cpl, ClearMyTracksByProcess 16 >nul 2>&1
%WINDIR%\System32\rundll32.exe InetCpl.cpl, ClearMyTracksByProcess 20 >nul 2>&1
%WINDIR%\System32\rundll32.exe InetCpl.cpl, ClearMyTracksByProcess 32 >nul 2>&1
%WINDIR%\System32\rundll32.exe InetCpl.cpl, ClearMyTracksByProcess 64 >nul 2>&1
%WINDIR%\System32\rundll32.exe InetCpl.cpl, ClearMyTracksByProcess 40 >nul 2>&1
%WINDIR%\System32\rundll32.exe InetCpl.cpl, ClearMyTracksByProcess 80 >nul 2>&1
%WINDIR%\System32\rundll32.exe InetCpl.cpl, ClearMyTracksByProcess 128 >nul 2>&1
%WINDIR%\System32\rundll32.exe InetCpl.cpl, ClearMyTracksByProcess 255 >nul 2>&1
%WINDIR%\System32\rundll32.exe InetCpl.cpl, ClearMyTracksByProcess 800 >nul 2>&1
%WINDIR%\System32\rundll32.exe InetCpl.cpl, ClearMyTracksByProcess 4351 >nul 2>&1
pushd "%LocalAppData%\Microsoft\Windows\WER" && (rd /s /q "%LocalAppData%\Microsoft\Windows\WER" 2>nul & popd)
pushd "%LocalAppData%\Microsoft\Windows\INetCache" && (rd /s /q "%LocalAppData%\Microsoft\Windows\INetCache" 2>nul & popd)
pushd "%LocalAppData%\Microsoft\Windows\INetCookies" && (rd /s /q "%LocalAppData%\Microsoft\Windows\INetCookies" 2>nul & popd)
pushd "%LocalAppData%\Microsoft\Windows\IECompatCache" && (rd /s /q "%LocalAppData%\Microsoft\Windows\IECompatCache" 2>nul & popd)
pushd "%LocalAppData%\Microsoft\Windows\IECompatUaCache" && (rd /s /q "%LocalAppData%\Microsoft\Windows\IECompatUaCache" 2>nul & popd)
pushd "%LocalAppData%\Microsoft\Windows\IEDownloadHistory" && (rd /s /q "%LocalAppData%\Microsoft\Windows\IEDownloadHistory" 2>nul & popd)
pushd "%LocalAppData%\Microsoft\Windows\Temporary Internet Files" && (rd /s /q "%LocalAppData%\Microsoft\Windows\Temporary Internet Files" 2>nul & popd)
pushd "%LocalAppData%\Microsoft\Windows\WebCache" && (rd /s /q "%LocalAppData%\Microsoft\Windows\WebCache" 2>nul & popd)
pushd "%WINDIR%\Prefetch" && (rd /s /q "%WINDIR%\Prefetch" 2>nul & popd)
pushd "%WINDIR%\SoftwareDistribution\Download" && (rd /s /q "%WINDIR%\SoftwareDistribution\Download" 2>nul & popd)
pushd "%SystemDrive%\$Recycle.Bin" && (rd /s /q "%SystemDrive%\$Recycle.Bin" 2>nul & popd)
pushd "D:\$Recycle.Bin" && (rd /s /q "D:\$Recycle.Bin" 2>nul & popd)
pushd "E:\$Recycle.Bin" && (rd /s /q "E:\$Recycle.Bin" 2>nul & popd)
pushd "F:\$Recycle.Bin" && (rd /s /q "F:\$Recycle.Bin" 2>nul & popd)
pushd "G:\$Recycle.Bin" && (rd /s /q "G:\$Recycle.Bin" 2>nul & popd)
pushd "D:\Temp\" && (rd /s /q "D:\Temp\" 2>nul & popd)
pushd "%WINDIR%\System32\winevt\Logs" && (rd /s /q "%WINDIR%\System32\winevt\Logs" 2>nul & popd)
pushd "%WINDIR%\Logs" && (rd /s /q "%WINDIR%\Logs" 2>nul & popd)
pushd "%temp%" && (rd /s /q "%temp%" 2>nul & popd)
pushd "%SystemDrive%\Temp\" && (rd /s /q "%SystemDrive%\Temp\" 2>nul & popd)
pushd "%LOCALAPPDATA%\Temp" && (rd /s /q "%LOCALAPPDATA%\Temp" 2>nul & popd)
pushd "%WINDIR%\Temp" && (rd /s /q "%WINDIR%\Temp" 2>nul & popd)


echo Done!

echo.
echo :::::::::::::::::::::::::::::
echo ::::: Disk Optimization :::::
echo :::::::::::::::::::::::::::::
echo.

defrag /C /O

echo Done!
echo.
echo *** Attention ***
echo If you press any key your PC will shutdown. Close this file if you don't want to turn off you machine.
pause

echo.
echo ::::::::::::::::::::::::
echo ::::: Shutting Down ::::
echo ::::::::::::::::::::::::
echo.

pushd "%LocalAppData%\Microsoft\Windows\WER" && (rd /s /q "%LocalAppData%\Microsoft\Windows\WER" 2>nul & popd)
pushd "%LocalAppData%\Microsoft\Windows\INetCache" && (rd /s /q "%LocalAppData%\Microsoft\Windows\INetCache" 2>nul & popd)
pushd "%LocalAppData%\Microsoft\Windows\INetCookies" && (rd /s /q "%LocalAppData%\Microsoft\Windows\INetCookies" 2>nul & popd)
pushd "%LocalAppData%\Microsoft\Windows\IECompatCache" && (rd /s /q "%LocalAppData%\Microsoft\Windows\IECompatCache" 2>nul & popd)
pushd "%LocalAppData%\Microsoft\Windows\IECompatUaCache" && (rd /s /q "%LocalAppData%\Microsoft\Windows\IECompatUaCache" 2>nul & popd)
pushd "%LocalAppData%\Microsoft\Windows\IEDownloadHistory" && (rd /s /q "%LocalAppData%\Microsoft\Windows\IEDownloadHistory" 2>nul & popd)
pushd "%LocalAppData%\Microsoft\Windows\Temporary Internet Files" && (rd /s /q "%LocalAppData%\Microsoft\Windows\Temporary Internet Files" 2>nul & popd)
pushd "%LocalAppData%\Microsoft\Windows\WebCache" && (rd /s /q "%LocalAppData%\Microsoft\Windows\WebCache" 2>nul & popd)
pushd "%WINDIR%\Prefetch" && (rd /s /q "%WINDIR%\Prefetch" 2>nul & popd)
pushd "%WINDIR%\SoftwareDistribution\Download" && (rd /s /q "%WINDIR%\SoftwareDistribution\Download" 2>nul & popd)
pushd "%SystemDrive%\$Recycle.Bin" && (rd /s /q "%SystemDrive%\$Recycle.Bin" 2>nul & popd)
pushd "D:\$Recycle.Bin" && (rd /s /q "D:\$Recycle.Bin" 2>nul & popd)
pushd "E:\$Recycle.Bin" && (rd /s /q "E:\$Recycle.Bin" 2>nul & popd)
pushd "F:\$Recycle.Bin" && (rd /s /q "F:\$Recycle.Bin" 2>nul & popd)
pushd "G:\$Recycle.Bin" && (rd /s /q "G:\$Recycle.Bin" 2>nul & popd)
pushd "D:\Temp\" && (rd /s /q "D:\Temp\" 2>nul & popd)
pushd "%WINDIR%\System32\winevt\Logs" && (rd /s /q "%WINDIR%\System32\winevt\Logs" 2>nul & popd)
pushd "%WINDIR%\Logs" && (rd /s /q "%WINDIR%\Logs" 2>nul & popd)
pushd "%temp%" && (rd /s /q "%temp%" 2>nul & popd)
pushd "%SystemDrive%\Temp\" && (rd /s /q "%SystemDrive%\Temp\" 2>nul & popd)
pushd "%LOCALAPPDATA%\Temp" && (rd /s /q "%LOCALAPPDATA%\Temp" 2>nul & popd)
pushd "%WINDIR%\Temp" && (rd /s /q "%WINDIR%\Temp" 2>nul & popd)

shutdown.exe /s /t 0
