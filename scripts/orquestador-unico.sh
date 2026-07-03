#!/usr/bin/env bash
# orquestador-unico.sh
# Doc: docs/  <- COMPLETAR ruta al doc relacionado
# Fase: <- COMPLETAR fase
# Descripción: <- COMPLETAR
# ============================================================
# ARCHIVO      : orquestador-unico.sh
# VERSIÓN      : 1.0.0
# FUNCIÓN ÚNICA: Punto de entrada único para ejecutar todos
#                los agentes/scripts del ecosistema en orden
#                correcto y sin solapamientos.
#                Sustituye a: orquestador-supremo, orquestador-
#                total, autonomous-cron (en local).
# AUTOR        : alvarofernandezmota-tech
# USO          : bash scripts/orquestador-unico.sh [fase]
#                fases: all | audit | inbox | session | health
# SALIDA       : inbox/_meta/orquestador-YYYYMMDD.md
# ============================================================

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
FASE="${1:-all}"
STAMP=$(date "+%Y%m%dT%H%M%S")
REPORT="$REPO_ROOT/inbox/_meta/orquestador-${STAMP}.md"
ERRORS=0

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

log() { echo -e "${CYAN}[orquestador]${RESET} $1"; }
ok()  { echo -e "${GREEN}✓${RESET} $1"; }
fail(){ echo -e "${RED}✗${RESET} $1"; ((ERRORS++)) || true; }
warn(){ echo -e "${YELLOW}⚠${RESET} $1"; }

run_script() {
  local script="$1"
  local desc="$2"
  if [ -f "$REPO_ROOT/scripts/$script" ]; then
    log "Ejecutando: $script — $desc"
    if bash "$REPO_ROOT/scripts/$script" 2>&1; then
      ok "$script completado"
      echo "- ✓ $script — $desc" >> "$REPORT"
    else
      fail "$script falló"
      echo "- ✗ $script — $desc (FALLÓ)" >> "$REPORT"
    fi
  else
    warn "$script no existe — saltando"
    echo "- ⚠ $script — no encontrado" >> "$REPORT"
  fi
}

echo -e "${CYAN}${BOLD}================================================${RESET}"
echo -e "${CYAN}${BOLD}  ORQUESTADOR ÚNICO — yggdrasil-dew            ${RESET}"
echo -e "${CYAN}${BOLD}  Fase: ${FASE}${RESET}"
echo -e "${CYAN}${BOLD}================================================${RESET}"

mkdir -p "$REPO_ROOT/inbox/_meta"

cat > "$REPORT" << EOF
# Orquestador Único — ${STAMP}
> Fase: ${FASE}

## Scripts ejecutados

EOF

# FASE: AUDIT — verificar estructura
if [[ "$FASE" == "all" || "$FASE" == "audit" ]]; then
  echo ""
  log "=== FASE AUDIT ==="
  run_script "file-arrival-guardian.sh"    "Verifica archivos en sitio correcto"
  run_script "struct-auditor.sh"            "Audita estructura de carpetas"
  run_script "ghost-file-detector.sh"       "Detecta archivos fantasma"
  run_script "cross-ref-checker.sh"         "Verifica referencias cruzadas"
fi

# FASE: INBOX — clasificar entradas
if [[ "$FASE" == "all" || "$FASE" == "inbox" ]]; then
  echo ""
  log "=== FASE INBOX ==="
  run_script "gestor-estados-inbox.sh"      "Gestiona estados de inbox"
fi

# FASE: HEALTH — salud del sistema
if [[ "$FASE" == "all" || "$FASE" == "health" ]]; then
  echo ""
  log "=== FASE HEALTH ==="
  run_script "repo-research.sh"             "Investiga estado del repo"
fi

# RESUMEN
echo ""
echo -e "${BOLD}================================================${RESET}"
if [ "$ERRORS" -eq 0 ]; then
  echo -e "${GREEN}${BOLD}✅ Orquestador completado sin errores${RESET}"
else
  echo -e "${RED}${BOLD}✗ $ERRORS scripts fallaron — ver reporte${RESET}"
fi
echo -e "Reporte: $REPORT"

cat >> "$REPORT" << EOF

## Resultado
- Errores: ${ERRORS}
- Timestamp cierre: $(date '+%Y-%m-%d %H:%M:%S')
EOF

exit $ERRORS