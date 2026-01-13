@echo off
:: ==================================================
:: Self‑Elevating Batch Script (Admin CMD)
:: ==================================================

:: Check for admin rights
>nul 2>&1 net session
if %errorlevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: ==================================================
:: Prompt ON / OFF
:: ==================================================
echo.
echo ========== Verified ^& Reputable Policy ==========
echo Turn ON:  1
echo Turn OFF: 2
echo Cancel:   C
echo.

choice /c 12C /n /m "Selection: "
set "userChoice=%errorlevel%"

if %userChoice%==1 (
    set newval=1
    set status=Policy set to ON
) else if %userChoice%==2 (
    set newval=0
    set status=Policy set to OFF
) else if %userChoice%==3 (
    goto :EOF
)

reg add "HKLM\System\CurrentControlSet\Control\CI\Policy" /v VerifiedAndReputablePolicyState /t REG_DWORD /d %newval% /f

:: ==================================================
:: Restart Options
:: ==================================================
echo.
echo ========== Restart Options ==========
echo Restart Now:   R
echo Restart Later: L
echo.

choice /c RL /n /m "Selection: "
set "rebootChoice=%errorlevel%"

:: Show status message
powershell -NoProfile -Command "Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('%status%','Policy Toggle','OK','Information')"

if %rebootChoice%==1 (
    shutdown /r /t 0
)

exit /b