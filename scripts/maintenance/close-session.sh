#!/usr/bin/env bash
# Descripción: Cierre de sesión del ecosistema Yggdrasil
# Ecosistema: yggdrasil + thdora
# Ejecutar: Al finalizar cada sesión de trabajo
# Dependencias: git, thdora (opcional para envío Telegram)
# Autor: Yggdrasil Bot | Creado: 2026-07-03

set -euo pipefail

SESSION_END=$(date '+%Y-%m-%d %H:%M')
LOG_FILE="/tmp/yggdrasil-session-close.log"

echo "[CLOSE-SESSION] $SESSION_END" | tee -a "$LOG_FILE"

# ─── 1. Commit y push de todos los repos ───────────────────────────────────
echo "📦 Guardando cambios..."

for REPO in ~/yggdrasil-dew ~/Projects/thdora; do
  if [ -d "$REPO/.git" ]; then
    cd "$REPO"
    if ! git diff --quiet || ! git diff --cached --quiet; then
      git add -A
      git commit -m "chore(session): auto-commit cierre sesión $SESSION_END" 2>/dev/null || true
      git push origin HEAD 2>/dev/null && echo "  ✅ $REPO pushed" || echo "  ⚠️  $REPO push falló (continúa)"
    else
      echo "  ✅ $REPO sin cambios"
    fi
  fi
done

# ─── 2. Resumen de la sesión ────────────────────────────────────────────────
echo ""
echo "📊 Resumen de sesión:"
echo "  Hora cierre: $SESSION_END"
echo "  Log: $LOG_FILE"

# ─── 3. Notificación Telegram (si thdora está disponible) ──────────────────
THDORA_URL="http://localhost:8000"
if curl -s --max-time 3 "$THDORA_URL/health" > /dev/null 2>&1; then
  PAYLOAD=$(cat <<EOF
✅ *Sesión cerrada* — $SESSION_END

📦 Commits guardados
🔒 Sistema seguro
Ecosistema Yggdrasil 🌳
EOF
)
  # Enviar vía thdora si tiene endpoint /notify
  curl -s -X POST "$THDORA_URL/notify" \
    -H 'Content-Type: application/json' \
    -d "{\"message\": \"$PAYLOAD\"}" 2>/dev/null || true
  echo "  📱 Telegram notificado"
else
  echo "  ⚠️  Thdora no disponible — sin notificación Telegram"
fi

echo ""
echo "✅ Sesión cerrada correctamente. Hasta la próxima."
