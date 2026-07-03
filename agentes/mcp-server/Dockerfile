# MCP Server — Madre Ecosystem
# Gen-3: SSE transport, OAuth2 scopes, OTel traces, dry-run middleware

FROM python:3.12-slim

LABEL maintainer="alvarofernandezmota-tech"
LABEL description="Yggdrasil MCP Server — herramientas del ecosistema para IAs"
LABEL version="3.0.0"

WORKDIR /app

# Dependencias del sistema (Docker CLI para check_docker)
RUN apt-get update && apt-get install -y \
    curl \
    docker.io \
    && rm -rf /var/lib/apt/lists/*

# Python deps
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Código
COPY . .

# Crear directorios de log y config
RUN mkdir -p /srv/logs/mcp-audit /srv/logs/health-agent

# Variables de entorno (sobrescribir en docker-compose)
ENV MCP_PORT=8765
ENV MCP_HOST=0.0.0.0
ENV MCP_TOKEN=changeme
ENV OLLAMA_URL=http://host.docker.internal:11434
ENV QDRANT_URL=http://host.docker.internal:6333
ENV GITHUB_TOKEN=
ENV TELEGRAM_BOT_TOKEN=
ENV TELEGRAM_CHAT_ID=
ENV YGGDRASIL_DEW_PATH=/srv/yggdrasil-dew
ENV DRY_RUN_DEFAULT=true
ENV LOG_LEVEL=INFO
ENV OTEL_EXPORTER_OTLP_ENDPOINT=http://host.docker.internal:4317

EXPOSE 8765

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8765/health || exit 1

CMD ["python", "-m", "uvicorn", "mcp_server_v2:app", "--host", "0.0.0.0", "--port", "8765", "--log-level", "info"]
