# Automated-Windows-11-ARM-Optimizer
# Siemens NX 1984 Windows 11 ARM Optimizer

A helper toolkit to optimize and configure Windows 11 ARM64 virtual machines for running Siemens NX 1984 smoothly on Apple Silicon Macs.

## Features
- Injects Prism x64 emulation high-precision flags.
- Bypasses OpenGL/GPU virtualized display warnings.
- Sets local/remote FlexLM license environment variables.

## How to Use

### 1. Run the Setup Script
Open **PowerShell as Administrator** inside your Windows 11 ARM VM and run:

```powershell
Set-ExecutionPolicy Unrestricted -Scope Process
Invoke-WebRequest -Uri "[https://raw.githubusercontent.com/EternalCosmic/Automated-Windows-11-ARM-Optimizer/main/Optimize-NX1984.ps1](https://raw.githubusercontent.com/EternalCosmic/Automated-Windows-11-ARM-Optimizer/main/Optimize-NX1984.ps1)" -OutFile "Optimize-NX1984.ps1"
.\Optimize-NX1984.ps1
