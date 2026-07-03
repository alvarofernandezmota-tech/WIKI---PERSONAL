#!/usr/bin/env bash
# =============================================================================
# FIX UNHEALTHY CONTAINERS
# Diagnostica y da pasos para arreglar los containers unhealthy
# Uso: bash scripts/maintenance/fix-unhealthy.sh
# =============================================================================
set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'
info()  { echo -e "${BLUE}[→]${NC} $1"; }
ok()    { echo -e "${GREEN}[✓]${NC} $1"; }
warn()  { echo -e "${YELLOW}[!]${NC} $1"; }
error() { echo -e "${RED}[✗]${NC} $1"; }

echo ""
echo "🔧 FIX UNHEALTHY CONTAINERS"
echo "─────────────────────────────────────"
echo ""

# --- DETECTAR UNHEALTHY ---
UNHEALTHY=$(docker ps --filter health=unhealthy --format '{{.Names}}' 2>/dev/null)
STARTING=$(docker ps --filter health=starting --format '{{.Names}}' 2>/dev/null)

if [ -z "$UNHEALTHY" ] && [ -z "$STARTING" ]; then
  ok "Todos los containers están healthy"
  exit 0
fi

# --- DIAGNOSTICAR CADA UNO ---
for container in $UNHEALTHY; do
  echo ""
  error "Container unhealthy: $container"
  echo "─── Últimas 20 líneas de log:"
  docker logs "$container" --tail=20 2>&1 | sed 's/^/  /'
  echo ""
  echo "─── Healthcheck config:"
  docker inspect "$container" --format='  Cmd: {{.Config.Healthcheck.Test}}' 2>/dev/null || true
  docker inspect "$container" --format='  Interval: {{.Config.Healthcheck.Interval}}' 2>/dev/null || true
  echo ""

  # Fix específico por container conocido
  case "$container" in
    tailscale_monitor)
      warn "Fix tailscale_monitor: necesita TS_AUTHKEY"
      echo "  1. Obtén tu Tailscale Auth Key: https://login.tailscale.com/admin/settings/keys"
      echo "  2. Añade al docker-compose.yml:"
      echo "       environment:"
      echo "         - TS_AUTHKEY=tskey-auth-XXXXXXXX"
      echo "  3. docker compose up -d --force-recreate tailscale_monitor"
      ;;
    local_tripwire)
      warn "Fix local_tripwire: healthcheck falla después del baseline"
      echo "  1. Ver qué espera el healthcheck:"
      echo "     docker inspect local_tripwire | grep -A5 Healthcheck"
      echo "  2. Revisar si necesita un puerto/endpoint:"
      echo "     docker logs local_tripwire --tail=50 | grep -i 'listen\|port\|http'"
      ;;
    yggdrasil_watchdog)
      warn "Fix yggdrasil_watchdog: probablemente está esperando que arranquen otros containers"
      echo "  Es normal durante los primeros 3-5min después de un reboot"
      echo "  Si persiste > 10min: docker restart yggdrasil_watchdog"
      ;;
    *)
      warn "Container desconocido: $container — revisa los logs arriba"
      ;;
  esac
done

echo ""
info "Containers en estado starting (pueden tardar unos minutos):"
for container in $STARTING; do
  echo "  ⏳ $container"
done

echo ""
echo "─────────────────────────────────────"
echo "Para reiniciar un container específico:"
echo "  docker restart <nombre_container>"
echo ""
echo "Para ver logs en tiempo real:"
echo "  docker logs -f <nombre_container>"
echo ""
