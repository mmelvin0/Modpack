@echo off
setlocal
cd "%~dp0"
set scripts=%CD%
call %scripts%\package-client.bat
call %scripts%\package-server.bat
