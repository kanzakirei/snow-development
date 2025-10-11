chcp 65001 > nul
set TargetFile=%1
set StartKey=%2
set EndKey=%3
set OutFile=%4
set OutTempFile=%~n0.tmp

if not exist %TargetFile% exit /b 1

set InRange=0
type nul>%OutTempFile%
for /f "delims=" %%i in (%TargetFile%) do (
  echo "%%i" | find %EndKey% > nul
  if not ERRORLEVEL 1 (
setlocal enabledelayedexpansion
    if !InRange! == 0 (
endlocal      del %OutTempFile%
      exit /b 1
    )
    type %OutTempFile%>>%OutFile%
    del %OutTempFile%
    exit /b 0
  )
setlocal enabledelayedexpansion
  if !InRange! == 1 (
endlocal
    echo.%%i>>%OutTempFile%
  )
  echo "%%i" | find %StartKey% > nul
  if not ERRORLEVEL 1 (
    set InRange=1
  )
)

setlocal enabledelayedexpansion
if !InRange! == 0 (
endlocal
  del %OutTempFile%
  exit /b 1
)
type %OutTempFile%>>%OutFile%
del %OutTempFile%
exit /b 0