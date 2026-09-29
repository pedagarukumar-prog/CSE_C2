"""StoryVox FastAPI application entrypoint."""
from __future__ import annotations

import logging
from pathlib import Path

from fastapi import FastAPI
from fastapi.responses import FileResponse
from fastapi.staticfiles import StaticFiles

from app.api.routes import router
from app.config import BASE_DIR
from app.database import init_db

logging.basicConfig(level=logging.INFO, format="%(asctime)s [%(name)s] %(levelname)s: %(message)s")
logger = logging.getLogger("storyvox")

FRONTEND_DIR = BASE_DIR / "frontend"


def create_app() -> FastAPI:
    init_db()
    application = FastAPI(title="StoryVox", version="1.0.0",
                          description="StoryVox - multilingual AI storytelling with natural speech narration.")
    application.include_router(router)

    if FRONTEND_DIR.exists():
        application.mount("/static", StaticFiles(directory=str(FRONTEND_DIR)), name="static")

    @application.get("/", include_in_schema=False)
    def index():
        page = FRONTEND_DIR / "index.html"
        if page.exists():
            return FileResponse(str(page), media_type="text/html")
        return {"app": "StoryVox", "docs": "/docs"}

    logger.info("StoryVox ready. Frontend: %s", FRONTEND_DIR)
    return application


app = create_app()
