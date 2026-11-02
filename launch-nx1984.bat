@echo off
TITLE Siemens NX 1984 ARM64 Assistant Launcher
echo Initializing NX 1984 execution context...

:: Set CPU Emulation Flags for current process tree
set PROCESSOR_ARCHITECTURE=AMD64
set UGII_SURFACE_METHOD=1

:: Prevent Siemens OpenGL Driver Warning Dialogs
set UGII_CHECK_GPU=0

:: Execute NX Main Executable
start "" "C:\Program Files\Siemens\NX1984\NXBIN\ugraf.exe" %*
