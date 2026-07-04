#!/usr/bin/env bash
# validate-workflows.sh
# Doc: docs/  <- COMPLETAR ruta al doc relacionado
# Fase: <- COMPLETAR fase
# Descripción: <- COMPLETAR
# scripts/verify/validate-workflows.sh
# Detecta workflows con git push / git commit directo (escritores peligrosos)
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
WF_DIR="$ROOT/.github/workflows"
ERRORS=0

echo "=== Validando workflows en $WF_DIR ==="

for f in "$WF_DIR"/*.yml "$WF_DIR"/*.yaml; do
  [ -f "$f" ] || continue
  name=$(basename "$f")
  hits=$(grep -nE 'git push|git commit|git add' "$f" 2>/dev/null || true)
  if [ -n "$hits" ]; then
    echo "[WARN] $name tiene operaciones git directas:"
    echo "$hits" | sed 's/^/       /'
    ERRORS=$((ERRORS+1))
  else
    echo "[OK]   $name"
  fi
done

echo ""
echo "Workflows con escrituras directas: $ERRORS"
[ "$ERRORS" -eq 0 ] && exit 0 || exit 1