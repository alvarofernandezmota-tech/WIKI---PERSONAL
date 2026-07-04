#!/usr/bin/env bash
# scripts/observador-obsidian.sh
# Exporta notas de Obsidian modificadas en las ultimas 24h a inbox/context/obsidian/.
# ENV: OBSIDIAN_VAULT (por defecto ~/ObsidianVault)
set -euo pipefail

ROOT="${YGGDRASIL_ROOT:-$(pwd)}"
VAULT_DIR="${OBSIDIAN_VAULT:-$HOME/ObsidianVault}"
OUT_DIR="$ROOT/inbox/context/obsidian"
mkdir -p "$OUT_DIR"

if [ ! -d "$VAULT_DIR" ]; then
  echo "[obsidian] VAULT_DIR not found: $VAULT_DIR — skipping."
  exit 0
fi

count=0
find "$VAULT_DIR" -type f -name "*.md" -mtime -1 | while read -r f; do
  id=$(basename "$f" .md | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
  excerpt=$(sed -n '1,40p' "$f" | tr '\n' ' ' | cut -c1-1200)
  out="$OUT_DIR/${id}-obsidian.md"
  {
    echo "# Obsidian export: $id"
    echo "- Fuente: $f"
    echo "- Exportado: $(date -Iseconds)"
    echo ""
    echo "## Excerpt"
    echo "$excerpt"
  } > "$out"
  echo "[obsidian] Exported: $out"
  count=$((count+1))
done

echo "[obsidian] Done."
