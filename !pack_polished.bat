@ECHO OFF

set version_tag=NOV2015b
set out_path=_comp

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
echo ====================== Porting Item List and Script Packer...  
echo.

rem copy %script_path%\items.txt %out_path%
copy .\ScriptPack.exe %out_path%
echo Done.

echo.
echo ====================== Compiling...
echo.

cd /d %out_path%
ScriptPack.exe
echo Done.

echo.
echo ====================== Complete.
echo.

echo.
echo ***************** completed %date% %time% *****************
echo.

pause >>nul