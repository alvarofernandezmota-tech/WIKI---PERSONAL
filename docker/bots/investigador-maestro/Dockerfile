# =============================================================================
# INVESTIGADOR MAESTRO — Bot OSINT automatizado
# Rol: búsquedas OSINT, recon, análisis de objetivos
# Puerto: 8091 (API interna)
# =============================================================================
FROM python:3.12-slim

LABEL maintainer="alvarofernandezmota-tech"
LABEL role="osint-investigador"
LABEL ecosystem="yggdrasil"

WORKDIR /app

# Dependencias del sistema
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl wget git nmap dnsutils whois \
    && rm -rf /var/lib/apt/lists/*

# Dependencias Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Variables de entorno requeridas
ENV TELEGRAM_TOKEN=""
ENV TELEGRAM_CHAT_ID=""
ENV SPIDERFOOT_URL="http://spiderfoot:5001"
ENV LOG_LEVEL="INFO"

EXPOSE 8091

HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:8091/health || exit 1

CMD ["python", "main.py"]
