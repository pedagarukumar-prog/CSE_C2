# StoryVox — HOW TO RUN

Follow these steps exactly. You only need **one** method (A, B, or C).

## 1. Prerequisites

- **Python 3.11 or newer** (Method A and C). Download: https://www.python.org/downloads/
- **Git** is not required (you already have the StoryVox folder).
- **Docker Desktop** is required only for Method B. Download: https://www.docker.com/products/docker-desktop/
- **Disk/RAM:** at least 8 GB free disk (model weights download on first run) and 8 GB RAM recommended. CPU-only machines work but are slower.
- **Internet:** required on the first run to download story/voice models and Python packages. Later runs work offline with cached models.

Check Python (open Command Prompt or PowerShell and run):

```text
python --version
```

You should see something like `Python 3.11.x`. If not, install Python and tick “Add python.exe to PATH” during setup.

## 2. Method A — Automatic (recommended)

For someone with zero coding knowledge.

1. Open the **StoryVox** folder (the one containing `run.bat`).
2. **Double-click `run.bat`**. A black command window opens — this is the StoryVox server. Keep it open.
3. The script creates a `.venv` folder (first time only), installs packages, then starts the server. The **first run downloads ML models**, so it can take 10–30+ minutes depending on internet speed. Later runs are fast.
4. When you see a line like `Uvicorn running on http://127.0.0.1:8000`, the app is ready.
5. Your browser should open automatically to **http://localhost:8000**. If not, type that address manually.
6. To use StoryVox: enter a story idea, pick a language, press **Generate Story**, then play/download the narration.
7. To stop: press **Ctrl+C** in the command window, or just close the window.

## 3. Method B — Docker

Recommended if Docker Desktop is installed. Open a terminal in the StoryVox folder and copy-paste:

```bash
docker build -t storyvox:latest .
docker run --rm -p 127.0.0.1:8000:8000 -v "%cd%/data:/app/data" storyvox:latest
```

(On macOS/Linux use `$(pwd)/data:/app/data` instead of `%cd%/data:/app/data`.)

Then open **http://localhost:8000**.

Stop the container with **Ctrl+C**. Alternatively double-click `run-docker.bat`, which does the same build + run steps and pauses so you can read errors.

## 4. Method C — Manual

Exact copy-paste commands. Open a terminal **in the StoryVox folder**.

Windows (PowerShell):

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
python -m uvicorn app.main:app --host 127.0.0.1 --port 8000
```

Windows (Command Prompt):

```bat
python -m venv .venv
.venv\Scripts\activate.bat
pip install -r requirements.txt
python -m uvicorn app.main:app --host 127.0.0.1 --port 8000
```

macOS / Linux:

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python -m uvicorn app.main:app --host 127.0.0.1 --port 8000
```

Then open **http://localhost:8000** in your browser. Stop with **Ctrl+C**.

## 5. Troubleshooting

- **“Python not found” / `python` not recognized:** install Python from https://www.python.org/downloads/ and tick “Add python.exe to PATH”. Close and reopen the terminal, then run `python --version`.
- **Windows Defender / SmartScreen blocks `run.bat`:** click **More info → Run anyway**. The file is a plain text launcher; right-click → Edit to inspect it.
- **Port already in use (8000):** another program uses the port. Stop it, or start on a different port: `python -m uvicorn app.main:app --host 127.0.0.1 --port 8001` and open `http://localhost:8001`.
- **Browser did not open automatically:** manually visit **http://localhost:8000**.
- **Dependency install fails:** update pip (`python -m pip install --upgrade pip`), check internet/VPN, then retry `pip install -r requirements.txt`. Delete `.venv` and retry if the environment is corrupted.
- **Model download fails / slow:** check internet and disk space; rerun — Hugging Face downloads resume from cache. CPU-only users can keep the default small `Qwen/Qwen3-0.6B` model.
- **Insufficient RAM / process killed:** close other apps, use Short length, avoid running evaluation and generation at the same time.
- **CUDA/GPU unavailable:** normal on most laptops — StoryVox runs on CPU automatically (slower). No action needed.
- **“Narration could not be generated”:** the speech checkpoint may still be downloading; wait a minute and retry. Check the server window for the exact error.
- **Missing audio files:** if a WAV was manually deleted, History shows “no audio” — regenerate narration from the story page.
