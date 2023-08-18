@ECHO OFF

set version_tag=ALP2017

set betapack_dll_path=%msc_betapack_path%\dlls\
set script_path=d:\hldev\scripts_msc\scripts\
set script_path_m1=d:\hldev\scripts_msc\
set out_path=f:\temp\scriptout\
set steam_path=%msc_path%\dlls\
:loop
title Packing TEST SC.DLL %date% %time%
echo REMEMBER TO UPDATE VERSION_TAG IN THIS BATCH FILE
echo Current Version tag: %version_tag%
echo.
pause
echo.
echo.
rem if "%1"=="" goto :error_par
cd .\scripts

echo.
echo ====================== Setting time stamp... 
echo.

echo.
echo { >beta_date.script
echo 	const BETA_TIMESTAMP "DEVELOPER %date% %time%" >>beta_date.script
echo 	setvarg G_SCRIPT_VERSION %version_tag% >>beta_date.script
echo } >>beta_date.script
echo Done.

rem echo.
rem echo ====================== Clearing output folder... 
rem echo.

rem echo - Clear Files
rem del /s /q %out_path%\*.*
rem echo - Clear Folders
rem rmdir /q /s  %out_path%
rem echo - Remake path %out_path%
rem md %out_path%
rem echo Done.
rem echo.
rem echo If there were errors, check that %out_path% exists and is empty.
rem pause

echo.
echo ====================== Cooking Scripts... 
echo.

..\cookscripts %script_path% %out_path%
echo Done.

echo.
echo ====================== Porting Item List and Script Packer...  
echo.

rem copy %script_path%\items.txt %out_path%
copy %script_path%\..\ScriptPack.exe %out_path%
echo Done.

echo.
echo ====================== Compiling...
echo.

cd /d %out_path%
ScriptPack.exe
echo Done.

echo.
echo ====================== Propigating...
echo.

echo To scripts folder:
cd /d %script_path%..
copy %out_path%sc.dll %script_path%..
move sc.dll %script_path%..
echo To local client:
copy sc.dll %steam_path%
echo To beta pack:
copy sc.dll %betapack_dll_path%
rem echo To laptop HLDS:
rem copy sc.dll" "\\Miniagnus3\hlds\msc\dlls\"
cd..
echo Done.

echo.
echo ====================== Complete.
echo.

echo.
echo ***************** completed %date% %time% *****************
echo.

pause >>nul