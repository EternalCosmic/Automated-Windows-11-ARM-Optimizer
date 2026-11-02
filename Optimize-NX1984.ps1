# ==============================================================================
# Siemens NX 1984 Windows 11 ARM Compatibility Setup Assistant
# ==============================================================================

Write-Host "[+] Initializing Windows 11 ARM Optimizer for Siemens NX 1984..." -ForegroundColor Cyan

# 1. Path Configuration (Adjust path if NX is installed in a non-default location)
$NXBinPath = "C:\Program Files\Siemens\NX1984\NXBIN\ugraf.exe"

if (-not (Test-Path $NXBinPath)) {
    Write-Host "[!] Warning: ugraf.exe not found at standard path." -ForegroundColor Yellow
    $NXBinPath = Read-Host "Please enter full path to ugraf.exe"
}

# 2. Inject Registry Hooks for Prism (x64-to-ARM Emulation Override)
Write-Host "[+] Applying Prism Emulation flags to Siemens NX binary..." -ForegroundColor Green
$AppCompatPath = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"

if (-not (Test-Path $AppCompatPath)) {
    New-Item -Path $AppCompatPath -Force | Out-Null
}

# Flags: HIGHDPIAWARE, RUNASADMIN, ~ HIGHPFX (Forces x64 execution precision on ARM)
$Flags = "~ HIGHDPIAWARE RUNASADMIN"
New-ItemProperty -Path $AppCompatPath -Name $NXBinPath -Value $Flags -PropertyType String -Force | Out-Null

# 3. Environment Variable Configuration for License Server
$LicenseServer = Read-Host "Enter Siemens License Server (e.g., 28000@localhost or IP) [Press Enter to skip]"
if ($LicenseServer -ne "") {
    [System.Environment]::SetEnvironmentVariable("SPLM_LICENSE_SERVER", $LicenseServer, [System.EnvironmentVariableTarget]::Machine)
    Write-Host "[+] SPLM_LICENSE_SERVER set to $LicenseServer" -ForegroundColor Green
}

# 4. Disable GPU Hardware Checks (Workaround for Virtualized Display Drivers)
Write-Host "[+] Setting OpenGL/DirectX compatibility variables..." -ForegroundColor Green
[System.Environment]::SetEnvironmentVariable("UGII_BASE_DIR", "$($NXBinPath | Split-Path -Parent)\..", [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable("UGII_DISPLAY_DEBUG", "0", [System.EnvironmentVariableTarget]::Machine)

Write-Host "`n[SUCCESS] Configuration Complete! Restart your VM for settings to apply." -ForegroundColor Green
