#!/usr/bin/env bash
# =============================================================================
# AUDITORIA-COPILOT.sh
# Script completo de auditoría del ecosistema yggdrasil-dew
# Ejecutar desde la raíz del repo: bash inbox/_meta/AUDITORIA-COPILOT.sh
# Genera reportes en inbox/_meta/
# =============================================================================

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$REPO_ROOT"

FECHA=$(date +%Y-%m-%d)
HORA=$(date +%H%M%S)
META_DIR="inbox/_meta"
mkdir -p "$META_DIR"

SCORE=100
WARNINGS=0
ERRORS=0

log() { echo "[$(date +%H:%M:%S)] $1"; }

# =============================================================================
# TAREA 1 — AUDITORÍA DE WORKFLOWS
# =============================================================================
log "TAREA 1: Auditando .github/workflows/..."

WF_REPORT="$META_DIR/audit-workflows-$FECHA.md"
cat > "$WF_REPORT" << 'HEADER'
# Auditoría de Workflows — yggdrasil-dew
HEADER
echo "Fecha: $FECHA $HORA" >> "$WF_REPORT"
echo "" >> "$WF_REPORT"
echo "| Workflow | Bytes | Estado |" >> "$WF_REPORT"
echo "|---|---|---|" >> "$WF_REPORT"

STUBS=0
FUNCIONALES=0
if [ -d ".github/workflows" ]; then
  while IFS= read -r -d '' wf; do
    nombre=$(basename "$wf")
    bytes=$(wc -c < "$wf")
    if [ "$bytes" -lt 300 ]; then
      echo "| $nombre | $bytes | ⚠️ STUB vacío |" >> "$WF_REPORT"
      STUBS=$((STUBS + 1))
      WARNINGS=$((WARNINGS + 1))
      SCORE=$((SCORE - 1))
    else
      echo "| $nombre | $bytes | ✅ Funcional |" >> "$WF_REPORT"
      FUNCIONALESF=$((FUNCIONALESF + 1))
    fi
  done < <(find .github/workflows -name "*.yml" -print0 | sort -z)
fi

echo "" >> "$WF_REPORT"
echo "**Stubs detectados:** $STUBS" >> "$WF_REPORT"
log "  → Stubs: $STUBS | Funcionales: $FUNCIONALES"

# =============================================================================
# TAREA 2 — AUDITORÍA DE SCRIPTS/
# =============================================================================
log "TAREA 2: Auditando scripts/..."

SC_REPORT="$META_DIR/audit-scripts-$FECHA.md"
cat > "$SC_REPORT" << 'HEADER'
# Auditoría de Scripts — yggdrasil-dew
HEADER
echo "Fecha: $FECHA $HORA" >> "$SC_REPORT"
echo "" >> "$SC_REPORT"
echo "## Scripts .sh" >> "$SC_REPORT"
echo "| Script | Bytes | Estado |" >> "$SC_REPORT"
echo "|---|---|---|" >> "$SC_REPORT"

SCRIPTS_CLAVE=(
  "inbox-commit.sh"
  "inbox-clasificador.sh"
  "session-logger.sh"
  "session-terminal-doc.sh"
  "orquestador-unico.sh"
  "file-arrival-guardian.sh"
  "cierre-sesion.sh"
)

if [ -d "scripts" ]; then
  while IFS= read -r -d '' sc; do
    nombre=$(basename "$sc")
    ext="${nombre##*.}"
    bytes=$(wc -c < "$sc")
    if [ "$ext" = "sh" ]; then
      if [ "$bytes" -lt 200 ]; then
        echo "| $nombre | $bytes | ⚠️ STUB vacío |" >> "$SC_REPORT"
        WARNINGS=$((WARNINGS + 1))
        SCORE=$((SCORE - 1))
      else
        echo "| $nombre | $bytes | ✅ Funcional |" >> "$SC_REPORT"
      fi
    elif [ "$ext" = "md" ]; then
      echo "" >> "$SC_REPORT"
      echo "## ⛔ Archivos .md mal ubicados en scripts/" >> "$SC_REPORT"
      echo "- $nombre ($bytes bytes) → debería estar en docs/ o diarios/" >> "$SC_REPORT"
      ERRORS=$((ERRORS + 1))
      SCORE=$((SCORE - 3))
    fi
  done < <(find scripts -maxdepth 1 -type f -print0 | sort -z)
fi

echo "" >> "$SC_REPORT"
echo "## Scripts clave — verificación" >> "$SC_REPORT"
for sc_clave in "${SCRIPTS_CLAVE[@]}"; do
  if [ -f "scripts/$sc_clave" ]; then
    bytes=$(wc -c < "scripts/$sc_clave")
    if [ "$bytes" -gt 200 ]; then
      echo "- ✅ $sc_clave ($bytes bytes)" >> "$SC_REPORT"
    else
      echo "- ⚠️ $sc_clave existe pero es stub ($bytes bytes)" >> "$SC_REPORT"
      WARNINGS=$((WARNINGS + 1))
    fi
  else
    echo "- ❌ $sc_clave NO EXISTE — hay que crearlo" >> "$SC_REPORT"
    ERRORS=$((ERRORS + 1))
    SCORE=$((SCORE - 5))
  fi
done

log "  → Reporte scripts generado"

# =============================================================================
# TAREA 3 — AUDITORÍA DE ESTRUCTURA inbox/
# =============================================================================
log "TAREA 3: Auditando estructura inbox/..."

EST_REPORT="$META_DIR/audit-estructura-$FECHA.md"
cat > "$EST_REPORT" << 'HEADER'
# Auditoría de Estructura inbox/ — yggdrasil-dew
HEADER
echo "Fecha: $FECHA $HORA" >> "$EST_REPORT"
echo "" >> "$EST_REPORT"

