#!/usr/bin/env bash
# pdf-split.sh
# Doc: docs/  <- COMPLETAR ruta al doc relacionado
# Fase: <- COMPLETAR fase
# Descripción: <- COMPLETAR
# scripts/ingest/pdf-split.sh
# Divide PDFs de inbox/ocr/raw/ en páginas individuales usando pdftk o ghostscript
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
RAW="$ROOT/inbox/ocr/raw"
LOG="$ROOT/logs/ingest-$(date +%Y%m%d).log"

mkdir -p "$(dirname "$LOG")"
log(){ echo "[$(date +%Y-%m-%dT%H:%M:%S)] $*" | tee -a "$LOG"; }

shopt -s nullglob
FILES=("$RAW"/*.{pdf,PDF})

if [ ${#FILES[@]} -eq 0 ]; then
  log "INFO: No hay PDFs en $RAW"
  exit 0
fi

for f in "${FILES[@]}"; do
  name="$(basename "$f")"
  base="${name%.*}"
  outdir="$RAW/${base}_pages"
  mkdir -p "$outdir"
  log "SPLIT: $name"
  if command -v pdftk &>/dev/null; then
    pdftk "$f" burst output "$outdir/${base}_%04d.pdf" && log "OK: pdftk split $name"
  elif command -v gs &>/dev/null; then
    gs -dNOPAUSE -dBATCH -sDEVICE=pngmono -r300 -sOutputFile="$outdir/${base}_%04d.png" "$f" 2>/dev/null && log "OK: gs split $name"
  else
    log "WARN: ni pdftk ni gs disponibles — skip $name"
    continue
  fi
  mv "$f" "$RAW/${base}.original.bak"
done