#!/usr/bin/env bash
# =============================================================================
# issue-creator.sh
# Analiza el repo, detecta qué falta y crea issues automáticamente en GitHub.
# Se ejecuta vía GitHub Actions (issue-creator.yml) en bucle autónomo.
# NO genera código. Solo analiza y crea issues [AUTO].
# =============================================================================
set -euo pipefail

# --- Config ---
REPO="${GITHUB_REPOSITORY:-alvarofernandezmota-tech/yggdrasil-dew}"
TOKEN="${GITHUB_TOKEN:-}"
DRY_RUN="${DRY_RUN:-false}"
LOG_FILE="/tmp/issue-creator-$(date +%Y%m%d-%H%M%S).log"

log() { echo "[$(date +%H:%M:%S)] $*" | tee -a "$LOG_FILE"; }
error() { echo "[ERROR] $*" | tee -a "$LOG_FILE" >&2; }

create_issue() {
  local title="$1" body="$2" labels="${3:-auto,backlog}"

  if [[ "$DRY_RUN" == "true" ]]; then
    log "[DRY_RUN] Issue: $title"
    return 0
  fi

  local existing
  existing=$(gh issue list --repo "$REPO" --search "$title" --json number,title --limit 5 2>/dev/null || echo "[]")
  if echo "$existing" | grep -q "$title"; then
    log "SKIP: Issue ya existe: $title"
    return 0
  fi

  gh issue create \
    --repo "$REPO" \
    --title "$title" \
    --body "$body" \
    --label "$labels" 2>/dev/null && log "CREATED: $title" || error "FAILED: $title"
}

# =============================================================================
# ANALIZADORES
# =============================================================================

analizar_scripts_sin_doc() {
  log "Analizando scripts sin documentacion..."
  while IFS= read -r -d '' script; do
    local name
    name=$(basename "$script")
    if ! head -5 "$script" | grep -qiE '(description|desc|usage|#.*-{3,})'; then
      create_issue \
        "[AUTO][DOCS] Documentar script: $name" \
        "## Tarea automática\n\n El script \`$script\` no tiene cabecera de documentacion.\n\n**Accion:** Añadir bloque de comentarios con descripcion, uso y ejemplos.\n\n**Archivo:** \`$script\`\n\n*Generado por issue-creator.sh*" \
        "auto,documentacion,scripts"
    fi
  done < <(find scripts/ -name '*.sh' -o -name '*.py' -print0 2>/dev/null)
}

analizar_workflows_sin_descripcion() {
  log "Analizando workflows sin descripcion..."
  while IFS= read -r -d '' wf; do
    local name
    name=$(basename "$wf")
    if ! grep -q 'description:' "$wf" 2>/dev/null && ! head -5 "$wf" | grep -q '#.*[Dd]escripci'; then
      create_issue \
        "[AUTO][DOCS] Añadir descripcion a workflow: $name" \
        "## Tarea automática\n\nEl workflow \`$wf\` no tiene descripcion en cabecera.\n\n**Accion:** Añadir comentario \`# Descripcion:\` al inicio del fichero.\n\n*Generado por issue-creator.sh*" \
        "auto,documentacion,workflows"
    fi
  done < <(find .github/workflows/ -name '*.yml' -print0 2>/dev/null)
}

analizar_agentes_sin_spec() {
  log "Analizando agentes sin spec..."
  local agentes=("health-agent" "roadmap-agent" "docs-agent" "osint-agent" "security-agent" "obsidian-agent")
  for agente in "${agentes[@]}"; do
    if [[ ! -f "agentes/$agente/README.md" && ! -f "agentes/$agente/SPEC.md" ]]; then
      create_issue \
        "[AUTO][FASE3] Crear spec para: $agente" \
        "## Agente pendiente de especificacion\n\nEl agente \`$agente\` no tiene fichero de spec.\n\n**Accion:** Crear \`agentes/$agente/SPEC.md\` con:\n- Objetivo\n- Inputs/Outputs\n- Tools que usa\n- Trigger (cron/webhook)\n- Modelo LLM\n\n*Generado por issue-creator.sh*" \
        "auto,agentes,fase3"
    fi
  done
}

