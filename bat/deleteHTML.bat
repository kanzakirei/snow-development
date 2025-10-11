chcp 65001 > nul
pushd "../live" > nul
for %%f in (*.html) do (
  call :Check ../html/%%f
)
popd > nul
exit /b 0

:Check
if not exist "%1" (
  call :Delete %~nx1
)
exit /b 0

:Delete
echo Delete %1
del %1
exit /b 0