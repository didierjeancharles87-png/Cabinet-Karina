@echo off
cd /d "%~dp0"
set PHP=%~dp0php\php.exe
if not exist "%PHP%" set PHP=C:\xampp\php\php.exe
for %%i in ("%PHP%") do set PHPDIR=%%~dpi
echo PHP utilise : %PHP%
"%PHP%" -v
echo.
echo Extensions necessaires :
"%PHP%" -c php.ini -d "extension_dir=%PHPDIR%ext" -m | findstr /i "sqlite mbstring"
echo.
echo Test de demarrage (Ctrl+C pour quitter) :
"%PHP%" -c php.ini -d "extension_dir=%PHPDIR%ext" -S 0.0.0.0:8080 -t cabinet cabinet\router.php
pause
