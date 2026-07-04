#!/usr/bin/env bash
set -euo pipefail
ROOT="${YGGDRASIL_ROOT:-$(pwd)}"
IN_DIR="$ROOT/inbox/ocr/text"
REPORT_DIR="$ROOT/reports/agent-ocr-auditor"
DRAFT_DIR="$ROOT/reports/drafts"
mkdir -p "$REPORT_DIR" "$DRAFT_DIR"

for f in "$IN_DIR"/*.txt; do
  [ -f "$f" ] || continue
  id=$(basename "$f" .txt)
  out="$REPORT_DIR/$id.md"
  echo "# OCR Audit $id" > "$out"
  echo "" >> "$out"
  echo "## Source" >> "$out"
  echo "\`$f\`" >> "$out"
  echo "" >> "$out"
  echo "## Quick checks" >> "$out"
  wc -w "$f" | awk '{print "- Words: "$1}' >> "$out"
  if grep -qE "[0-9]{8,}" "$f"; then
    echo "- WARN: long numeric sequences detected" >> "$out"
  fi
  python3 "$ROOT/tools/weaviate_adapter.py" index_text "$id" "$f" '{"source":"ocr","agent":"agent-ocr-auditor"}' || true
  draft="$DRAFT_DIR/$id-pr.json"
  jq -n --arg t "ocr-audit/$id" --arg b "Draft PR: fixes suggested by agent-ocr-auditor for $id" \
    '{title:$t,body:$b,changes:[]}' > "$draft"
  echo "$out"
done
