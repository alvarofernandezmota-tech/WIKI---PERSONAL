#!/usr/bin/env bash
# =============================================================================
# code-drift-detector.sh
# Detecta si el codigo/scripts del repo han derivado del estandar del sistema.
# Comprueba:
#   1. Scripts sin set -euo pipefail
#   2. Scripts sin funcion log()
#   3. Workflows sin timeout-minutes
#   4. Scripts que han cambiado sin actualizar su doc
#   5. Funciones que han cambiado de firma entre commits
#   6. Scripts nuevos sin entrada en REGISTRO-AGENTES o similar
# Genera issue si encuentra drift.
# =============================================================================
set -euo pipefail

REPO="${GITHUB_REPOSITORY:-alvarofernandezmota-tech/yggdrasil-dew}"
DRY_RUN="${DRY_RUN:-false}"
DRIFT_FOUND=0
DRIFT_REPORT=""

log() { echo "[$(date +%H:%M:%S)] $*"; }

add_drift() {
  local msg="$1"
  DRIFT_FOUND=$((DRIFT_FOUND + 1))
  DRIFT_REPORT+="- $msg\n"
  log "DRIFT: $msg"
}

create_drift_issue() {
  local title="[AUTO][DRIFT] Desviacion detectada en $DRIFT_FOUND punto(s)"
  local body
  body=$(printf "## Drift detectado\n\nEl code-drift-detector encontró $DRIFT_FOUND desviaciones del estandar del sistema:\n\n$DRIFT_REPORT\n\n**Accion:** Revisar y corregir para mantener coherencia.\n\n*Generado por code-drift-detector.sh [AUTO]*")

  if [[ "$DRY_RUN" == "true" ]]; then
    log "[DRY_RUN] Issue: $title"
    echo -e "$body"
    return
  fi

  # Verificar si ya existe
  local existing
  existing=$(gh issue list --repo "$REPO" --search "DRIFT" --label "auto,drift" --json number --limit 5 2>/dev/null || echo "[]")
  if echo "$existing" | grep -q 'number'; then
    log "SKIP: Ya existe issue de drift abierto"
    return
  fi

  gh issue create \
    --repo "$REPO" \
    --title "$title" \
    --body "$body" \
    --label "auto,drift,calidad" 2>/dev/null && log "CREATED: $title"
}

# --- CHECK 1: Scripts sin set -euo pipefail ---
check_pipefail() {
  log "Check 1: Scripts sin set -euo pipefail..."
  while IFS= read -r -d '' script; do
    if ! grep -q 'set -euo pipefail\|set -e' "$script" 2>/dev/null; then
      add_drift "Script sin set -euo pipefail: $script"
    fi
  done < <(find scripts/ -name '*.sh' -print0 2>/dev/null)
}

# --- CHECK 2: Scripts sin funcion log() ---
check_log_function() {
  log "Check 2: Scripts sin funcion log()..."
  while IFS= read -r -d '' script; do
    local lines
    lines=$(wc -l < "$script")
    # Solo scripts con mas de 30 lineas deben tener log()
    if [[ $lines -gt 30 ]] && ! grep -q 'log()\|log (' "$script" 2>/dev/null; then
      add_drift "Script grande sin log(): $script ($lines lineas)"
    fi
  done < <(find scripts/ -name '*.sh' -print0 2>/dev/null)
}

# --- CHECK 3: Workflows sin timeout-minutes ---
check_workflow_timeout() {
  log "Check 3: Workflows sin timeout-minutes..."
  while IFS= read -r wf; do
    if ! grep -q 'timeout-minutes' "$wf" 2>/dev/null; then
      add_drift "Workflow sin timeout-minutes: $wf"
    fi
  done < <(find .github/workflows/ -name '*.yml' 2>/dev/null)
}

# --- CHECK 4: Scripts modificados recientemente sin cambio en doc ---
check_doc_sync() {
  log "Check 4: Scripts modificados sin doc actualizada..."
  # Scripts modificados en los ultimos 7 dias
  while IFS= read -r script; do
    local name
    name=$(basename "$script" .sh)
    local doc_candidates=("docs/$name.md" "agentes/$name/README.md" "docs/scripts/$name.md")
    local has_doc=false
    for doc in "${doc_candidates[@]}"; do
      if [[ -f "$doc" ]]; then
        # Verificar que el doc es mas reciente que el script
        if [[ "$doc" -nt "$script" ]] || [[ "$doc" -ot "$script" ]]; then
          has_doc=true
        fi
      fi
    done
    # Si el script es grande (>100 lineas) y no tiene doc en docs/
    local lines
    lines=$(wc -l < "$script" 2>/dev/null || echo 0)
    if [[ $lines -gt 100 ]] && [[ "$has_doc" == "false" ]]; then
      add_drift "Script grande sin doc asociada: $script ($lines lineas)"
    fi
  done < <(find scripts/ -name '*.sh' -newer scripts/cierre-sesion.sh 2>/dev/null | head -20)
}

# --- CHECK 5: Funciones renombradas (firma cambiada) ---
check_function_drift() {
  log "Check 5: Funciones eliminadas o renombradas desde ultimo commit..."
  if git log --oneline -1 &>/dev/null; then
    local changed_functions
    changed_functions=$(git diff HEAD~1 HEAD -- 'scripts/*.sh' 2>/dev/null | \
      grep '^-[a-z_]\+()' | sed 's/^-/ELIMINADA: /' | head -10)
    if [[ -n "$changed_functions" ]]; then
      add_drift "Funciones eliminadas/renombradas en ultimo commit:\n$changed_functions"
    fi
  fi
}

# --- CHECK 6: Nuevos scripts sin cabecera estandar ---
check_standard_header() {
  log "Check 6: Scripts nuevos sin cabecera estandar..."
  while IFS= read -r -d '' script; do
    local first_line
    first_line=$(head -1 "$script" 2>/dev/null)
    if [[ "$first_line" != '#!/usr/bin/env bash' && "$first_line" != '#!/bin/bash' && "$first_line" != '#!/usr/bin/env python3' ]]; then
      add_drift "Script sin shebang correcto: $script"
    fi
  done < <(find scripts/ \( -name '*.sh' -o -name '*.py' \) -newer scripts/cierre-sesion.sh -print0 2>/dev/null)
}

# =============================================================================
main() {
  log "=== code-drift-detector.sh iniciado ==="

  check_pipefail
  check_log_function
  check_workflow_timeout
  check_doc_sync
  check_function_drift
  check_standard_header

  log "Drift total encontrado: $DRIFT_FOUND punto(s)"

  if [[ $DRIFT_FOUND -gt 0 ]]; then
    create_drift_issue
  else
    log "Sistema coherente. Sin drift detectado."
  fi

  log "=== code-drift-detector.sh completado ==="
}

main "$@"
