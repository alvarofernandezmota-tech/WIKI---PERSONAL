#!/usr/bin/env bash
# scripts/observador-obsidian.sh
# Exporta notas modificadas en las últimas 24h del vault de Obsidian
# a inbox/context/obsidian/ como .md para ingesta por agentes.
set -euo pipefail

ROOT="${YGGDRASIL_ROOT:-$(pwd)}"
VAULT_DIR="${OBSIDIAN_VAULT:-$HOME/ObsidianVault}"
OUT_DIR="$ROOT/inbox/context/obsidian"

mkdir -p "$OUT_DIR"

if [ ! -d "$VAULT_DIR" ]; then
  echo "WARN: OBSIDIAN_VAULT not found at $VAULT_DIR"
  echo "      Set OBSIDIAN_VAULT env var to your vault path."
  exit 0
fi

COUNT=0
find "$VAULT_DIR" -type f -name "*.md" -mtime -1 | while read -r f; do
  id=$(basename "$f" .md | tr ' ' '_' | tr '/' '-')
  excerpt=$(sed -n '1,40p' "$f" | tr '\n' ' ' | cut -c1-1200)
  out="$OUT_DIR/${id}-obsidian.md"
  cat > "$out" <<OBSIDIAN
# Obsidian export: $id

**Source**: $f
**Exported**: $(date -Iseconds)
**Modified**: $(date -r "$f" -Iseconds 2>/dev/null || stat -c %y "$f" 2>/dev/null || echo unknown)

## Excerpt
$excerpt
OBSIDIAN
  COUNT=$((COUNT+1))
done

echo "observador-obsidian: exported $COUNT note(s) to $OUT_DIR"
