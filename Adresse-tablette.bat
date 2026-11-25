@echo off
echo.
echo  Sur la tablette / le telephone (meme Wi-Fi que cet ordinateur),
echo  ouvrez le navigateur et tapez l'une de ces adresses :
echo.
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /C:"IPv4"') do echo     http://%%a:8080/
echo.
echo  (enlevez l'espace avant le chiffre si besoin)
echo.
pause
