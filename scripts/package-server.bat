@echo off
setlocal
cd "%~dp0.."
set root=%CD%
set build=%root%\build
set /p version=<"%root%\version.txt"
set zipfile=%build%\modpack-server-v%version%.zip
if not exist "%build%" ( mkdir "%build%" )
if exist "%zipfile%" ( del /f /q "%zipfile%" )
cd "%root%\common"
zip -rq "%zipfile%" .
cd "%root%\server"
zip -rq "%zipfile%" .
endlocal
