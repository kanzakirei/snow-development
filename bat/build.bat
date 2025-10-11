@echo off
chcp 65001 > nul
cd %~dp0

call createHTML.bat
if %errorlevel% neq 0 (
  echo Failure: createPostHTML.bat
  exit /b %errorlevel%
)

call includeHTML.bat
if %errorlevel% neq 0 (
  echo Failure: includeHTML.bat
  exit /b %errorlevel%
)

call deleteHTML.bat
if %errorlevel% neq 0 (
  echo Failure: deleteHTML.bat
  exit /b %errorlevel%
)

rem call convertAVIF.bat
if %errorlevel% neq 0 (
  echo Failure: convertAVIF.bat
  exit /b %errorlevel%
)
exit /b %errorlevel%
