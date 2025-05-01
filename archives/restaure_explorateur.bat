@echo off
set SAVEFILE=%USERPROFILE%\explorateur_fenetres.txt

if exist "%SAVEFILE%" (
    for /f "usebackq tokens=*" %%A in ("%SAVEFILE%") do (
        set "line=%%A"
        call :launch !line!
    )
) else (
    echo Aucun fichier de sauvegarde trouvé.
)
goto :eof

:launch
set "cmd=%~1"
for %%P in (%cmd%) do (
    if exist "%%~P" (
        start "" explorer "%%~P"
    )
)
goto :eof

@REM Non fonctionnel