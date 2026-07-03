#!/usr/bin/env bash
# Descripción: Health check de todos los contenedores Docker del ecosistema
# Ecosistema: yggdrasil + thdora
# Ejecutar: Manualmente o llamado por night-cron.sh
# Dependencias: docker, curl (para notificación)
# Autor: Yggdrasil Bot | Creado: 2026-07-03

set -euo pipefail

THDORA_URL="${THDORA_URL:-http://localhost:8000}"
ALERT=false
REPORT=""

echo "🐳 Docker Health Check — $(date '+%Y-%m-%d %H:%M')"
echo "═══════════════════════════════"

# ─── 1. Contenedores esperados del ecosistema ──────────────────────────────
# Añadir aquí los nombres de contenedores críticos
EXPECTED_CONTAINERS=(
  "thdora"
  "thdora-redis"
  # "uptime-kuma"  # descomentar cuando esté activo
  # "ollama"       # descomentar cuando esté activo
)

# ─── 2. Verificar cada contenedor esperado ─────────────────────────────────
for CONTAINER in "${EXPECTED_CONTAINERS[@]}"; do
  STATUS=$(docker inspect --format='{{.State.Status}}' "$CONTAINER" 2>/dev/null || echo "not_found")
  HEALTH=$(docker inspect --format='{{.State.Health.Status}}' "$CONTAINER" 2>/dev/null || echo "n/a")
  
  if [ "$STATUS" = "running" ]; then
    echo "  ✅ $CONTAINER — running (health: $HEALTH)"
    REPORT+="✅ $CONTAINER: running\n"
  else
    echo "  ❌ $CONTAINER — $STATUS"
    REPORT+="❌ $CONTAINER: $STATUS\n"
    ALERT=true
  fi
done

# ─── 3. Listar contenedores no esperados que están corriendo ───────────────
echo ""
echo "📋 Todos los contenedores activos:"
docker ps --format "  • {{.Names}} ({{.Status}})" 2>/dev/null || echo "  Error al listar"

# ─── 4. Alerta si hay problemas ────────────────────────────────────────────
if $ALERT; then
  echo ""
  echo "🚨 ALERTA: Hay contenedores caídos"
  
  if curl -s --max-time 3 "$THDORA_URL/health" > /dev/null 2>&1; then
    curl -s -X POST "$THDORA_URL/notify" \
      -H 'Content-Type: application/json' \
      -d "{\"message\": \"🚨 Docker Alert\\n$REPORT\"}" 2>/dev/null || true
    echo "  📱 Alerta enviada a Telegram"
  fi
  exit 1
fi

echo ""
echo "✅ Todos los contenedores del ecosistema operativos"
