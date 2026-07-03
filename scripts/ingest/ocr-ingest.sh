#!/usr/bin/env bash
# scripts/ingest/ocr-ingest.sh — OCR ingestion con metadatos
set -euo pipefail

ROOT="${YGGDRASIL_ROOT:-$(pwd)}"
IN="$1"
ID="$(date +%s)-$(basename "$IN" | sed 's/[^a-zA-Z0-9]/_/g')"
OUTDIR="$ROOT/inbox/ocr/text"
METADIR="$ROOT/inbox/ocr/meta"

mkdir -p "$OUTDIR" "$METADIR"

# OCR con Tesseract (español por defecto)
tesseract "$IN" "$OUTDIR/$ID" -l spa 2>/dev/null || {
  echo "[WARN] tesseract no disponible, copiando raw" >&2
  cp "$IN" "$OUTDIR/$ID.txt" 2>/dev/null || true
}

# Metadatos JSON
cat > "$METADIR/$ID.json" <<EOF
{
  "source": "$IN",
  "id": "$ID",
  "ts": "$(date -Iseconds)",
  "lang": "spa",
  "status": "ingested"
}
EOF

echo "$OUTDIR/$ID.txt"
