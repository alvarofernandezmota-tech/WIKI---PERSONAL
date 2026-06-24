#!/bin/bash
# batcueva-state.sh — Estado idempotente completo de Madre
# Ejecutar en cualquier momento. Detecta qué falta y lo levanta.
# Uso: bash setup/servidor/scripts/batcueva-state.sh [--fase 1|2|3]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(dirname "$SCRIPT_DIR")"
FASE_OBJETIVO="${1:-all}"

# Colores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log()  { echo -e "${GREEN}[STATE]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
fail() { echo -e "${RED}[FAIL]${NC} $1"; exit 1; }

# ─────────────────────────────────────────
# CHECKS PREVIOS
# ─────────────────────────────────────────
check_docker() {
  docker info &>/dev/null || fail "Docker no está corriendo. Ejecuta: sudo systemctl start docker"
  log "Docker OK"
}

check_network() {
  docker network inspect batcueva &>/dev/null || {
    log "Creando red batcueva..."
    docker network create batcueva
  }
  log "Red batcueva OK"
}

check_env() {
  ENV_FILE="$BASE_DIR/.env"
  if [[ ! -f "$ENV_FILE" ]]; then
    warn ".env no encontrado. Copiando plantilla..."
    cp "$BASE_DIR/.env.plantilla" "$ENV_FILE"
    warn "Edita $ENV_FILE con tus valores reales antes de continuar."
    exit 1
  fi
  log ".env OK"
}

# ─────────────────────────────────────────
# ESTADO DE SERVICIOS
# ─────────────────────────────────────────
is_running() {
  docker ps --format '{{.Names}}' | grep -q "^$1$"
}

check_service() {
  local name=$1
  local port=$2
  if is_running "$name"; then
    log "  ✅ $name ($port)"
    return 0
  else
    warn "  ❌ $name ($port) — no está corriendo"
    return 1
  fi
}

# ─────────────────────────────────────────
# FASES
# ─────────────────────────────────────────
fase1() {
  log "\n── FASE 1: Ollama + Open WebUI + Qdrant ──"
  local all_ok=true

  check_service ollama     ":11434" || all_ok=false
  check_service open-webui ":3001"  || all_ok=false
  check_service qdrant     ":6333"  || all_ok=false

  if [[ "$all_ok" == false ]]; then
    log "Levantando Fase 1..."
    docker compose -f "$BASE_DIR/docker-compose.yml" --env-file "$BASE_DIR/.env" up -d
    log "Fase 1 levantada"
  else
    log "Fase 1 ya estaba completa — nada que hacer"
  fi
}

fase2() {
  log "\n── FASE 2: Grafana + Prometheus + Portainer + Uptime Kuma ──"
  local all_ok=true

  check_service grafana      ":3000" || all_ok=false
  check_service prometheus   ":9090" || all_ok=false
  check_service portainer    ":9000" || all_ok=false
  check_service uptime-kuma  ":3002" || all_ok=false

  if [[ "$all_ok" == false ]]; then
    log "Levantando Fase 2..."
    docker compose -f "$BASE_DIR/batcueva-fase2.yml" --env-file "$BASE_DIR/.env" up -d
    log "Fase 2 levantada"
  else
    log "Fase 2 ya estaba completa — nada que hacer"
  fi
}

fase3() {
  log "\n── FASE 3: n8n + Paperless + Vaultwarden ──"
  local all_ok=true

  check_service n8n          ":5678" || all_ok=false
  check_service paperless    ":8010" || all_ok=false
  check_service vaultwarden  ":8888" || all_ok=false

  if [[ "$all_ok" == false ]]; then
    log "Levantando Fase 3..."
    docker compose -f "$BASE_DIR/batcueva-fase3.yml" --env-file "$BASE_DIR/.env" up -d
    log "Fase 3 levantada"
  else
    log "Fase 3 ya estaba completa — nada que hacer"
  fi
}

resumen() {
  log "\n── RESUMEN ESTADO MADRE ──"
  echo ""
  echo "  Servicio          Puerto   Estado"
  echo "  ─────────────────────────────────"
  for s in "ollama:11434" "open-webui:3001" "qdrant:6333" "grafana:3000" "prometheus:9090" "portainer:9000" "uptime-kuma:3002" "n8n:5678" "paperless:8010" "vaultwarden:8888"; do
    name="${s%%:*}"
    port="${s##*:}"
    if is_running "$name"; then
      printf "  %-18s :%-6s  ✅\n" "$name" "$port"
    else
      printf "  %-18s :%-6s  ❌\n" "$name" "$port"
    fi
  done
  echo ""
}

# ─────────────────────────────────────────
# MAIN
# ─────────────────────────────────────────
log "batcueva-state.sh — $(date '+%Y-%m-%d %H:%M:%S')"

check_docker
check_network
check_env

case "${FASE_OBJETIVO}" in
  --fase)
    FASE="${2:-all}"
    case "$FASE" in
      1) fase1 ;;
      2) fase1; fase2 ;;
      3) fase1; fase2; fase3 ;;
      *) fail "Fase desconocida: $FASE. Usa 1, 2 o 3" ;;
    esac
    ;;
  *)
    fase1
    fase2
    fase3
    ;;
esac

resumen
log "Estado verificado y aplicado ✅"
