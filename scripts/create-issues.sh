#!/usr/bin/env bash
# create-issues.sh
# Doc: docs/  <- COMPLETAR ruta al doc relacionado
# Fase: <- COMPLETAR fase
# Descripción: <- COMPLETAR
# =============================================================================
# create-issues.sh — Crea issues GitHub para todas las tareas pendientes
# Yggdrasil Dew · 2026-07-03
# Requisito: gh CLI autenticado (gh auth status)
# Uso: bash scripts/create-issues.sh [--dry-run]
# =============================================================================

set -euo pipefail

DRY_RUN=false
[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=true

REPO="alvarofernandezmota-tech/yggdrasil-dew"

log() { echo "[→] $*"; }
create_issue() {
  local title="$1" body="$2" labels="$3"
  if [[ "$DRY_RUN" == true ]]; then
    log "[DRY-RUN] Issue: $title"
    return
  fi
  gh issue create \
    --repo "$REPO" \
    --title "$title" \
    --body "$body" \
    --label "$labels" 2>/dev/null && log "✅ Creado: $title" || log "⚠ï¸ Ya existe o error: $title"
}

# Verificar gh CLI
if ! command -v gh &>/dev/null; then
  echo "❌ gh CLI no instalado. Instalar: https://cli.github.com"
  exit 1
fi

log "Creando issues para Fase 0 — Núcleo MCP..."

# FASE 0 — CRÍTICO
create_issue \
  "[FASE-0] Deploy MCP server Gen-3 en Madre" \
  "## Objetivo\nDesplegar el MCP server en Madre para que Cursor y agentes puedan ver el ecosistema real.\n\n## Pasos\n\`\`\`bash\ncd /srv/yggdrasil-dew && git pull\ncd agentes/mcp-server\ncp .env.example .env  # rellenar tokens\ndocker compose -f docker-compose.mcp.yml up -d --build\ncurl http://localhost:8765/health\n\`\`\`\n\n## Verificación\n- [ ] \`curl http://localhost:8765/health\` devuelve 200\n- [ ] \`check_docker\` tool responde desde Cursor\n- [ ] Audit log en \`/srv/logs/mcp-audit/\`\n\n## Ref\n- \`agentes/mcp-server/Dockerfile\`\n- \`agentes/mcp-server/docker-compose.mcp.yml\`\n- \`sesiones/MASTER-NEXT-SESSION.md\`" \
  "fase-0,prioridad-critica,agentes,mcp"

create_issue \
  "[FASE-0] Configurar Cursor con madre-ecosystem MCP" \
  "## Objetivo\nCursor debe poder llamar tools del MCP server de Madre.\n\n## Pasos\nEditar \`.cursor/mcp.json\`:\n\`\`\`json\n{\n  \"mcpServers\": {\n    \"madre-ecosystem\": {\n      \"url\": \"http://MADRE_IP:8765/mcp\",\n      \"headers\": { \"Authorization\": \"Bearer TU_TOKEN\" }\n    }\n  }\n}\n\`\`\`\n\n## Verificación\n- [ ] Cursor muestra tools disponibles: check_docker, read_roadmap, get_ecosystem_state\n- [ ] Cursor puede responder \"hay X contenedores corriendo\" con datos reales" \
  "fase-0,prioridad-critica,cursor,mcp"

create_issue \
  "[FASE-0] Crear .env de Madre para MCP server" \
  "## Objetivo\nConfigurar secretos en Madre (NUNCA al repo).\n\n## Pasos\n\`\`\`bash\ncd /srv/yggdrasil-dew/agentes/mcp-server\ncp .env.example .env\n# Editar .env con valores reales:\n# MADRE_MCP_TOKEN=\$(openssl rand -hex 32)\n# GITHUB_TOKEN=tu-token\n# TELEGRAM_BOT_TOKEN=tu-token\n# TELEGRAM_CHAT_ID=tu-chat-id\n\`\`\`\n\n## IMPORTANTE\n- .env ya está en .gitignore\n- Guardar copia en gestor de contraseñas\n- Nunca pushear" \
  "fase-0,prioridad-critica,seguridad"

create_issue \
  "[FASE-0] Archivar scripts obsoletos" \
  "## Objetivo\nLimpiar scripts/archive/ con los obsoletos identificados.\n\n## Pasos\n\`\`\`bash\nbash scripts/audit-and-migrate.sh\n# O manualmente:\nmkdir -p scripts/archive\nmv scripts/inbox-cleanup-jun2024.sh scripts/archive/\nmv scripts/migrar-inbox.sh scripts/archive/\ngit add . && git commit -m 'chore(scripts): archivar obsoletos [AUTO]'\n\`\`\`\n\n## Scripts a archivar\n- inbox-cleanup-jun2024.sh (obsoleto 2024)\n- migrar-inbox.sh (duplicado de inbox-migrate.sh)" \
  "fase-0,prioridad-media,scripts,mantenimiento"

log ""
log "Creando issues para Fase 1 — Health Agent..."

create_issue \
  "[FASE-1] Containerizar health-agent y conectar al MCP" \
  "## Objetivo\nEl health-agent corre en Docker, lee del MCP server, alerta por Telegram.\n\n## Pasos\n- Crear Dockerfile para agentes/health-agent/\n- Añadir al docker-compose.agents.yml\n- Conectar al endpoint /health/evaluate del MCP\n- Probar primera alerta Telegram\n\n## Ref\n- \`agentes/health-agent/main.py\`\n- \`agentes/REGLAS-AGENTES.md\`" \
  "fase-1,prioridad-alta,agentes,docker"

create_issue \
  "[FASE-1] Crear n8n workflow ecosystem-snapshot" \
  "## Objetivo\nWorkflow n8n que cada 15 min recoge estado del ecosistema y alimenta al health-agent.\n\n## Flujo\n1. Cron trigger (cada 15 min)\n2. Docker API → estado contenedores\n3. HTTP ping → estado servicios\n4. GitHub API → estado workflows\n5. POST a health-agent /health/evaluate\n6. Si CRITICAL → Telegram\n\n## Ref\n- \`agentes/ecosystem-snapshot/\`\n- \`n8n/workflows/\` (a crear)" \
  "fase-1,prioridad-alta,n8n,agentes"

log ""
log "Creando issues para Fase 2 — Orquestación..."

create_issue \
  "[FASE-2] Implementar Gatekeeper-agent" \
  "## Objetivo\nEl gatekeeper orquesta todos los agentes y aplica las reglas de REGLAS-AGENTES.md.\n\n## Responsabilidades\n- Watcher del inbox/\n- Clasificar entradas por tipo\n- Delegar al agente correcto\n- Aplicar whitelist (config/whitelist.yaml)\n- Audit log de todas las delegaciones\n\n## Ref\n- \`agentes/REGLAS-AGENTES.md\`\n- \`agentes/mcp-server/config/whitelist.yaml\`\n- \`agentes/LABORATORIO-AGENTES.md\` § Gatekeeper" \
  "fase-2,prioridad-alta,agentes,gatekeeper"

create_issue \
  "[FASE-2] Formalizar inbox como sistema de entrada unificado" \
  "## Objetivo\nTodo lo que entra al ecosistema (Telegram, GitHub webhook, n8n, manual) pasa por inbox/.\n\n## Formato estándar\n\`\`\`yaml\n---\ntype: task|alert|report|research\ndate: YYYY-MM-DD\nsource: telegram|github|n8n|manual|perplexity\npriority: critical|high|medium|low\nstatus: pending|in-progress|done\nprocessed_by: gatekeeper-agent\n---\n\`\`\`\n\n## Fuentes a conectar\n- Telegram (guardianbot) → webhook → inbox/\n- GitHub Actions → webhook → inbox/\n- n8n cron → inbox/\n- Prometheus alertas → inbox/" \
  "fase-2,prioridad-alta,inbox,agentes"

create_issue \
  "[FASE-2] Configurar OTel Collector + Loki para trazas de agentes" \
  "## Objetivo\nObservabilidad completa: cada llamada de agente tiene traza con OTel.\n\n## Stack\n- OpenTelemetry Collector (docker)\n- Loki (logs estructurados)\n- Tempo (trazas)\n- Grafana (ya existe) → añadir datasources\n\n## Ref\n- \`agentes/mcp-server/requirements.txt\` (opentelemetry-sdk ya incluido)\n- \`agentes/LABORATORIO-AGENTES.md\` § Observabilidad" \
  "fase-2,prioridad-media,observabilidad,infra"

log ""
log "Creando issues para Fase 3 — Inteligencia completa..."

create_issue \
  "[FASE-3] Implementar docs-agent" \
  "## Objetivo\nEl docs-agent observa commits y genera resúmenes/documentación automáticamente.\n\n## Tareas [AUTO]\n- Resumen de commits del día\n- Actualización de CHANGELOG\n- Historial de sesiones\n- README actualizados\n\n## Tools MCP que usará\n- sync_repos (read)\n- generate_bot_report\n- create_issue\n- update_roadmap_task" \
  "fase-3,prioridad-media,agentes,docs"

create_issue \
  "[FASE-3] Sistema de evals para agentes" \
  "## Objetivo\nPruebas automáticas del comportamiento de agentes con fixtures reales.\n\n## Tipos\n- Unit evals: tool aislada → output esperado\n- Behavioral: snapshot → clasificación correcta\n- Regression: cambios no rompen comportamiento previo\n- Golden set: casos perfectos como referencia\n\n## Fixtures\n- agentes/evals/fixtures/snapshot_ok.json\n- agentes/evals/fixtures/snapshot_warn.json\n- agentes/evals/fixtures/snapshot_critical.json\n\n## Ref\n- \`agentes/LABORATORIO-AGENTES.md\` § Evals" \
  "fase-3,prioridad-media,agentes,testing"

create_issue \
  "[INFRA] Crear MCP server para isla yggdrasil-secops" \
  "## Objetivo\nCuando el MCP server de madre-ecosystem sea estable, crear una isla separada para secops.\n\n## Regla de isla\nCuando un servicio crece: se Dockeriza, se documenta, se enlaza con herramientas, se separa en repo o directorio propio.\n\n## Contenido isla secops-mcp\n- Tools: check_auth_log, check_ufw, run_osint_scan, check_fail2ban\n- Conectado al MCP gatekeeper principal\n- Repo: yggdrasil-secops\n\n## Ref\n- \`agentes/REGLAS-AGENTES.md\` § Regla de isla" \
  "fase-4,prioridad-baja,secops,islas"

log ""
log "✅ Issues creados. Ver en: https://github.com/$REPO/issues"