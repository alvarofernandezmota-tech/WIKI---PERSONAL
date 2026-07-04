#!/usr/bin/env bash
# scripts/verify/check-structure.sh
# Valida estructura de carpetas y detecta archivos prohibidos en raíz
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
ERRORS=0
warn(){ echo "[WARN] $*"; ERRORS=$((ERRORS+1)); }
ok(){   echo "[OK]   $*"; }

# Carpetas obligatorias
for d in inbox/drop inbox/ocr/raw inbox/ocr/text inbox/ocr/processed \
         inbox/context/perplexity inbox/_meta \
         scripts/ingest scripts/agentes scripts/verify scripts/maintenance \
         tools mcp diarios reports logs; do
  [ -d "$ROOT/$d" ] && ok "$d existe" || warn "$d FALTA"
done

# Archivos prohibidos en raíz (binarios sin extensión)
for f in "$ROOT"/*; do
  name=$(basename "$f")
  [[ "$name" == .* ]] && continue
  [[ "$name" == *.* ]] && continue
  [ -d "$f" ] && continue
  warn "Archivo sin extensión en raíz: $name"
done

# Scripts sin shebang
for s in "$ROOT"/scripts/**/*.sh; do
  [ -f "$s" ] || continue
  head -1 "$s" | grep -q '^#!' || warn "Sin shebang: $s"
done

echo ""
echo "Errores/avisos: $ERRORS"
[ "$ERRORS" -eq 0 ] && exit 0 || exit 1
