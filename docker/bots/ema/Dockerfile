# =============================================================================
# EMA — Auditora de código del ecosistema
# Rol: análisis estático, detección código zombie, auditoría calidad
# Integrada como módulo de thdora (no bot independiente)
# Este Dockerfile es para ejecución standalone si se necesita
# =============================================================================
FROM python:3.12-slim

LABEL maintainer="alvarofernandezmota-tech"
LABEL role="code-auditor"
LABEL ecosystem="yggdrasil"
LABEL integration="thdora-module"

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    git curl \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV TELEGRAM_TOKEN=""
ENV TELEGRAM_CHAT_ID=""
ENV GITHUB_TOKEN=""
ENV GROQ_API_KEY=""
ENV AUDIT_TARGET_PATH="/repos"
ENV LOG_LEVEL="INFO"

# Montar repos a auditar
VOLUME ["/repos"]

HEALTHCHECK --interval=60s --timeout=10s --start-period=30s --retries=3 \
    CMD python -c "import sys; sys.exit(0)"

CMD ["python", "main.py"]
