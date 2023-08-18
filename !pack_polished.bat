@ECHO OFF

set version_tag=NOV2015a
set out_path=_comp

:loop
title Packing TEST SC.DLL %date% %time%
echo REMEMBER TO UPDATE VERSION_TAG IN THIS BATCH FILE
echo Current Version tag: %version_tag%
echo.
pause
echo.
echo.

echo.
echo ====================== Setting time stamp... 
echo.
cd ./scripts
echo.
echo { >beta_date.script
echo 	const BETA_TIMESTAMP "DEVELOPER %date% %time%" >>beta_date.script
echo 	setvarg G_SCRIPT_VERSION %version_tag% >>beta_date.script
echo } >>beta_date.script
echo Done.

echo.
echo ====================== Compiling...
echo.
cd ../
Scriptpack.exe
echo Done.

echo.
echo ====================== Complete.
echo.

echo.
echo ***************** completed %date% %time% *****************
echo.

pause >>nul