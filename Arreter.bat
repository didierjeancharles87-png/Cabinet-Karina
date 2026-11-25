@echo off
taskkill /F /IM php.exe >nul 2>&1
echo Serveur du cabinet arrete.
timeout /t 2 >nul
