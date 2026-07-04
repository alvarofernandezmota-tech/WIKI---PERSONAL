#!/usr/bin/env bash
# agentes/agent-perplexity-informer/run.sh
# Lee textos de inbox/ocr/text/, construye prompt, llama a Perplexity
# y escribe resultados en inbox/context/perplexity/
set -euo pipefail

ROOT="${YGGDRASIL_ROOT:-$(pwd)}"
IN_DIR="$ROOT/inbox/ocr/text"
OUT_DIR="$ROOT/inbox/context/perplexity"
ADAPTER="$ROOT/tools/perplexity_adapter.py"
TEMPLATE="$OUT_DIR/PERPLEXITY_PROMPT_TEMPLATE.txt"

mkdir -p "$OUT_DIR"

if [ ! -f "$ADAPTER" ]; then
  echo "ERROR: adapter not found at $ADAPTER"
  exit 1
fi

COUNT=0
for f in "$IN_DIR"/*.txt; do
  [ -f "$f" ] || continue
  id=$(basename "$f" .txt)
  summary=$(head -n 200 "$f" | tr '\n' ' ' | cut -c1-1800)
  prompt_file="$OUT_DIR/${id}.prompt.txt"
  out_file="$OUT_DIR/${id}.md"

  # Build prompt
  if [ -f "$TEMPLATE" ]; then
    cat "$TEMPLATE" > "$prompt_file"
  else
    cat > "$prompt_file" <<'PROMPT'
Analiza este extracto y devuelve:
1) Resumen breve (máx. 120 palabras).
2) Tres acciones prioritarias, numeradas.
3) PERCENT_COMPLETE: XX% (entero, 0-100).
4) Referencias públicas o links relevantes.
CONFIDENCE_REASON: <breve justificación>

Texto:
PROMPT
  fi
  echo "$summary" >> "$prompt_file"

  # Call adapter
  resp=$(python3 "$ADAPTER" "$(cat "$prompt_file")" 2>/dev/null \
    || echo '{"error":"adapter failed or PERPLEXITY_URL not set"}')

  # Write output
  cat > "$out_file" <<MD
## Perplexity — $id

**Timestamp**: $(date -Iseconds)
**Source**: $f

### Raw response
\`\`\`json
$resp
\`\`\`

### Extracted
- **PERCENT_COMPLETE**: $(echo "$resp" | grep -Eo "PERCENT_COMPLETE: [0-9]{1,3}%" | head -n1 || echo "unknown")
MD

  echo "  → $out_file"
  COUNT=$((COUNT+1))
done

echo "agent-perplexity-informer: processed $COUNT file(s)"
