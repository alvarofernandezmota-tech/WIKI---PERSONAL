#!/usr/bin/env bash
# scripts/ingest/ingest-status.sh
# Muestra cuántos archivos hay en cada zona OCR
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

count(){ ls "$1" 2>/dev/null | grep -v '.gitkeep' | wc -l | tr -d ' '; }

echo "=== Ingest Status ==="
echo "raw/       : $(count "$ROOT/inbox/ocr/raw") archivo(s)"
echo "text/      : $(count "$ROOT/inbox/ocr/text") archivo(s)"
echo "processed/ : $(count "$ROOT/inbox/ocr/processed") archivo(s)"
echo "vector_idx : $(count "$ROOT/tools/vector_index") doc(s) indexados"
echo "drop/      : $(count "$ROOT/inbox/drop") archivo(s)"
