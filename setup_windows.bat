@echo off
REM
REM Windowsの環境設定
REM
setlocal
set HOME=%HOMEDRIVE%%HOMEPATH%

echo agignore
mklink /H "%HOME%\.agignore" "%~dp0.agignore"
echo .vimrc
mklink /H "%HOME%\_vimrc" "%~dp0.vimrc"