#!/usr/bin/env bash
# scripts/ingest/ocr-worker-loop.sh
# Daemon: vigila inbox/ocr/raw/ cada 30s y lanza ocr-ingest.sh si hay archivos
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
INGEST="$ROOT/scripts/ingest/ocr-ingest.sh"
RAW="$ROOT/inbox/ocr/raw"
LOG="$ROOT/logs/ingest-$(date +%Y%m%d).log"
INTERVAL="${OCR_INTERVAL:-30}"

mkdir -p "$(dirname "$LOG")"
log(){ echo "[$(date +%Y-%m-%dT%H:%M:%S)] $*" | tee -a "$LOG"; }

log "WORKER: arrancando, intervalo=${INTERVAL}s, vigilando $RAW"
trap 'log "WORKER: detenido"; exit 0' SIGTERM SIGINT

while true; do
  shopt -s nullglob
  FILES=("$RAW"/*.{pdf,PDF,png,PNG,jpg,JPG,jpeg,JPEG,tiff,TIFF})
  if [ ${#FILES[@]} -gt 0 ]; then
    log "WORKER: ${#FILES[@]} archivo(s) detectados, lanzando ingest"
    bash "$INGEST" || log "ERROR: ingest falló"
  fi
  sleep "$INTERVAL"
done
