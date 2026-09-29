@echo off
setlocal EnableExtensions
REM StoryVox automatic launcher (recommended for Windows, no coding knowledge required).
cd /d "%~dp0"
set PORT=8000
if defined PORT_OVERRIDE set PORT=%PORT_OVERRIDE%

echo ============================================================
echo  StoryVox - starting the storytelling app
echo ============================================================
echo  This window is the StoryVox server. Please keep it open
echo  while you use the app. First run may take a while because
echo  story and voice models are downloaded once.
echo.

where python >nul 2>nul
if errorlevel 1 (
  echo [ERROR] Python was not found on PATH.
  echo Please install Python 3.11 or newer from https://www.python.org/downloads/
  echo Then double-click run.bat again.
  pause
  exit /b 1
)

if not exist ".venv\Scripts\python.exe" (
  echo Creating the StoryVox virtual environment...
  python -m venv .venv
  if errorlevel 1 (
    echo [ERROR] Could not create the virtual environment. See the error above.
    pause
    exit /b 1
  )
)

call ".venv\Scripts\activate.bat"
if errorlevel 1 (
  echo [ERROR] Could not activate the virtual environment.
  pause
  exit /b 1
)

echo Installing StoryVox dependencies (this may take several minutes)...
python -m pip install --upgrade pip
if errorlevel 1 (
  echo [WARNING] pip upgrade failed, continuing with dependency install...
)
pip install -r requirements.txt
if errorlevel 1 (
  echo [ERROR] Dependency installation failed. See the error above.
  echo Try: pip install -r requirements.txt
  pause
  exit /b 1
)

echo.
echo Starting StoryVox on http://localhost:%PORT% ...
start "" "http://localhost:%PORT%"
python -m uvicorn app.main:app --host 127.0.0.1 --port %PORT%
set EXITCODE=%errorlevel%
echo.
echo StoryVox stopped (exit code %EXITCODE%). You can close this window.
pause
exit /b %EXITCODE%
