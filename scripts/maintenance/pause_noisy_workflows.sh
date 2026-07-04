#!/usr/bin/env bash
# scripts/maintenance/pause_noisy_workflows.sh
# Detecta y opcionalmente deshabilita workflows que hacen git push/commit directo
# Uso: bash pause_noisy_workflows.sh [--apply]
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
WF_DIR="$ROOT/.github/workflows"
TS="$(date +%Y%m%d-%H%M%S)"
OUT="$ROOT/reports/maintenance/pause-workflows-$TS.md"
APPLY="${1:-}"

mkdir -p "$ROOT/reports/maintenance"
echo "# Pause Noisy Workflows — $TS" > "$OUT"
echo "Modo: ${APPLY:-dry-run}" >> "$OUT"
echo "" >> "$OUT"

NOISY=()
for f in "$WF_DIR"/*.yml "$WF_DIR"/*.yaml; do
  [ -f "$f" ] || continue
  name=$(basename "$f")
  if grep -qE 'git push|git commit' "$f" 2>/dev/null; then
    NOISY+=("$f")
    echo "- [NOISY] $name" >> "$OUT"
    grep -nE 'git push|git commit' "$f" | sed 's/^/  /' >> "$OUT"
  else
    echo "- [OK] $name" >> "$OUT"
  fi
done

echo "" >> "$OUT"
echo "Workflows ruidosos detectados: ${#NOISY[@]}" >> "$OUT"

if [ "$APPLY" = "--apply" ] && [ ${#NOISY[@]} -gt 0 ]; then
  if command -v gh &>/dev/null; then
    for f in "${NOISY[@]}"; do
      wf_name=$(basename "$f")
      echo "Deshabilitando: $wf_name"
      gh workflow disable "$wf_name" && echo "  OK: deshabilitado" || echo "  WARN: falló"
    done
  else
    echo "WARN: gh CLI no disponible. Deshabilitar manualmente en GitHub Actions." >> "$OUT"
  fi
fi

echo "Reporte guardado en: $OUT"
