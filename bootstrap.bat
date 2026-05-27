@echo off
REM Bootstrap LWPT.
REM
REM One-time per fresh clone (or after `lwpt build --clean`). Produces
REM build\lwpt.exe, after which `build\lwpt build` is the canonical
REM build entry point.
REM
REM Prefers scripts\bootstrap.pas via InstantFPC; falls back to a
REM direct fpc invocation when InstantFPC is unavailable. Both code
REM paths invoke fpc with the same -Fu / -Fi paths for source\ and
REM every workspace package under packages\<name>\source\ (currently:
REM httpclient, cli, semver, toml, testing).

setlocal
cd /d "%~dp0"

where instantfpc >nul 2>nul
if %ERRORLEVEL% EQU 0 (
  instantfpc scripts\bootstrap.pas %*
  exit /b %ERRORLEVEL%
)

echo bootstrap.bat: instantfpc not found; falling back to direct fpc 1>&2
if not exist build mkdir build
fpc ^
  -Mdelphi -Sh ^
  -O- -gw -godwarfsets -gl ^
  -Ct -Cr -Sa ^
  -FEbuild ^
  -Fusource ^
  -Fisource ^
  -Fupackages\httpclient\source ^
  -Fipackages\httpclient\source ^
  -Fupackages\cli\source ^
  -Fipackages\cli\source ^
  -Fupackages\semver\source ^
  -Fipackages\semver\source ^
  -Fupackages\toml\source ^
  -Fipackages\toml\source ^
  -Fupackages\testing\source ^
  -Fipackages\testing\source ^
  -obuild\lwpt.exe ^
  source\lwpt.pas
if %ERRORLEVEL% NEQ 0 exit /b %ERRORLEVEL%
echo bootstrap complete: build\lwpt.exe
endlocal
