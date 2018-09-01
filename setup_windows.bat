@echo off
REM
REM Windowsの環境設定
REM
setlocal
set HOME=%HOMEDRIVE%%HOMEPATH%

call :proc .agignore .agignore
call :proc _vimrc .vimrc
call :proc _gvimrc .gvimrc
exit /b 0


:proc
echo %1
del /F "%HOME%\%1"
mklink /H "%HOME%\%1" "%~dp0%2"
exit /b 0