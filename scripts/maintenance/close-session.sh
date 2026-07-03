#!/usr/bin/env bash
# =============================================================================
# close-session.sh
# Descripción: Cierre de sesión del ecosistema Yggdrasil
# Ecosistema:  yggdrasil-dew + thdora
# Ejecutar:    bash ~/yggdrasil-dew/scripts/maintenance/close-session.sh
# Compatible:  bash, zsh, blink (iOS/iPadOS)
# Autor:       thdora-guardian | Fix: 2026-07-03
# =============================================================================
# NOTA: NO usa set -euo pipefail para compatibilidad con blink shell
# =============================================================================

SESSION_END=$(date '+%Y-%m-%d %H:%M')
LOG_FILE="/tmp/yggdrasil-session-close.log"

echo "" | tee -a "$LOG_FILE"
echo "============================" | tee -a "$LOG_FILE"
echo "[CLOSE-SESSION] $SESSION_END" | tee -a "$LOG_FILE"
echo "============================" | tee -a "$LOG_FILE"

# ─── 1. Repos a guardar ────────────────────────────────────────────────────
REPOS=()

# Detectar repos disponibles (no falla si no existen)
if [ -d "$HOME/yggdrasil-dew/.git" ]; then
  REPOS+=("$HOME/yggdrasil-dew")
fi
if [ -d "$HOME/Projects/thdora/.git" ]; then
  REPOS+=("$HOME/Projects/thdora")
fi

if [ ${#REPOS[@]} -eq 0 ]; then
  echo "  ⚠️  No se encontraron repos. Verifica rutas."
fi

# ─── 2. Commit y push ──────────────────────────────────────────────────────
echo ""
echo "📦 Guardando cambios..."

for REPO in "${REPOS[@]}"; do
  echo "  → $REPO"
  cd "$REPO" || { echo "  ❌ No se puede entrar a $REPO"; continue; }

  # Verificar si hay cambios
  if git diff --quiet 2>/dev/null && git diff --cached --quiet 2>/dev/null; then
    echo "    ✅ Sin cambios"
  else
    git add -A 2>/dev/null
    git commit -m "chore(session): auto-commit cierre sesión $SESSION_END" 2>/dev/null
    if git push origin HEAD 2>/dev/null; then
      echo "    ✅ Push OK"
    else
      echo "    ⚠️  Push falló (sin conexión o sin token) — cambios guardados local"
    fi
  fi
done

# ─── 3. Estado Docker (si está disponible) ────────────────────────────────
echo ""
echo "🐳 Docker status:"
if command -v docker > /dev/null 2>&1; then
  docker ps --format "  {{.Names}} — {{.Status}}" 2>/dev/null || echo "  ⚠️  docker ps falló"
else
  echo "  ⚠️  docker no disponible en este dispositivo"
  echo "  ℹ️  Normal si ejecutas desde iPhone/Acer"
fi

# ─── 4. Notificación Telegram (si thdora está disponible) ────────────────
echo ""
echo "📱 Telegram:"
THDORA_URL="http://localhost:8000"
if command -v curl > /dev/null 2>&1; then
  if curl -s --max-time 3 "$THDORA_URL/health" > /dev/null 2>&1; then
    curl -s -X POST "$THDORA_URL/notify" \
      -H 'Content-Type: application/json' \
      -d "{\"message\": \"✅ Sesión cerrada $SESSION_END\\nEcosistema Yggdrasil 🌳\"}" 2>/dev/null
    echo "  ✅ Notificado"
  else
    echo "  ⚠️  Thdora no responde (Docker pendiente)"
  fi
else
  echo "  ⚠️  curl no disponible"
fi

# ─── 5. Resumen final ─────────────────────────────────────────────────────
echo ""
echo "─────────────────────────────"
echo "✅ Sesión cerrada: $SESSION_END"
echo "📝 Log: $LOG_FILE"
echo "─────────────────────────────"
echo "Hasta la próxima. 🌳"
echo ""
