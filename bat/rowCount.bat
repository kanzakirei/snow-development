chcp 65001 > nul
for /f "usebackq delims=" %%A in (`find /c /v "" ^< %2`) do (
  (echo ^[%1/%%A^] Compile %~nx2)
)
