#!/usr/bin/env bash
# Descripción: Cron nocturno del ecosistema — backup + sync + health
# Ecosistema: yggdrasil + thdora
# Ejecutar: Cron diario 02:00 — 0 2 * * * bash ~/yggdrasil-dew/scripts/maintenance/night-cron.sh
# Dependencias: git, restic (opcional), docker
# Autor: Yggdrasil Bot | Creado: 2026-07-03

set -euo pipefail

DATE=$(date '+%Y-%m-%d')
LOG_FILE="/tmp/yggdrasil-night-$DATE.log"
START=$(date '+%H:%M:%S')

exec > >(tee -a "$LOG_FILE") 2>&1

echo "====================================="
echo "🌙 CRON NOCTURNO — $DATE $START"
echo "====================================="

# ─── 1. Git pull todos los repos ────────────────────────────────────────────
echo "[1/5] Git sync..."
for REPO in ~/yggdrasil-dew ~/Projects/thdora; do
  if [ -d "$REPO/.git" ]; then
    cd "$REPO"
    git pull --rebase origin HEAD 2>/dev/null && echo "  ✅ $REPO" || echo "  ⚠️  $REPO fallo pull"
  fi
done

# ─── 2. Health check Docker ──────────────────────────────────────────────────
echo "[2/5] Docker health..."
if command -v docker &> /dev/null; then
  CONTAINERS_DOWN=$(docker ps --filter status=exited --format '{{.Names}}' 2>/dev/null | tr '\n' ' ')
  if [ -n "$CONTAINERS_DOWN" ]; then
    echo "  ⚠️  Contenedores caídos: $CONTAINERS_DOWN"
  else
    echo "  ✅ Todos los contenedores activos"
  fi
else
  echo "  ⚠️  Docker no disponible"
fi

# ─── 3. Backup restic (si disponible) ────────────────────────────────────────
echo "[3/5] Backup restic..."
if command -v restic &> /dev/null && [ -f ~/.restic-env ]; then
  source ~/.restic-env
  restic backup ~/Projects ~/yggdrasil-dew --tag "night-$DATE" 2>/dev/null && echo "  ✅ Backup OK" || echo "  ⚠️  Backup falló"
else
  echo "  ⏭️  Restic no configurado — skip"
fi

# ─── 4. Limpieza de logs temporales ─────────────────────────────────────────
echo "[4/5] Limpieza logs..."
find /tmp -name 'yggdrasil-*.log' -mtime +7 -delete 2>/dev/null && echo "  ✅ Logs >7 días eliminados"

# ─── 5. Notificación resumen ──────────────────────────────────────────────────
echo "[5/5] Notificación..."
END=$(date '+%H:%M:%S')
THDORA_URL="http://localhost:8000"
if curl -s --max-time 3 "$THDORA_URL/health" > /dev/null 2>&1; then
  curl -s -X POST "$THDORA_URL/notify" \
    -H 'Content-Type: application/json' \
    -d "{\"message\": \"🌙 Cron nocturno $DATE completado — $START → $END\"}" 2>/dev/null || true
  echo "  📱 Telegram notificado"
fi

echo ""
echo "✅ Cron nocturno completado: $DATE $END"
echo "Log guardado en: $LOG_FILE"
