#!/usr/bin/env bash
set -euo pipefail
ROOT="${YGGDRASIL_ROOT:-$(pwd)}"
IN_DIR="$ROOT/inbox/ocr/text"
OUT_DIR="$ROOT/inbox/context/perplexity"
mkdir -p "$OUT_DIR"

for f in "$IN_DIR"/*.txt; do
  [ -f "$f" ] || continue
  id=$(basename "$f" .txt)
  summary=$(head -n 200 "$f" | tr '\n' ' ' | cut -c1-1800)
  prompt="Contextualiza y busca referencias públicas para este extracto: $summary"
  resp=$(bash "$ROOT/scripts/agentes/llm-router.sh" "$prompt" auto 2>/dev/null || true)
  out="$OUT_DIR/$id.md"
  echo "# Perplexity context $id" > "$out"
  echo "" >> "$out"
  echo "$resp" >> "$out"
  echo "$out"
done
