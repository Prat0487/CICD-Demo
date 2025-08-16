from fastapi import FastAPI
import os

app = FastAPI(title="DevOps Craft Demo", version="1.0.0")

@app.get("/healthz")
def health():
    return {"status": "ok"}

@app.get("/")
def read_root():
    return {
        "message": "Hello from FastAPI on EKS via GitHub Actions + Helm!",
        "commit_sha": os.getenv("GIT_COMMIT_SHA", "dev"),
        "env": os.getenv("APP_ENV", "dev")
    }
