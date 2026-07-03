#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# =============================================================================
# Nombre:       agente-deuda-registra.sh
# Función única: Lee reports de inbox/deuda/ y abre issues en GitHub con labels correctos
# Rol:          registrador
# Versión:      1.0
# Autor:        Perplexity-MCP <alvarofernandezmota@gmail.com>
# Creado:       2026-07-03 23:55 CEST
# Actualizado:  2026-07-03 23:55 CEST
# Ruta:         scripts/agentes/agente-deuda-registra.sh
# Tags:         [deuda-tecnica, github-issues, registrador]
# Flags:
#   --dry-run   Simula sin abrir issues reales
#   --verbose   Log detallado
#   --in DIR    Directorio de entrada (default: inbox/deuda/)
# =============================================================================

IN_DIR="${IN_DIR:-inbox/deuda}"
DRY_RUN=false
VERBOSE=false

log(){ printf '%s %s\n' "$(date -u +'%Y-%m-%dT%H:%M:%SZ')" "$*"; }
on_err(){ log "ERROR at line $1"; exit 2; }
trap 'on_err $LINENO' ERR

while [[ "${1:-}" != "" ]]; do
  case "$1" in
    --dry-run) DRY_RUN=true; shift ;;
    --verbose) VERBOSE=true; shift ;;
    --in) IN_DIR="$2"; shift 2 ;;
    *) shift ;;
  esac
done

# Mapeo categoría → label GitHub
categoria_to_label(){
  case "$1" in
    duplicados)     echo "duplicado,deuda-tecnica" ;;
    sin-shebang)    echo "deuda-tecnica,sin-docs" ;;
    sin-strict)     echo "deuda-tecnica" ;;
    sin-cabecera)   echo "deuda-tecnica,sin-docs" ;;
    sin-tests)      echo "sin-tests,deuda-tecnica" ;;
    todos-fixmes)   echo "deuda-tecnica" ;;
    archivos-vacios) echo "deuda-tecnica,bug" ;;
    sin-docs)       echo "sin-docs,deuda-tecnica" ;;
    links-rotos)    echo "bug,deuda-tecnica" ;;
    *)              echo "deuda-tecnica" ;;
  esac
}

prioridad_to_label(){
  case "$1" in
    ALTA)   echo "prioridad-alta" ;;
    MEDIA)  echo "prioridad-media" ;;
    BAJA)   echo "prioridad-baja" ;;
    *)      echo "prioridad-media" ;;
  esac
}

main(){
  log "agente-deuda-registra iniciado"

  if ! command -v gh >/dev/null 2>&1; then
    log "ERROR: gh CLI no disponible. Instala: https://cli.github.com"
    exit 1
  fi

  if [[ -z "${GITHUB_TOKEN:-}" ]] && ! gh auth status >/dev/null 2>&1; then
    log "ERROR: no autenticado en gh CLI. Ejecuta: gh auth login"
    exit 1
  fi

  local count=0
  for report in "$IN_DIR"/*.json; do
    [[ -f "$report" ]] || continue
    total=$(jq '.total' "$report" 2>/dev/null || echo 0)
    $VERBOSE && log "Procesando $report ($total items)"

    while IFS= read -r item; do
      cat=$(echo "$item" | jq -r '.categoria')
      archivo=$(echo "$item" | jq -r '.archivo')
      mensaje=$(echo "$item" | jq -r '.mensaje')
      prioridad=$(echo "$item" | jq -r '.prioridad')

      labels=$(categoria_to_label "$cat")
      prio_label=$(prioridad_to_label "$prioridad")
      all_labels="${labels},${prio_label},por-hacer"

      title="[deuda-tecnica] ${cat}: ${archivo}"
      body=$(cat <<EOF
## Deuda técnica detectada automáticamente

**Categoría:** \`${cat}\`
**Archivo:** \`${archivo}\`
**Problema:** ${mensaje}
**Prioridad:** ${prioridad}
**Detectado por:** agente-deuda-detecta.sh
**Report:** \`${report}\`

### Cómo resolver
\`\`\`bash
bash scripts/agentes/terminal-logger.sh --label "fix-${cat}" -- \\
  bash scripts/agentes/agente-deuda-migra.sh --target "${archivo}" --verbose
\`\`\`

### Protocolo ELO de validación
1. E — Ejecutar con --dry-run y verificar output
2. L — Leer output en inbox/terminal-log/
3. O — Operar con --apply si L pasa
EOF
)

      if $DRY_RUN; then
        log "[DRY-RUN] Abriría issue: $title (labels: $all_labels)"
      else
        gh issue create \
          --title "$title" \
          --body "$body" \
          --label "${all_labels}" 2>/dev/null || \
          log "WARN: no se pudo abrir issue para $archivo (¿labels no existen?)"
        count=$((count+1))
      fi
    done < <(jq -c '.items[]' "$report" 2>/dev/null)
  done

  log "Issues creados: $count"
  log "agente-deuda-registra finalizado"
}

main "$@"
