#!/usr/bin/env bash
# scripts/ingest/ocr-ingest.sh
# Lanza tesseract sobre inbox/ocr/raw/ y guarda texto en inbox/ocr/text/
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
RAW="$ROOT/inbox/ocr/raw"
TEXT="$ROOT/inbox/ocr/text"
PROCESSED="$ROOT/inbox/ocr/processed"
LOG="$ROOT/logs/ingest-$(date +%Y%m%d).log"

mkdir -p "$TEXT" "$PROCESSED" "$(dirname "$LOG")"

log(){ echo "[$(date +%Y-%m-%dT%H:%M:%S)] $*" | tee -a "$LOG"; }

shopt -s nullglob
FILES=("$RAW"/*.{pdf,PDF,png,PNG,jpg,JPG,jpeg,JPEG,tiff,TIFF})

if [ ${#FILES[@]} -eq 0 ]; then
  log "INFO: No hay archivos en $RAW"
  exit 0
fi

for f in "${FILES[@]}"; do
  name="$(basename "$f")"
  base="${name%.*}"
  out="$TEXT/${base}.txt"
  log "OCR: procesando $name"
  if command -v tesseract &>/dev/null; then
    tesseract "$f" "$TEXT/$base" -l spa+eng 2>>/dev/null && log "OK: $out" || log "ERROR: falló OCR en $name"
  else
    log "WARN: tesseract no instalado — copiando como placeholder"
    echo "[OCR_PLACEHOLDER] $name" > "$out"
  fi
  mv "$f" "$PROCESSED/$name"
  log "MOVED: $name -> processed/"
done

log "DONE: $(ls "$TEXT" | wc -l) archivos en text/"
