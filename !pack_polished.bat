@ECHO OFF

set out_path=scripts

:loop
title Packing TEST SC.DLL %date% %time%
pause
echo.
echo.

echo.
echo ====================== Compiling...
echo.
Scriptpack.exe %out_path%
echo Done.

echo.
echo ====================== Complete.
echo.

echo.
echo ***************** completed %date% %time% *****************
echo.

pause >>nul