FROM python:3.11-slim
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1 PIP_NO_CACHE_DIR=1
WORKDIR /app
RUN apt-get update && apt-get install -y --no-install-recommends libsndfile1 ffmpeg espeak-ng && rm -rf /var/lib/apt/lists/*
COPY requirements.txt ./
RUN pip install --upgrade pip && pip install -r requirements.txt
COPY . .
RUN mkdir -p data/audio data/datasets data/evaluations
EXPOSE 8000
CMD ["python", "-m", "uvicorn", "app.main:app", "--host", "127.0.0.1", "--port", "8000"]
