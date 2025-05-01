@echo off
setlocal enabledelayedexpansion

set NIRCMD=C:\Outils\nircmd-x64\nircmd.exe
set SAVEFILE=%USERPROFILE%\explorateur_fenetres.txt

> "%SAVEFILE%" (
    for /f "tokens=*" %%A in ('"%NIRCMD%" win enumerate title " - Explorateur de fichiers"') do (
        for /f "tokens=2 delims=," %%B in ('"%NIRCMD%" win getprocess %%A') do (
            for /f "tokens=*" %%C in ('wmic process where ProcessId^=%%B get CommandLine /value ^| find "="') do (
                echo %%C
            )
        )
    )
)

echo Fichiers sauvegardés dans: %SAVEFILE%
pause
