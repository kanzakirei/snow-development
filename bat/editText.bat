chcp 65001 > nul
set Type=%1
shift
goto %Type%
exit /b 1

:Insert
set InportFile="%~1"
set KeyString="%~2"
set InsertFile="%~3"
set ExportFile="%~4"
if not exist %InportFile% (
  echo Inport file ^(%%1^) not exist.
  exit /b 1
)
if %KeyString%=="" (
  echo Search key ^(%%2^) is empty.
  exit /b 1
)
if not exist %InsertFile% (
  echo Insert file ^(%%3^) not exist.
  exit /b 1
)
if %ExportFile%=="" (
  echo Export file ^(%%4^) not exist.
  echo Export into import file.
  set ExportFile=%InportFile%
)
(
  for /f "tokens=1* delims=: eol=" %%x in ('findstr /n "^" %InportFile%') do (
    (echo.%%y)
    (echo "%%y") | find %KeyString% > nul
    if not ERRORLEVEL 1 (
      type %InsertFile%
      (echo.)
    )
  )
) > %ExportFile%
exit /b 0

:Replace
set InportFile="%~1"
set BeforeString=%~2
set AfterString=%~3
set ExportFile="%~4"
if not exist %InportFile% (
  echo Inport file ^(%%1^) not exist.
  exit /b 1
)
if "%BeforeString%"=="" (
  echo Before string ^(%%2^) is empty.
  exit /b 1
)
if "%AfterString%"=="" (
  echo After string ^(%%3^) is empty.
  exit /b 1
)
if %ExportFile%=="" (
  echo Export file ^(%%4^) not exist.
  echo Export into import file.
  set ExportFile=%InportFile%
)
(
  setlocal enabledelayedexpansion
  for /f "tokens=1* delims=: eol=" %%x in ('findstr /n "^" %InportFile%') do (
    set line=%%y
    set line=!line:%BeforeString%=%AfterString%!
    (echo.!line!)
  )
  endlocal
) > %ExportFile%
exit /b 0

