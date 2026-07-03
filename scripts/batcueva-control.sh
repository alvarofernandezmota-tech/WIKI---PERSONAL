#!/bin/bash
# =============================================================
# batcueva-control.sh
# Control unificado de todos los stacks de la Batcueva
# Uso: ./scripts/batcueva-control.sh {up|down|status|logs} [stack]
# =============================================================

set -e

# Ir siempre a la raíz del repo
cd "$(git rev-parse --show-toplevel)" || { echo "ERROR: no es un repo git"; exit 1; }

STACKS=(osint pentest siem vuln)

status_all() {
  echo "\n=== BATCUEVA STATUS ==="
  docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}' 2>/dev/null || echo "Docker no disponible"
}

case "$1" in
  up)
    STACK="${2:-all}"
    if [ "$STACK" = "all" ]; then
      echo "🚀 Levantando toda la Batcueva..."
      # Prereq para SIEM
      sudo sysctl -w vm.max_map_count=262144 2>/dev/null || true
      docker compose -f docker/batcueva-master.yml up -d
    else
      echo "🚀 Levantando stack: $STACK"
      docker compose -f "docker/batcueva-${STACK}.yml" up -d
    fi
    ;;
  down)
    STACK="${2:-all}"
    if [ "$STACK" = "all" ]; then
      echo "🛑 Deteniendo toda la Batcueva..."
      docker compose -f docker/batcueva-master.yml down
    else
      echo "🛑 Deteniendo stack: $STACK"
      docker compose -f "docker/batcueva-${STACK}.yml" down
    fi
    ;;
  status)
    status_all
    ;;
  logs)
    SERVICE="${2:-}"
    if [ -z "$SERVICE" ]; then
      echo "Uso: $0 logs <nombre-servicio>"
      exit 1
    fi
    docker logs -f "$SERVICE"
    ;;
  restart)
    SERVICE="${2:-}"
    [ -z "$SERVICE" ] && { echo "Uso: $0 restart <servicio>"; exit 1; }
    docker restart "$SERVICE"
    ;;
  *)
    echo "Batcueva Control v1.0"
    echo "Uso: $0 {up|down|status|logs|restart} [stack|servicio]"
    echo ""
    echo "Stacks disponibles: ${STACKS[*]}"
    echo "Ejemplos:"
    echo "  $0 up              # Levanta todo"
    echo "  $0 up osint        # Solo stack OSINT"
    echo "  $0 down pentest    # Para stack pentest"
    echo "  $0 logs spiderfoot # Logs de SpiderFoot"
    echo "  $0 status          # Estado de todos los contenedores"
    exit 1
    ;;
esac
