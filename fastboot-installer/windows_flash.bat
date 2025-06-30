@echo off&setlocal enabledelayedexpansion
cd %~dp0
cd ..
title Fastboot Flasher
set fastboot=META-INF\bin\fastboot\fastboot.exe
if %PROCESSOR_ARCHITECTURE%==x86 (set fastboot_f=META-INF\bin\fastboot\fastboot32.exe) else set fastboot_f=META-INF\bin\fastboot\fastboot64.exe
echo.==============================================
echo.              Fastboot Flasher
echo.                   WINDOWS
echo.==============================================
echo.
set /p CHOICE="Format Data? (y/n): "
echo.

set "codename1=vili"
set "codename2=viliin"

%fastboot% getvar product 2>&1 | findstr /r /c:"^product: *%codename1%"  >NUL 2>NUL
set "match1=%errorlevel%"
%fastboot% getvar product 2>&1 | findstr /r /c:"^product: *%codename2%"  >NUL 2>NUL
set "match2=%errorlevel%"

if %match1% equ 0 (
    echo.
) else if %match2% equ 0 (
    echo.
) else (
    echo.This ROM is not compatible for your device! aborting...
    pause
    exit /B 1
)


%fastboot% set_active a >NUL 2>NUL
	
set super=super
echo.Flashing partitions...
%fastboot_f% -d %super% -o %super%.img
%fastboot% erase super >NUL 2>NUL
%fastboot% flash super %super%.img
del %super%.img

:: for sparsechunk (comment or remove zstd code ones if you're using this)
:: 
:: set "chunkname=super.img_sparsechunk"
:: set "startchunk=0"
:: set "endchunk=12"
:: %fastboot% erase super >NUL 2>NUL
:: for /L %%i in (%startchunk%,1,%endchunk%) do (
::     echo Flashing %chunkname%.%%i
::     %fastboot% flash super %chunkname%.%%i
:: )

if exist "oemports10t/oem_cust" (
    echo.
    echo.Flashing cust...
    %fastboot_f% -d oemports10t/oem_cust -o oem_cust.img
    %fastboot% erase cust >NUL 2>NUL
    %fastboot% flash cust oem_cust.img
    del oem_cust.img
)

echo.
echo.Flashing images...
%fastboot% flash boot_ab images/boot.img
%fastboot% flash dtbo_ab images/dtbo.img
%fastboot% flash vendor_boot_ab images/vendor_boot.img
%fastboot% flash vbmeta_ab images/vbmeta.img
%fastboot% flash vbmeta_system_ab images/vbmeta_system.img


echo.
echo.==============================================
echo.          ROM INSTALLED SUCCESSFULLY
if /I "%CHOICE%" == "y" (
    echo.                 FORMATTING DATA
    %fastboot% erase userdata >NUL 2>NUL
    %fastboot% erase metadata >NUL 2>NUL
    echo.                  REBOOTING
    %fastboot% reboot
    echo.==============================================
) else if /I "%CHOICE%" == "n" (
    echo.==============================================
    echo.if you want to wipe /data without formatting internal storage, reboot to recovery and wipe manually
    echo.
)
echo.
pause
exit /B 1
