#!/usr/bin/env bash
# Descripción: Genera y envía resumen de sesión al bot de Telegram vía thdora
# Ecosistema: thdora
# Ejecutar: Al final de cada sesión, o llamado por close-session.sh
# Dependencias: curl, git, thdora corriendo en localhost:8000
# Autor: Yggdrasil Bot | Creado: 2026-07-03

set -euo pipefail

THDORA_URL="${THDORA_URL:-http://localhost:8000}"
DATE=$(date '+%Y-%m-%d')
TIME=$(date '+%H:%M')

# ─── Recopilar datos de la sesión ──────────────────────────────────────────

# Commits de hoy en todos los repos
COMMITS_YGGDRASIL=$(cd ~/yggdrasil-dew 2>/dev/null && git log --oneline --since="$DATE 00:00" 2>/dev/null | wc -l || echo "0")
COMMITS_THDORA=$(cd ~/Projects/thdora 2>/dev/null && git log --oneline --since="$DATE 00:00" 2>/dev/null | wc -l || echo "0")

# Estado Docker
CONTAINERS_UP=$(docker ps --format '{{.Names}}' 2>/dev/null | wc -l || echo "?")
CONTAINERS_ALL=$(docker ps -a --format '{{.Names}}' 2>/dev/null | wc -l || echo "?")

# Issues abiertos en thdora (si hay gh cli)
ISSUES_OPEN=""
if command -v gh &> /dev/null; then
  ISSUES_OPEN=$(gh issue list -R alvarofernandezmota-tech/thdora --state open 2>/dev/null | wc -l || echo "?")
  ISSUES_MSG="🐛 Issues abiertos thdora: $ISSUES_OPEN"
else
  ISSUES_MSG="🐛 Issues: gh CLI no disponible"
fi

# ─── Construir mensaje ─────────────────────────────────────────────────────
MESSAGE=$(cat <<EOF
📊 *Resumen de Sesión — $DATE $TIME*

🌳 *Yggdrasil-dew*
  • Commits hoy: $COMMITS_YGGDRASIL

🤖 *Thdora*
  • Commits hoy: $COMMITS_THDORA
  • $ISSUES_MSG

🐳 *Docker*
  • Contenedores activos: $CONTAINERS_UP/$CONTAINERS_ALL

---
_Ecosistema Yggdrasil 🌱_
EOF
)

# ─── Enviar a thdora ───────────────────────────────────────────────────────
if curl -s --max-time 5 "$THDORA_URL/health" > /dev/null 2>&1; then
  RESPONSE=$(curl -s -X POST "$THDORA_URL/notify" \
    -H 'Content-Type: application/json' \
    -d "{\"message\": $(echo "$MESSAGE" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))'), \"parse_mode\": \"Markdown\"}" 2>/dev/null)
  echo "✅ Reporte enviado a Telegram via thdora"
  echo "   Respuesta: $RESPONSE"
else
  echo "⚠️  Thdora no disponible en $THDORA_URL"
  echo "   Mensaje que se hubiera enviado:"
  echo "$MESSAGE"
  exit 1
fi
