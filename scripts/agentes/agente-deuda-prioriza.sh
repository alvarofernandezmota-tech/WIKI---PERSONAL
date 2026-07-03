#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# =============================================================================
# Nombre:       agente-deuda-prioriza.sh
# Función única: Lee reports de inbox/deuda/ y genera ranking priorizado de deuda
# Rol:          planificador
# Versión:      1.0
# Autor:        Perplexity-MCP <alvarofernandezmota@gmail.com>
# Creado:       2026-07-03 23:55 CEST
# Actualizado:  2026-07-03 23:55 CEST
# Ruta:         scripts/agentes/agente-deuda-prioriza.sh
# Tags:         [deuda-tecnica, planificador, prioridad]
# Flags:
#   --in DIR    Directorio de entrada (default: inbox/deuda/)
#   --out DIR   Directorio de salida (default: inbox/deuda/)
#   --verbose   Log detallado
# =============================================================================

IN_DIR="${IN_DIR:-inbox/deuda}"
OUT_DIR="${OUT_DIR:-inbox/deuda}"
VERBOSE=false

log(){ printf '%s %s\n' "$(date -u +'%Y-%m-%dT%H:%M:%SZ')" "$*"; }
on_err(){ log "ERROR at line $1"; exit 2; }
trap 'on_err $LINENO' ERR

while [[ "${1:-}" != "" ]]; do
  case "$1" in
    --in) IN_DIR="$2"; shift 2 ;;
    --out) OUT_DIR="$2"; shift 2 ;;
    --verbose) VERBOSE=true; shift ;;
    *) shift ;;
  esac
done

mkdir -p "$OUT_DIR"
TS=$(date -u +'%Y%m%dT%H%M%SZ')
RANKING="$OUT_DIR/${TS}-deuda-ranking.md"

# Pesos por categoría (mayor = más urgente)
weight(){
  case "$1" in
    duplicados)     echo 100 ;;
    archivos-vacios) echo 90 ;;
    sin-shebang)    echo 80 ;;
    sin-strict)     echo 80 ;;
    sin-cabecera)   echo 60 ;;
    links-rotos)    echo 60 ;;
    sin-tests)      echo 50 ;;
    sin-docs)       echo 40 ;;
    todos-fixmes)   echo 20 ;;
    *)              echo 10 ;;
  esac
}

# Pesos por prioridad
prio_weight(){
  case "$1" in
    ALTA)  echo 3 ;;
    MEDIA) echo 2 ;;
    BAJA)  echo 1 ;;
    *)     echo 1 ;;
  esac
}

main(){
  log "agente-deuda-prioriza iniciado"

  local items_json="[]"
  for report in "$IN_DIR"/*-deuda-detectada.json; do
    [[ -f "$report" ]] || continue
    items_json=$(jq -s '.[0] + .[1]' <(echo "$items_json") <(jq '.items' "$report") 2>/dev/null || echo "[]")
  done

  local total
  total=$(echo "$items_json" | jq 'length')
  log "Total items a priorizar: $total"

  # Generar ranking en Markdown
  {
    echo "---"
    echo "tipo: ranking-deuda"
    echo "autor: agente-deuda-prioriza"
    echo "ts: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
    echo "total: $total"
    echo "---"
    echo ""
    echo "# 📊 Ranking de Deuda Técnica"
    echo ""
    echo "Generado: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
    echo "Total items: $total"
    echo ""
    echo "## 🔴 ALTA prioridad"
    echo ""
    echo "| Score | Categoría | Archivo | Mensaje |"
    echo "|---|---|---|---|"

    while IFS= read -r item; do
      cat=$(echo "$item" | jq -r '.categoria')
      archivo=$(echo "$item" | jq -r '.archivo')
      mensaje=$(echo "$item" | jq -r '.mensaje')
      prio=$(echo "$item" | jq -r '.prioridad')
      if [[ "$prio" == "ALTA" ]]; then
        w=$(weight "$cat")
        pw=$(prio_weight "$prio")
        score=$((w * pw))
        echo "| $score | \`$cat\` | \`$archivo\` | $mensaje |"
      fi
    done < <(echo "$items_json" | jq -c '.[]')

    echo ""
    echo "## 🟡 MEDIA prioridad"
    echo ""
    echo "| Score | Categoría | Archivo | Mensaje |"
    echo "|---|---|---|---|"

    while IFS= read -r item; do
      cat=$(echo "$item" | jq -r '.categoria')
      archivo=$(echo "$item" | jq -r '.archivo')
      mensaje=$(echo "$item" | jq -r '.mensaje')
      prio=$(echo "$item" | jq -r '.prioridad')
      if [[ "$prio" == "MEDIA" ]]; then
        w=$(weight "$cat")
        pw=$(prio_weight "$prio")
        score=$((w * pw))
        echo "| $score | \`$cat\` | \`$archivo\` | $mensaje |"
      fi
    done < <(echo "$items_json" | jq -c '.[]')

    echo ""
    echo "## ⚪ BAJA prioridad"
    echo ""
    echo "| Score | Categoría | Archivo | Mensaje |"
    echo "|---|---|---|---|"

    while IFS= read -r item; do
      cat=$(echo "$item" | jq -r '.categoria')
      archivo=$(echo "$item" | jq -r '.archivo')
      mensaje=$(echo "$item" | jq -r '.mensaje')
      prio=$(echo "$item" | jq -r '.prioridad')
      if [[ "$prio" == "BAJA" ]]; then
        w=$(weight "$cat")
        pw=$(prio_weight "$prio")
        score=$((w * pw))
        echo "| $score | \`$cat\` | \`$archivo\` | $mensaje |"
      fi
    done < <(echo "$items_json" | jq -c '.[]')

  } > "$RANKING"

  log "Ranking guardado → $RANKING"
  log "agente-deuda-prioriza finalizado"
}

main "$@"
