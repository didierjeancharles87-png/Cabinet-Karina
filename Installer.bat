@echo off
cd /d "%~dp0"
title Installation - Cabinet Dentaire
echo.
echo  === Installation du Cabinet Dentaire ===
echo.
if not exist "php\php.exe" if not exist "C:\xampp\php\php.exe" (
  echo  PHP n'est pas encore installe. Lisez LISEZ-MOI-WINDOWS.txt ^(etape 1^),
  echo  puis relancez ce fichier.
  echo.
  start https://windows.php.net/download/
  pause
  exit /b
)
powershell -NoProfile -ExecutionPolicy Bypass -Command "$d=[Environment]::GetFolderPath('Desktop'); $s=(New-Object -ComObject WScript.Shell).CreateShortcut($d+'\Cabinet Dentaire.lnk'); $s.TargetPath='%~dp0Cabinet.vbs'; $s.WorkingDirectory='%~dp0'; $s.IconLocation='%~dp0cabinet.ico'; $s.Description='Cabinet Dentaire'; $s.Save()"
echo  [OK] Icone "Cabinet Dentaire" creee sur le Bureau.
echo.
set /p AUTO= Demarrer le serveur automatiquement avec Windows ? (O/N) :
if /i "%AUTO%"=="O" (
  powershell -NoProfile -ExecutionPolicy Bypass -Command "$d=[Environment]::GetFolderPath('Startup'); $s=(New-Object -ComObject WScript.Shell).CreateShortcut($d+'\Cabinet Dentaire (serveur).lnk'); $s.TargetPath='%~dp0Cabinet.vbs'; $s.Arguments='silent'; $s.WorkingDirectory='%~dp0'; $s.WindowStyle=7; $s.Save()"
  echo  [OK] Le serveur demarrera tout seul avec Windows.
)
echo.
echo  Termine. Double-cliquez sur l'icone "Cabinet Dentaire" du Bureau.
echo  Connexion : admin / admin123  ^(a changer dans Parametres^)
echo.
pause
