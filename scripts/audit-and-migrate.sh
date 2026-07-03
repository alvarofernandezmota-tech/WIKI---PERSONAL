#!/usr/bin/env bash
# =============================================================================
# audit-and-migrate.sh — Script maestro de auditoría y migración del ecosistema
# Yggdrasil Dew · 2026-07-03
# Uso: bash scripts/audit-and-migrate.sh [--dry-run]
# =============================================================================

set -euo pipefail

DRY_RUN=false
[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=true

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || echo /srv/yggdrasil-dew)"
DATE=$(date +%Y-%m-%d)
LOG_FILE="$REPO_ROOT/logs/audit-migrate-$DATE.log"

mkdir -p "$REPO_ROOT/logs"
mkdir -p "$REPO_ROOT/scripts/archive"

# ——————————————————————————————————————————————————————————————————————————
log() { echo "[$(date +%H:%M:%S)] $*" | tee -a "$LOG_FILE"; }
run() {
  if [[ "$DRY_RUN" == true ]]; then
    log "[DRY-RUN] $*"
  else
    log "[RUN] $*"
    eval "$*" 2>&1 | tee -a "$LOG_FILE" || true
  fi
}

log "====================================================="
log " AUDIT & MIGRATE — Yggdrasil Dew · $DATE"
log " DRY_RUN=$DRY_RUN"
log "====================================================="

# =============================================================================
# PASO 1: AUDITORÍA DE SCRIPTS — listar todo
# =============================================================================
log ""
log "[PASO 1] Inventario de scripts..."
find "$REPO_ROOT/scripts" -name "*.sh" -o -name "*.py" | sort | while read -r f; do
  size=$(wc -l < "$f" 2>/dev/null || echo "?")
  log "  ${f#$REPO_ROOT/} ($size líneas)"
done

# =============================================================================
# PASO 2: ARCHIVAR SCRIPTS OBSOLETOS
# =============================================================================
log ""
log "[PASO 2] Archivando scripts obsoletos..."

OBSOLETOS=(
  "scripts/inbox-cleanup-jun2024.sh"
  "scripts/migrar-inbox.sh"
)

for script in "${OBSOLETOS[@]}"; do
  full="$REPO_ROOT/$script"
  if [[ -f "$full" ]]; then
    run "mv '$full' '$REPO_ROOT/scripts/archive/'"
    log "  Archivado: $script"
  else
    log "  Ya no existe: $script (OK)"
  fi
done

# =============================================================================
# PASO 3: AUDITORÍA DE INBOX — contar y clasificar
# =============================================================================
log ""
log "[PASO 3] Auditando inbox..."
INBOX_DIR="$REPO_ROOT/inbox"

if [[ -d "$INBOX_DIR" ]]; then
  total=$(find "$INBOX_DIR" -name "*.md" | wc -l)
  pending=$(grep -rl 'status: pending' "$INBOX_DIR" 2>/dev/null | wc -l || echo 0)
  done_count=$(grep -rl 'status: done' "$INBOX_DIR" 2>/dev/null | wc -l || echo 0)
  log "  Total entradas inbox: $total"
  log "  Pendientes: $pending"
  log "  Completadas: $done_count"

  log "  — Listado por fecha:"
  find "$INBOX_DIR" -name "*.md" | sort | while read -r f; do
    status=$(grep 'status:' "$f" 2>/dev/null | head -1 | awk '{print $2}' || echo "unknown")
    log "    ${f#$INBOX_DIR/} [$status]"
  done
else
  log "  ⚠ï¸ inbox/ no existe. Creándolo..."
  run "mkdir -p '$INBOX_DIR'"
fi

# =============================================================================
# PASO 4: VERIFICAR ESTRUCTURA DE ISLAS
# =============================================================================
log ""
log "[PASO 4] Verificando estructura de islas..."

ISLAS=(
  "agentes/mcp-server"
  "agentes/health-agent"
  "agentes/ecosystem-snapshot"
  "scripts/seguridad"
  "scripts/osint"
  "scripts/backup"
  "scripts/infra"
  "scripts/setup"
  "scripts/ci"
  "scripts/thdora"
  "scripts/thdora-dev"
  "scripts/tests"
  "scripts/maintenance"
)

for isla in "${ISLAS[@]}"; do
  full="$REPO_ROOT/$isla"
  if [[ -d "$full" ]]; then
    count=$(find "$full" -type f | wc -l)
    has_readme=$([[ -f "$full/README.md" ]] && echo "✅" || echo "❌")
    log "  $isla — $count ficheros — README: $has_readme"
  else
    log "  ❌ FALTA: $isla"
    run "mkdir -p '$full'"
  fi
done

# =============================================================================
# PASO 5: SMOKE TEST RÁPIDO DE SCRIPTS CLAVE
# =============================================================================
log ""
log "[PASO 5] Smoke test de scripts clave (syntax check)..."

SCRIPTS_TEST=(
  "scripts/inicio-sesion.sh"
  "scripts/cierre-sesion.sh"
  "scripts/fix-permisos.sh"
  "scripts/02-git-pull-rebase.sh"
  "scripts/batcueva-control.sh"
)

for script in "${SCRIPTS_TEST[@]}"; do
  full="$REPO_ROOT/$script"
  if [[ -f "$full" ]]; then
    if bash -n "$full" 2>/dev/null; then
      log "  ✅ OK: $script"
    else
      log "  ❌ SYNTAX ERROR: $script"
    fi
  else
    log "  ⚠ï¸ No encontrado: $script"
  fi
done

# =============================================================================
# PASO 6: ESTADO DOCKER RÁPIDO
# =============================================================================
log ""
log "[PASO 6] Estado Docker..."
if command -v docker &>/dev/null; then
  run "docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}' 2>/dev/null"
else
  log "  Docker no disponible en este entorno"
fi

# =============================================================================
# PASO 7: RESUMEN FINAL
# =============================================================================
log ""
log "====================================================="
log " RESUMEN"
log "====================================================="
log " Log guardado en: $LOG_FILE"
log " Scripts archivados: ${#OBSOLETOS[@]}"
log " Islas verificadas: ${#ISLAS[@]}"
if [[ "$DRY_RUN" == true ]]; then
  log " MODO: DRY-RUN (nada fue modificado)"
else
  log " MODO: REAL (cambios aplicados)"
fi
log "====================================================="
log " Siguiente paso: bash scripts/create-issues.sh"
log "====================================================="
