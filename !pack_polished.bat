@ECHO OFF

set version_tag=NOV2015a
set out_path=D:\github\mscscripts-nov2015b\scripts

:loop
title Packing TEST SC.DLL %date% %time%
echo REMEMBER TO UPDATE VERSION_TAG IN THIS BATCH FILE
echo Current Version tag: %version_tag%
echo.
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