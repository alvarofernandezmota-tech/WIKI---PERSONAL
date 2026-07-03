#!/usr/bin/env bash
# ============================================================
# ARCHIVO      : session-terminal-doc.sh
# VERSIÓN      : 1.0.0
# FUNCIÓN ÚNICA: Al final de cada sesión de trabajo, genera
#                automáticamente el documento de cierre con:
#                - Resumen de lo ejecutado
#                - Estado del repo (git status, log)
#                - Issues pendientes
#                - Próximos pasos
#                Lo guarda en inbox/ para que session-close.yml
#                lo mueva a diarios/
# AUTOR        : alvarofernandezmota-tech
# USO          : bash scripts/session-terminal-doc.sh "Descripción sesión"
# SALIDA       : inbox/sesiones/cierre-YYYYMMDD-HHMMSS.md
# ============================================================

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
DESC="${1:-sesión sin descripción}"
STAMP=$(date "+%Y%m%dT%H%M%S")
DATE_HUMAN=$(date "+%Y-%m-%d %H:%M")
OUT_DIR="$REPO_ROOT/inbox/sesiones"
OUT_FILE="$OUT_DIR/cierre-${STAMP}.md"

mkdir -p "$OUT_DIR"

echo "[session-terminal-doc] Generando documento de cierre..."

# Recopilar datos del repo
BRANCH=$(git -C "$REPO_ROOT" branch --show-current 2>/dev/null || echo 'N/A')
LAST_COMMITS=$(git -C "$REPO_ROOT" log --oneline -5 2>/dev/null || echo 'N/A')
GIT_STATUS=$(git -C "$REPO_ROOT" status --short 2>/dev/null || echo 'limpio')
FILES_CHANGED=$(git -C "$REPO_ROOT" diff --name-only HEAD~1 HEAD 2>/dev/null | head -20 || echo 'N/A')

cat > "$OUT_FILE" << EOF
# Cierre de sesión — ${DATE_HUMAN}

## Descripción
${DESC}

## Estado del repo
| Campo | Valor |
|---|---|
| Branch | ${BRANCH} |
| Archivos pendientes | $(echo "$GIT_STATUS" | wc -l | tr -d ' ') |
| Timestamp | ${STAMP} |

## Últimos commits
\`\`\`
${LAST_COMMITS}
\`\`\`

## Archivos cambiados en último commit
\`\`\`
${FILES_CHANGED}
\`\`\`

## Git status
\`\`\`
${GIT_STATUS}
\`\`\`

## Resultado file-arrival-guardian
$(bash "$REPO_ROOT/scripts/file-arrival-guardian.sh" --dry-run 2>&1 | tail -5 || echo 'no ejecutado')

## Próximos pasos
- [ ] Revisar issues abiertos en GitHub
- [ ] Ejecutar orquestador-unico.sh al inicio de próxima sesión
- [ ] Verificar Actions completadas en GitHub

---
> Generado automáticamente por session-terminal-doc.sh
EOF

echo "[session-terminal-doc] ✅ Documento generado: $OUT_FILE"
echo ""
echo "Ahora ejecuta:"
echo "  git add inbox/sesiones/cierre-${STAMP}.md"
echo "  git commit -m 'docs(sesion): cierre ${DATE_HUMAN} — ${DESC}'"
echo "  git push origin main"
echo ""
echo "El push disparará session-close.yml que moverá esto a diarios/"
