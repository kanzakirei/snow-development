chcp 65001 > nul
pushd "../html/texts" > nul
for %%f in (*.txt) do (
  call :Path %%f
)
for %%f in (*.tmp) do (
  del %%f
)
popd > nul
exit /b 0

:Path
call :MainFile %1 ../%~n1.html
exit /b 0

:MainFile
set BaseHTML=../library/postBase.html
if exist %1 (
  if exist %2 (
    if "%~t2" GTR "%BaseHTML%" (
      if "%~t2" GTR "%~t1" (
        echo Skip %~nx2
        exit /b 0
      )
    )
  )
)
set InDir=%1
set OutDir=%2
call :PostFile %InDir%

type nul>%OutDir%
for /f "delims=" %%t in (%BaseHTML%) do (
  (echo.%%t) >> %OutDir%
  echo "%%t" | find "<main>" > nul
  if not ERRORLEVEL 1 type main.tmp>>%OutDir%
)
echo Create %~nx2
exit /b 0

:PostFile
type nul>main.tmp
(echo.      ^<div class="content"^>) >> main.tmp
(echo.        ^<br^>^<br^>) >> main.tmp
for /f "tokens=1* delims=: eol=" %%x in ('findstr /n "^" %1') do (
  (echo.        ^<p^>%%y^<br^>^</p^>) >> main.tmp
)
(echo.        ^<br^>^<br^>) >> main.tmp
(echo.      ^</div^>) >> main.tmp
exit /b 0
