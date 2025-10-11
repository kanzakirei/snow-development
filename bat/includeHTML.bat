chcp 65001 > nul
pushd "../html" > nul
for %%f in (*.html) do (
  call :MainFile %%f ../snow/%%f
)
for %%f in (*.tmp) do (
  del %%f
)
popd > nul
exit /b 0

:MainFile
set InFile=%1
set OutFile=%2
set IncludeFile=include.tmp
type nul>%IncludeFile%
for /f "delims=" %%t in (%InFile%) do (
  echo "%%t" | find "include" > nul
  if not ERRORLEVEL 1 (
    set key=%%t
setlocal enabledelayedexpansion
    set key=!key:^<^!--include =!
    set key=!key:--^>=!
    echo !key!>>%IncludeFile%
endlocal
  ) else (
    goto th
  )
)
:th

call :NeedBuild %InFile% %OutFile% IsNeed
if "%IsNeed%" EQU "0" (
  echo Skip %~nx2
  exit /b 0
)

call :Include
exit /b 0

:NeedBuild
if exist %1 (
  if exist %2 (
    if "%~t1" GTR "%~t2" (
       set %3=1
       exit /b 0
    )
  )
)
for /f "delims=" %%t in (%IncludeFile%) do (
  if exist %%t (
    if "%%~tt" GTR "%~t2" (
       set %3=1
       exit /b 0
    )
  )
)
set %3=0
exit /b 0

:Include
set HeadFile=head.tmp
set HeaderFile=header.tmp
set MainFile=main.tmp
set FooterFile=footer.tmp
set OutTempFile=%~n0.tmp
set SubstringBat=../bat/substring.bat
type nul>%HeadFile%
type nul>%HeaderFile%
type nul>%MainFile%
type nul>%FooterFile%
type nul>%OutTempFile%
for /f "delims=" %%t in (%InFile%) do (
  echo "%%t" | find "include" > nul
  if not ERRORLEVEL 1 (
    set key=%%t
setlocal enabledelayedexpansion
    set key=!key:^<^!--include =!
    set key=!key:--^>=!
    call %SubstringBat% !key! "<head>" "</head>" %HeadFile%
    call %SubstringBat% !key! "<header>" "</header>" %HeaderFile%
    call %SubstringBat% !key! "<main>" "</main>" %MainFile%
    call %SubstringBat% !key! "<footer>" "</footer>" %FooterFile%
endlocal
  ) else (
    (echo.%%t) >> %OutTempFile%
    echo "%%t" | find "<head>" > nul
    if not ERRORLEVEL 1 type %HeadFile%>>%OutTempFile%
    echo "%%t" | find "<header>" > nul
    if not ERRORLEVEL 1 type %HeaderFile%>>%OutTempFile%
    echo "%%t" | find "<main>" > nul
    if not ERRORLEVEL 1 type %MainFile%>>%OutTempFile%
    echo "%%t" | find "<footer>" > nul
    if not ERRORLEVEL 1 type %FooterFile%>>%OutTempFile%
  )
)
type %OutTempFile%>%OutFile%
echo Include %OutFile%
exit /b 0
