# 🐳 Docker Project — Flask Todo App

## 📌 What App I Chose and Why

I chose a **Python Flask Todo REST API** with a **PostgreSQL** database.

**Why I chose this:**
- Flask is simple and beginner-friendly
- It has a real database connection which makes it a good Docker learning project
- It covers both a backend API and a frontend HTML page
- It shows how two containers (app + database) work together

The app lets you **add, edit, complete and delete todos** from a browser.

## 🐋 Dockerfile (With Comments)
```dockerfile
# ── STAGE 1: Builder ──────────────────────────────────
# Use slim Python image to keep size small
FROM python:3.12-slim AS builder

# Set working directory inside container
WORKDIR /build

# Install system packages needed to compile psycopg2
# gcc = C compiler, libpq-dev = PostgreSQL headers
# rm -rf cleans up apt cache to reduce image size
RUN apt-get update && apt-get install -y gcc libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first (Docker caches this layer)
# So if requirements don't change, pip install is skipped
COPY requirements.txt .

# Install Python packages into /install folder
# --no-cache-dir = don't save pip cache = smaller image
RUN pip install --prefix=/install --no-cache-dir -r requirements.txt


# ── STAGE 2: Runtime ──────────────────────────────────
# Fresh slim image — no build tools, just what we need
FROM python:3.12-slim AS runtime

# Install only the runtime PostgreSQL library (not dev headers)
RUN apt-get update && apt-get install -y libpq5 \
    && rm -rf /var/lib/apt/lists/*

# Copy installed Python packages from builder stage
COPY --from=builder /install /usr/local

# Create a non-root user for security
# Running as root inside containers is a security risk
RUN useradd --uid 1001 --create-home appuser

# Set working directory
WORKDIR /app

# Copy app code and give ownership to appuser
COPY --chown=appuser:appuser . .

# Switch to non-root user
USER appuser

# Tell Docker this container listens on port 5000
EXPOSE 5000

# Start the app with Gunicorn (production server)
# 2 workers = can handle 2 requests at the same time
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "2", "run:app"]
```

---

## ⚙️ Docker Compose
```yaml
version: "3.8"

networks:
  todo-network:
    driver: bridge        # Custom network so app and db can talk

volumes:
  postgres-data:          # Persist database data across restarts

services:

  db:
    image: postgres:13
    container_name: todo-db
    restart: unless-stopped
    environment:
      POSTGRES_DB: ${POSTGRES_DB}
      POSTGRES_USER: ${POSTGRES_USER}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
    volumes:
      - postgres-data:/var/lib/postgresql/data
    networks:
      - todo-network
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER} -d ${POSTGRES_DB}"]
      interval: 10s
      timeout: 5s
      retries: 5

  app:
    build: .
    image: sripadma996/flask-todo-app:latest
    container_name: todo-app
    restart: unless-stopped
    depends_on:
      - db
    environment:
      DATABASE_URL: postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@db:5432/${POSTGRES_DB}
      SECRET_KEY: ${SECRET_KEY}
    ports:
      - "${APP_PORT}:5000"
    networks:
      - todo-network
```

---

## ⚠️ Challenges I Faced and How I Solved Them

### Challenge 1 — `docker compose` command not found
**Error:**
```
unknown flag: --build
```
**Cause:** My server had old docker-compose version 1.29.2

**Fix:** Used `docker-compose` (with hyphen) instead of `docker compose`
```bash
# Instead of this:
docker compose up --build

# I used this:
docker-compose up --build
```

---

### Challenge 2 — ContainerConfig KeyError with postgres:16
**Error:**
```
KeyError: 'ContainerConfig'
```
**Cause:** docker-compose 1.29.2 has a bug with newer PostgreSQL images

**Fix:** Downgraded PostgreSQL image from `postgres:16-alpine` to `postgres:13`
```yaml
# Changed this:
image: postgres:16-alpine

# To this:
image: postgres:13
```

---

### Challenge 3 — App starts before database is ready
**Cause:** Flask app tried to connect to PostgreSQL before it finished starting

**Fix:** Added `depends_on` in docker-compose so app waits for db service
```yaml
depends_on:
  - db
```

---

## 📦 Final Image Size
```bash
docker images sripadma996/flask-todo-app
```

| Image | Tag | Size |
|-------|-----|------|
| sripadma996/flask-todo-app | latest | ~180 MB |

**How I kept it small:**
- Used `python:3.12-slim` instead of full Python image
- Multi-stage build — build tools not included in final image
- `--no-cache-dir` flag in pip install
- `.dockerignore` to exclude unnecessary files

---

## 🔗 Docker Hub Link

👉 **https://hub.docker.com/r/sripadma996/flask-todo-app**
```bash
# Pull the image directly
docker pull sripadma996/flask-todo-app:latest
```

---