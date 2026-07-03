#!/usr/bin/env bash
# ==============================================================================
# Yggdrasil-DEW - Ecosystem Snapshot Generator
# Rol: Genera JSON de estado del ecosistema → alimenta health-agent
# Trigger: cron cada 30min + GitHub Actions
# Salida: /tmp/ecosystem-snapshot.json + POST a health-agent:8001
# ==============================================================================

set -euo pipefail
# shellcheck source=scripts/lib/common.sh
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SOURCE_DIR}/lib/common.sh"

HEALTH_AGENT_URL="${HEALTH_AGENT_URL:-http://localhost:8001/health/evaluate}"
SNAPSHOT_FILE="/tmp/ecosystem-snapshot.json"
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

log "INFO" "Generando ecosystem snapshot: $TIMESTAMP"

# ── 1. Containers ─────────────────────────────────────────────────────────────
containers_json="[]"
if command -v docker &>/dev/null; then
    containers_json=$(docker ps -a --format '{{.Names}}|{{.Status}}' 2>/dev/null | while IFS='|' read -r name status; do
        if echo "$status" | grep -q "Up"; then
            state="running"
        elif echo "$status" | grep -q "Restarting"; then
            state="crash-loop"
        else
            state="stopped"
        fi
        printf '{"name":"%s","status":"%s","last_restart":null},' "$name" "$state"
    done | sed 's/,$//' | { printf '['; cat; printf ']'; })
fi

# ── 2. Services HTTP ──────────────────────────────────────────────────────────
check_service() {
    local name="$1"
    local url="$2"
    local start
    start=$(date +%s%3N)
    if curl -sf --max-time 5 "$url" > /dev/null 2>&1; then
        local end
        end=$(date +%s%3N)
        local lat=$((end - start))
        printf '{"name":"%s","reachable":true,"latency_ms":%s}' "$name" "$lat"
    else
        printf '{"name":"%s","reachable":false,"latency_ms":null}' "$name"
    fi
}

services_json=$(printf '[%s,%s,%s,%s]' \
    "$(check_service "ollama" "http://localhost:11434")" \
    "$(check_service "mcp-server" "http://localhost:8002/health")" \
    "$(check_service "uptime-kuma" "http://localhost:3001")" \
    "$(check_service "portainer" "http://localhost:9000")")

# ── 3. Workflows (últimos GitHub Actions) ─────────────────────────────────────
workflows_json="[]"
if command -v gh &>/dev/null; then
    workflows_json=$(gh run list --limit 5 --json name,status,createdAt \
        --jq '[.[] | {name: .name, last_run: .createdAt, status: .status}]' \
        2>/dev/null || echo "[]")
fi

# ── 4. Construir snapshot JSON ────────────────────────────────────────────────
cat > "$SNAPSHOT_FILE" << EOF
{
  "timestamp": "$TIMESTAMP",
  "containers": $containers_json,
  "services": $services_json,
  "workflows": $workflows_json,
  "notes": "Snapshot automático desde ecosystem-snapshot.sh [AUTO]"
}
EOF

log "INFO" "Snapshot generado en $SNAPSHOT_FILE"
log "INFO" "Containers: $(echo "$containers_json" | python3 -c 'import sys,json; print(len(json.load(sys.stdin)))' 2>/dev/null || echo '?')"
log "INFO" "Services: $(echo "$services_json" | python3 -c 'import sys,json; print(len(json.load(sys.stdin)))' 2>/dev/null || echo '?')"

# ── 5. Enviar al health-agent (si está disponible) ────────────────────────────
if [ "${YGG_DRY_RUN:-false}" = "true" ]; then
    log "DRY-RUN" "[NO ENVIADO] POST $HEALTH_AGENT_URL"
    cat "$SNAPSHOT_FILE"
else
    if curl -sf --max-time 10 "$HEALTH_AGENT_URL" \
        -H "Content-Type: application/json" \
        -d @"$SNAPSHOT_FILE" >> "$YGG_LOG_FILE" 2>&1; then
        log "INFO" "Snapshot enviado al health-agent correctamente."
    else
        log "WARN" "Health-agent no disponible. Snapshot guardado en $SNAPSHOT_FILE."
    fi
fi
