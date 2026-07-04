#!/usr/bin/env bash
## FUNCIÓN: Auditoría estructural del repo. Detecta carpetas duplicadas,
##          carpetas vacías, y desviaciones del mapa oficial de islas.
## TRIGGER:  GitHub Action repo-audit, MCP tool struct_auditor
## OUTPUT:   Informe en stdout + issue automático si hay problemas

set -euo pipefail

ROOT="${YGGDRASIL_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || echo .)}"
DATE=$(date +"%Y-%m-%d %H:%M")
ISSUES_FOUND=0
REPORT=""

log() { REPORT+="$1\n"; echo "$1"; }

log "# 🔍 STRUCT AUDITOR — $DATE"
log "ROOT: $ROOT"
log ""

# ── 1. CARPETAS DUPLICADAS CONOCIDAS ──────────────────────────────────────────
log "## Carpetas duplicadas"
DUPLICADOS=(
  "diary diarios"
  "osint osint-stack"
  "ROADMAP.md ROADMAP-MASTER.md"
)

for par in "${DUPLICADOS[@]}"; do
  a=$(echo $par | cut -d' ' -f1)
  b=$(echo $par | cut -d' ' -f2)
  if [ -e "$ROOT/$a" ] && [ -e "$ROOT/$b" ]; then
    log "  ⚠️  DUPLICADO: '$a' y '$b' coexisten. Uno debe eliminarse o consolidarse."
    ISSUES_FOUND=$((ISSUES_FOUND+1))
  else
    log "  ✅  $a / $b — OK (solo existe uno)"
  fi
done
log ""

# ── 2. CARPETAS VACÍAS ────────────────────────────────────────────────────────
log "## Carpetas vacías"
while IFS= read -r dir; do
  # Ignorar .git y .obsidian
  if [[ "$dir" =~ /\.git ]] || [[ "$dir" =~ /\.obsidian ]]; then
    continue
  fi
  # Directorio vacío = no tiene archivos (solo quizás .gitkeep)
  count=$(find "$dir" -maxdepth 1 -type f | grep -v '.gitkeep' | wc -l)
  if [ "$count" -eq 0 ]; then
    subdirs=$(find "$dir" -mindepth 1 -maxdepth 1 -type d | wc -l)
    if [ "$subdirs" -eq 0 ]; then
      log "  ⚠️  VACÍA: ${dir#$ROOT/}"
      ISSUES_FOUND=$((ISSUES_FOUND+1))
    fi
  fi
done < <(find "$ROOT" -mindepth 1 -maxdepth 2 -type d)
log ""

# ── 3. ISLAS ESPERADAS vs REALES ─────────────────────────────────────────────
log "## Islas esperadas"
ISLAS_ESPERADAS=("proyectos" "hardware" "formacion" "osint" "diarios" "sesiones" "inbox" "agentes" "scripts" "docs" "templates" "mcp" "tools" "core")

for isla in "${ISLAS_ESPERADAS[@]}"; do
  if [ -d "$ROOT/$isla" ]; then
    log "  ✅  $isla"
  else
    log "  ❌  FALTA: $isla — no existe en el repo"
    ISSUES_FOUND=$((ISSUES_FOUND+1))
  fi
done
log ""

# ── RESUMEN ───────────────────────────────────────────────────────────────────
log "## Resumen"
if [ "$ISSUES_FOUND" -eq 0 ]; then
  log "✅ STRUCT OK — Sin problemas detectados."
else
  log "⚠️  STRUCT ISSUES: $ISSUES_FOUND problemas encontrados. Revisar arriba."
  # Si hay gh CLI disponible, crear issue automático
  if command -v gh &>/dev/null && [ -n "${GITHUB_REPOSITORY:-}" ]; then
    gh issue create \
      --title "[STRUCT-AUDITOR] $ISSUES_FOUND problemas estructurales detectados — $DATE" \
      --body "$(printf '%b' "$REPORT")" \
      --label "audit,automatico" 2>/dev/null || true
    echo "📋 Issue automático creado en GitHub."
  fi
  exit 1
fi
