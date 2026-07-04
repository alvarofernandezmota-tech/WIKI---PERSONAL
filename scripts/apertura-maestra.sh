#!/usr/bin/env bash
# =============================================================================
# apertura-maestra.sh — Script ÚNICO de apertura de sesión
# Uso: bash scripts/apertura-maestra.sh "objetivo de la sesión"
# =============================================================================
set -euo pipefail

OBJETIVO="${1:-trabajo general}"
TS=$(date +%Y-%m-%dT%H-%M-%S)
FECHA=$(date +%Y-%m-%d)
HORA=$(date +%H:%M)
BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "unknown")
USER_HOST="$(whoami)@$(hostname)"

DIR_SESIONES="inbox/sesiones"
mkdir -p "$DIR_SESIONES"

APERTURA="$DIR_SESIONES/apertura-${FECHA}T${TS##*T}.md"

echo "🌅 Abriendo sesión → $APERTURA"

echo "🔄 Sincronizando repo..."
git pull origin "$BRANCH" --rebase 2>/dev/null || echo "  (sin cambios remotos)"

PENDIENTES=$(find inbox/drop/ -not -name '.gitkeep' -not -type d 2>/dev/null | wc -l)
ULT_CIERRE=$(ls -t inbox/sesiones/cierre-*.md 2>/dev/null | head -1 || echo "(ninguno)")

cat > "$APERTURA" << EOF
# Apertura de sesión — ${FECHA} ${HORA}

## Metadatos
| Campo | Valor |
|---|---|
| Fecha | ${FECHA} |
| Hora apertura | ${HORA} |
| Usuario | ${USER_HOST} |
| Branch | ${BRANCH} |

## Objetivo de la sesión
${OBJETIVO}

## Estado al arrancar
- Archivos en inbox/drop/: ${PENDIENTES}
- Último cierre: ${ULT_CIERRE}

## Últimos 3 commits
\`\`\`
$(git log -3 --oneline 2>/dev/null || echo "(sin historial)")
\`\`\`

## Checklist de arranque
- [x] git pull ejecutado
- [ ] inbox/drop/ revisado
- [ ] Auditoría: bash scripts/auditoria-maestra.sh --dry-run
EOF

echo "✅ Apertura generada: $APERTURA"
echo ""
echo "📋 Pendientes en inbox/drop/: $PENDIENTES"
if [ "$PENDIENTES" -gt 0 ]; then
  echo "   → bash scripts/inbox-commit.sh \"descripcion\" para clasificarlos"
fi
echo ""
echo "🔍 Auditoría dry-run:"
bash scripts/auditoria-maestra.sh --dry-run 2>/dev/null || echo "  (ejecuta manualmente si falla)"
echo ""
echo "🚀 ¡Sesión abierta. A trabajar!"
