#!/usr/bin/env bash
# agentes/agent-perplexity-informer/run.sh
# Lee archivos de inbox/ocr/text/, los manda a Perplexity y genera .md con PERCENT_COMPLETE.
set -euo pipefail

ROOT="${YGGDRASIL_ROOT:-$(pwd)}"
IN_DIR="$ROOT/inbox/ocr/text"
OUT_DIR="$ROOT/inbox/context/perplexity"
ADAPTER="$ROOT/tools/perplexity_adapter.py"
TEMPLATE="$ROOT/inbox/context/perplexity/PERPLEXITY_PROMPT_TEMPLATE.txt"

mkdir -p "$OUT_DIR"

if [ ! -d "$IN_DIR" ]; then
  echo "[WARN] IN_DIR not found: $IN_DIR"
  exit 0
fi

for f in "$IN_DIR"/*.txt; do
  [ -f "$f" ] || continue
  id=$(basename "$f" .txt)
  summary=$(head -n 200 "$f" | tr '\n' ' ' | cut -c1-1800)
  prompt_file="$OUT_DIR/${id}.prompt.txt"
  out_file="$OUT_DIR/${id}.md"

  cat "$TEMPLATE" > "$prompt_file"
  echo "$summary" >> "$prompt_file"

  resp=$(python3 "$ADAPTER" "$(cat "$prompt_file")" 2>/dev/null || echo '{"error":"adapter failed"}')

  {
    echo "## Perplexity response for $id"
    echo "- Generado: $(date -Iseconds)"
    echo ""
    echo '```json'
    echo "$resp"
    echo '```'
    pct=$(echo "$resp" | grep -Eo "PERCENT_COMPLETE: [0-9]{1,3}%" | head -n1 || true)
    echo ""
    echo "### Extracted"
    echo "- **PERCENT_COMPLETE**: ${pct:-unknown}"
  } > "$out_file"

  echo "[OK] $out_file"
done
