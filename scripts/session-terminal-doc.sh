#!/usr/bin/env bash
# =============================================================================
# session-terminal-doc.sh — Genera el documento de cierre de sesión con:
#   - Resumen, estado del repo, últimos commits, archivos cambiados
#   - Guarda en inbox/sesiones/cierre-YYYYMMDDTHHMMSS.md
#
# USO:
#   bash scripts/session-terminal-doc.sh "descripción de la sesión"
# =============================================================================
set -euo pipefail

DESCRIPCION="${1:-sesión sin descripción}"
REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || echo "$HOME/yggdrasil-dew")"
SESIONES_DIR="$REPO_ROOT/inbox/sesiones"
mkdir -p "$SESIONES_DIR"

TIMESTAMP="$(date +%Y%m%dT%H%M%S)"
FECHA_LEGIBLE="$(date '+%Y-%m-%d %H:%M:%S')"
CIERRE_FILE="$SESIONES_DIR/cierre-${TIMESTAMP}.md"
BRANCH="$(git -C "$REPO_ROOT" branch --show-current 2>/dev/null || echo 'main')"

cat > "$CIERRE_FILE" <<EOF
# Cierre de sesión — ${TIMESTAMP}

## Resumen

- **Descripción**: ${DESCRIPCION}
- **Fecha**: ${FECHA_LEGIBLE}
- **Usuario**: $(whoami)
- **Host**: $(hostname)
- **Branch**: ${BRANCH}

## Estado del repositorio

\`\`\`
$(git -C "$REPO_ROOT" status --short 2>/dev/null || echo 'Sin cambios pendientes')
\`\`\`

## Últimos 10 commits

\`\`\`
$(git -C "$REPO_ROOT" log --oneline -10 2>/dev/null || echo 'Sin commits')
\`\`\`

## Archivos modificados en esta sesión

\`\`\`
$(git -C "$REPO_ROOT" diff --name-only HEAD 2>/dev/null || echo 'Sin diferencias staged')
$(git -C "$REPO_ROOT" diff --name-only 2>/dev/null || echo '')
\`\`\`

## Próximos pasos

<!-- Completar manualmente o dejar para el agente de apertura de próxima sesión -->
- [ ] Revisar issues abiertos
- [ ] Ejecutar auditoría de estructura
- [ ] Sincronizar con GitHub Actions

---
*Generado automáticamente por session-terminal-doc.sh*
EOF

echo "[session-terminal-doc] Documento de cierre creado: $CIERRE_FILE"
echo ""
echo "Próximos pasos:"
echo "  git add inbox/sesiones/cierre-${TIMESTAMP}.md"
echo "  git commit -m \"docs(sesion): cierre ${TIMESTAMP} — ${DESCRIPCION}\""
echo "  git push origin main"
