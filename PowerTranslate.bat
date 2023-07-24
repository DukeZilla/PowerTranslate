@echo off
break off
PUSHD "%CD%"
CD /D "%~dp0"
goto main

:main
title Power Translator
@echo off
cls
:run
echo.
echo.
powershell.exe -executionpolicy bypass -f "main.ps1"
if %errorlevel%==1 (
	echo Error file not found 404
	pause
)
echo.
exit