# Archivos sueltos en inbox/ raíz que deberían estar en _meta
echo "## Archivos mal ubicados en inbox/ raíz" >> "$EST_REPORT"
echo "| Archivo | Destino correcto |" >> "$EST_REPORT"
echo "|---|---|" >> "$EST_REPORT"

if [ -d "inbox" ]; then
  while IFS= read -r -d '' f; do
    nombre=$(basename "$f")
    case "$nombre" in
      audit-*.md)
        echo "| $nombre | inbox/_meta/ |" >> "$EST_REPORT"
        WARNINGS=$((WARNINGS + 1))
        ;;
      [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]-*.md)
        echo "| $nombre | diarios/ |" >> "$EST_REPORT"
        WARNINGS=$((WARNINGS + 1))
        ;;
      ALERTA-*.md)
        echo "| $nombre | inbox/_meta/ |" >> "$EST_REPORT"
        WARNINGS=$((WARNINGS + 1))
        ;;
    esac
  done < <(find inbox -maxdepth 1 -type f -name "*.md" -print0 | sort -z)
fi

# Carpetas duplicadas
echo "" >> "$EST_REPORT"
echo "## Carpetas duplicadas o problemáticas" >> "$EST_REPORT"

DUPS=(
  "inbox/diarios:duplicado de diarios/ raíz"
  "inbox/diary:duplicado inglés de diarios/"
  "inbox/osint-stack:duplicado de inbox/osint/"
  "inbox/cli-tools:posible duplicado de inbox/tools/"
  "inbox/alvarofernandezmota-tech:nombre de usuario como carpeta"
)

for dup in "${DUPS[@]}"; do
  carpeta="${dup%%:*}"
  razon="${dup##*:}"
  if [ -d "$carpeta" ]; then
    contenido=$(find "$carpeta" -not -name '.gitkeep' | wc -l)
    echo "- ⚠️ \`$carpeta\` existe | $razon | archivos: $contenido" >> "$EST_REPORT"
    WARNINGS=$((WARNINGS + 1))
    SCORE=$((SCORE - 2))
  else
    echo "- ✅ \`$carpeta\` no existe (OK)" >> "$EST_REPORT"
  fi
done

# Carpetas vacías sin .gitkeep
echo "" >> "$EST_REPORT"
echo "## Carpetas vacías sin .gitkeep" >> "$EST_REPORT"
while IFS= read -r -d '' d; do
  if [ -z "$(ls -A "$d" 2>/dev/null)" ]; then
    echo "- ⚠️ \`$d\` está vacía sin .gitkeep" >> "$EST_REPORT"
    WARNINGS=$((WARNINGS + 1))
  fi
done < <(find inbox -mindepth 1 -type d -print0 | sort -z)

log "  → Reporte estructura generado"

# =============================================================================
# TAREA 4 — RESUMEN EJECUTIVO
# =============================================================================
log "TAREA 4: Generando resumen ejecutivo..."

# Score final (mínimo 0)
[ "$SCORE" -lt 0 ] && SCORE=0

if [ "$SCORE" -ge 85 ]; then
  SALUD="🟢 BUENA ($SCORE/100)"
elif [ "$SCORE" -ge 60 ]; then
  SALUD="🟡 REGULAR ($SCORE/100)"
else
  SALUD="🔴 CRÍTICA ($SCORE/100)"
fi

RES_REPORT="$META_DIR/audit-resumen-$FECHA.md"
cat > "$RES_REPORT" << RESUMEN
# Resumen Ejecutivo — Auditoría yggdrasil-dew
Fecha: $FECHA | Hora: $HORA

## Salud del ecosistema: $SALUD

| Métrica | Valor |
|---|---|
| Score | $SCORE / 100 |
| Warnings | $WARNINGS |
| Errores críticos | $ERRORS |

## Reportes generados
- [Workflows](audit-workflows-$FECHA.md)
- [Scripts](audit-scripts-$FECHA.md)
- [Estructura](audit-estructura-$FECHA.md)

## Próximos pasos para Copilot
1. Revisar workflows con estado STUB y rellenarlos o eliminarlos
2. Mover .md de scripts/ a docs/ o diarios/
3. Mover audit-*.md de inbox/ raíz a inbox/_meta/
4. Mover archivos con fecha de inbox/ raíz a diarios/
5. Consolidar carpetas duplicadas
6. Crear scripts clave que falten con lógica funcional completa

## Reglas del ecosistema (no romper)
- inbox/drop/ → única zona de aterrizaje
- inbox/_meta/ → reportes de auditoría
- diarios/ → cierres de sesión YYYY-MM-DD-*.md
- scripts/ → solo .sh ejecutables
- docs/ → documentación
- Raíz del repo → solo README.md, .gitignore, LICENSE

---
*Generado automáticamente por AUDITORIA-COPILOT.sh*
RESUMEN

log "  → Resumen ejecutivo generado"

# =============================================================================
# COMMIT AUTOMÁTICO DE LOS REPORTES
# =============================================================================
log "Commiteando reportes..."

git add "$META_DIR/audit-workflows-$FECHA.md" \
        "$META_DIR/audit-scripts-$FECHA.md" \
        "$META_DIR/audit-estructura-$FECHA.md" \
        "$META_DIR/audit-resumen-$FECHA.md" 2>/dev/null || true

git diff --cached --quiet || \
  git commit -m "audit(copilot): auditoría completa ecosistema $FECHA — score $SCORE/100"

log ""
log "============================================================"
log " AUDITORÍA COMPLETA"
log " Salud: $SALUD"
log " Warnings: $WARNINGS | Errores: $ERRORS"
log " Reportes en: $META_DIR/"
log "============================================================"
