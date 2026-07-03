#!/usr/bin/env bash
# =============================================================================
# cierre-maestro.sh — Script ÚNICO de cierre de sesión
# Uso: bash scripts/cierre-maestro.sh "descripción de la sesión"
# =============================================================================
set -euo pipefail

DESC="${1:-sin descripción}"
TS=$(date +%Y-%m-%dT%H-%M-%S)
FECHA=$(date +%Y-%m-%d)
HORA=$(date +%H:%M)
BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "unknown")
COMMIT=$(git log -1 --format='%h %s' 2>/dev/null || echo "sin commits")
USER_HOST="$(whoami)@$(hostname)"

DIR_SESIONES="inbox/sesiones"
DIR_META="inbox/_meta"
mkdir -p "$DIR_SESIONES" "$DIR_META"

CIERRE="$DIR_SESIONES/cierre-${FECHA}T${TS##*T}.md"

echo "📁 Generando documento de cierre → $CIERRE"

cat > "$CIERRE" << EOF
# Cierre de sesión — ${FECHA} ${HORA}

## Metadatos
| Campo | Valor |
|---|---|
| Fecha | ${FECHA} |
| Hora cierre | ${HORA} |
| Usuario | ${USER_HOST} |
| Branch | ${BRANCH} |
| Último commit | ${COMMIT} |

## Descripción de la sesión
${DESC}

## Estado del repo
\`\`\`
$(git status --short 2>/dev/null || echo "(sin cambios pendientes)")
\`\`\`

## Últimos 5 commits
\`\`\`
$(git log -5 --oneline 2>/dev/null || echo "(sin historial)")
\`\`\`

## Archivos modificados en esta sesión
\`\`\`
$(git diff --name-only HEAD~1 HEAD 2>/dev/null || git diff --cached --name-only 2>/dev/null || echo "(sin diff disponible)")
\`\`\`

## Próximos pasos
- [ ] Revisar inbox/drop/ en próxima sesión
- [ ] Ejecutar auditoría: bash scripts/auditoria-maestra.sh
- [ ] Abrir sesión: bash scripts/apertura-maestra.sh
EOF

echo "✅ Cierre generado: $CIERRE"

# --- Auditoría rápida de estructura ---
echo ""
echo "🔍 Auditoría rápida..."
ERRORS=0

MD_SUELTOS=$(find scripts/ -maxdepth 1 -name '*.md' ! -name 'README.md' ! -name 'SCRIPTS.md' ! -name 'SCRIPTS-AUDITORIA.md' 2>/dev/null | wc -l)
if [ "$MD_SUELTOS" -gt 0 ]; then
  echo "  ⚠️  $MD_SUELTOS .md(s) fuera de lugar en scripts/"
  find scripts/ -maxdepth 1 -name '*.md' ! -name 'README.md' ! -name 'SCRIPTS.md' ! -name 'SCRIPTS-AUDITORIA.md' 2>/dev/null
  ERRORS=$((ERRORS+1))
fi

DROP_COUNT=$(find inbox/drop/ -not -name '.gitkeep' -not -type d 2>/dev/null | wc -l)
if [ "$DROP_COUNT" -gt 0 ]; then
  echo "  📥 inbox/drop/ tiene $DROP_COUNT archivo(s) pendiente(s) de clasificar"
fi

if [ "$ERRORS" -eq 0 ]; then
  echo "  ✅ Estructura OK"
fi

# --- Commit y push ---
echo ""
echo "📤 Commiteando cierre..."
git add "$CIERRE"
git commit -m "docs(sesion): cierre ${FECHA} ${HORA} — ${DESC}"
git push origin "$BRANCH"

echo ""
echo "🌙 Sesión cerrada. El Action inbox-clasificador.yml moverá el cierre a diarios/ automáticamente."
echo "   → $CIERRE"
