#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# FUNCIÓN: Galatea — generador de islas y bots con personalidad
# Crea ficheros de diseño narrativo para islas y bots del ecosistema
# Uso: ./galatea-islas-bots.sh isla <nombre> "<objetivo>"
#       ./galatea-islas-bots.sh bot <nombre> "<rol>"
# ============================================================

ROOT="/srv/yggdrasil-dew"
ISLAS_DIR="$ROOT/islas"
BOT_DIR="$ROOT/agentes/bots"

log() { echo "[$(date +"%H:%M:%S")] $*"; }
ensure_dir() { mkdir -p "$1"; }

usage() {
  cat <<EOF
Uso: $0 isla <nombre> "<objetivo>" | bot <nombre> "<rol>"

Ejemplos:
  $0 isla ISLA-AGENTES "Diseñar y mejorar agentes del ecosistema"
  $0 bot BOT-GALATEA "Generador de agentes y bots"
EOF
}

[ $# -lt 3 ] && usage && exit 1

TIPO="$1"
NOMBRE="$2"
DESCRIP="$3"

case "$TIPO" in
  isla)
    ensure_dir "$ISLAS_DIR"
    DEST="$ISLAS_DIR/$NOMBRE.md"
    log "Creando isla $NOMBRE"

    cat > "$DEST" <<EOF
# $NOMBRE

## Objetivo
$DESCRIP

## Estado
EN-DISEÑO

## Siguiente-paso
- Definir agentes asociados
- Definir herramientas MCP necesarias
- Conectar con orquestador-total y agent-meta-deep

## Contexto
Esta isla forma parte de la capa Galatea: diseño y evolución de agentes y bots.
EOF
    ;;

  bot)
    ensure_dir "$BOT_DIR"
    DEST="$BOT_DIR/$NOMBRE.md"
    log "Creando bot $NOMBRE"

    cat > "$DEST" <<EOF
# $NOMBRE

## Rol
$DESCRIP

## Personalidad
- Foco en diseño de agentes y herramientas
- Busca huecos en el ecosistema
- Propone mejoras incrementales

## Entradas
- Reports de agent-meta-deep
- CORE-ECOSISTEMA
- Reports de orquestador-total

## Salidas
- Propuestas de nuevos agentes
- Propuestas de nuevos scripts
- Propuestas de nuevos workflows

## Integración
- MCP tool \`agent_meta_deep\`
- MCP tool \`orquestador_total\`
EOF
    ;;

  *)
    usage
    exit 1
    ;;
esac

log "$TIPO $NOMBRE creado."
