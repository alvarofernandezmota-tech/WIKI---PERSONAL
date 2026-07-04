FROM python:3.11-slim
RUN apt-get update && apt-get install -y bash git curl jq && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt 2>/dev/null || true
COPY . ./
ENV YGGDRASIL_ROOT=/app
CMD ["bash", "scripts/maintenance/master_run.sh", "--apply"]