analizar_inbox_patrones() {
  log "Analizando patrones en inbox..."
  local count_md count_txt count_total
  count_md=$(find inbox/ -name '*.md' 2>/dev/null | wc -l)
  count_txt=$(find inbox/ -name '*.txt' 2>/dev/null | wc -l)
  count_total=$((count_md + count_txt))

  if [[ $count_total -gt 15 ]]; then
    create_issue \
      "[AUTO][INBOX] Inbox saturado: $count_total archivos pendientes" \
      "## Inbox con acumulacion\n\nHay $count_total archivos en inbox sin procesar.\n\n- .md: $count_md\n- .txt: $count_txt\n\n**Accion:** Revisar inbox-processor y autonomous-cron.\n\n*Generado por issue-creator.sh*" \
      "auto,inbox,alerta"
  fi

  # Detecta patrones repetidos (mismo prefijo 3+ veces)
  local prefijos
  prefijos=$(find inbox/ -maxdepth 1 -name '*.md' 2>/dev/null | sed 's|inbox/||;s|-[0-9].*||;s|_[0-9].*||' | sort | uniq -c | sort -rn | awk '$1>=3{print $2}' | head -5)
  if [[ -n "$prefijos" ]]; then
    create_issue \
      "[AUTO][INBOX] Patrones repetidos detectados en inbox" \
      "## Tareas repetidas detectadas\n\nSe detectaron estos patrones que aparecen 3+ veces:\n\n\`\`\`\n$prefijos\`\`\`\n\n**Accion:** Considerar automatizar o crear template para estos tipos.\n\n*Generado por issue-creator.sh*" \
      "auto,inbox,optimizacion"
  fi
}

analizar_scripts_repetitivos() {
  log "Analizando patrones repetitivos en scripts..."
  # Busca funciones duplicadas entre scripts
  local funcs_duplicadas
  funcs_duplicadas=$(grep -rh '^[a-z_]\+()' scripts/ 2>/dev/null | sort | uniq -d | head -10)
  if [[ -n "$funcs_duplicadas" ]]; then
    create_issue \
      "[AUTO][REFACTOR] Funciones duplicadas en scripts" \
      "## Funciones repetidas detectadas\n\nEstas funciones aparecen en más de un script:\n\n\`\`\`\n$funcs_duplicadas\`\`\`\n\n**Accion:** Extraer a \`scripts/lib/common.sh\` como libreria compartida.\n\n*Generado por issue-creator.sh*" \
      "auto,refactor,scripts"
  fi

  # Busca scripts sin chmod +x
  while IFS= read -r -d '' script; do
    if [[ ! -x "$script" ]]; then
      create_issue \
        "[AUTO][OPS] Script sin permisos de ejecucion: $(basename $script)" \
        "## Script no ejecutable\n\n\`$script\` no tiene \`chmod +x\`.\n\n**Accion:** \`chmod +x $script\`\n\n*Generado por issue-creator.sh*" \
        "auto,ops,scripts"
    fi
  done < <(find scripts/ -name '*.sh' -print0 2>/dev/null)
}

analizar_roadmap_bloqueados() {
  log "Analizando tareas bloqueadas en ROADMAP..."
  if [[ -f "ROADMAP-MASTER.md" ]]; then
    local bloqueadas
    bloqueadas=$(grep -n '\[BLOCKED\]\|\[RISKY\]\|\[HUMAN\]' ROADMAP-MASTER.md 2>/dev/null | head -10)
    if [[ -n "$bloqueadas" ]]; then
      create_issue \
        "[AUTO][ROADMAP] Tareas bloqueadas o en espera humana" \
        "## Tareas que necesitan atención\n\nSe encontraron tareas marcadas como BLOCKED/RISKY/HUMAN en el ROADMAP:\n\n\`\`\`\n$bloqueadas\`\`\`\n\n**Accion:** Revisar y desbloquear o asignar.\n\n*Generado por issue-creator.sh*" \
        "auto,roadmap,atencion-humana"
    fi
  fi
}

# =============================================================================
# MAIN
# =============================================================================
main() {
  log "=== issue-creator.sh iniciado ==="
  log "Repo: $REPO | DRY_RUN: $DRY_RUN"

  analizar_scripts_sin_doc
  analizar_workflows_sin_descripcion
  analizar_agentes_sin_spec
  analizar_inbox_patrones
  analizar_scripts_repetitivos
  analizar_roadmap_bloqueados

  log "=== issue-creator.sh completado ==="
}

main "$@"
