# syntax=docker/dockerfile:1
FROM python:3.12-slim

# Security best practices
ENV PYTHONDONTWRITEBYTECODE=1     PYTHONUNBUFFERED=1     PIP_NO_CACHE_DIR=1

RUN useradd -m appuser

WORKDIR /app
COPY requirements.txt /app/requirements.txt

RUN --mount=type=cache,target=/root/.cache/pip     pip install -r /app/requirements.txt

COPY . /app

# Drop privileges
USER appuser

EXPOSE 8080
ENV PORT=8080
ENV APP_ENV=dev

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
