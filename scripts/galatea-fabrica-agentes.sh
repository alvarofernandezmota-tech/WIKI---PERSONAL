#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# FUNCIÓN: Fábrica de agentes Galatea
# Crea DISEÑO.md + script base para un nuevo agente del ecosistema
# Uso: ./galatea-fabrica-agentes.sh <nombre> "<rol>" "<scope>" "<tags>"
# ============================================================

ROOT="/srv/yggdrasil-dew"
AGENTES_DIR="$ROOT/agentes"
REGISTRO="$ROOT/docs/REGISTRO-HERRAMIENTAS.md"

log() { echo "[$(date +"%H:%M:%S")] $*"; }
ensure_dir() { mkdir -p "$1"; }

usage() {
  cat <<EOF
Uso: $0 <nombre-agente> "<rol>" "<scope>" "<tags>"

Ejemplo:
  $0 agent-docs "Sincroniza documentación" "docs" "docs,sync"
EOF
}

[ $# -lt 4 ] && usage && exit 1

NOMBRE="$1"
ROL="$2"
SCOPE="$3"
TAGS="$4"

DEST="$AGENTES_DIR/$NOMBRE"
ensure_dir "$DEST"

DISENO="$DEST/DISENO.md"
SCRIPT="$ROOT/scripts/$NOMBRE.sh"

log "Creando agente $NOMBRE en $DEST"

cat > "$DISENO" <<EOF
# $NOMBRE

## Rol
$ROL

## Scope
$SCOPE

## Entradas
- Archivos relevantes en el scope: $SCOPE
- Estado actual del ecosistema

## Salidas
- Reportes en /reports/$NOMBRE
- Actualizaciones en las rutas correspondientes

## Límites
- No modifica CORE-ECOSISTEMA directamente
- No borra archivos sin pasar por inbox/archive

## Triggers
- Workflow dedicado
- Orquestador total
- MCP tool \`$NOMBRE\`

## Tags
$TAGS
EOF

cat > "$SCRIPT" <<'SCRIPTEOF'
#!/usr/bin/env bash
set -euo pipefail

ROOT="/srv/yggdrasil-dew"
TIMESTAMP=$(date +"%Y%m%d-%H%M")
NAME="$(basename "$0" .sh)"
REPORT_DIR="$ROOT/reports/$NAME"

mkdir -p "$REPORT_DIR"
REPORT="$REPORT_DIR/$NAME-$TIMESTAMP.md"

log() { echo "[$(date +"%H:%M:%S")] $*"; }

echo "# $NAME — ejecución — $TIMESTAMP" > "$REPORT"
echo "" >> "$REPORT"

# TODO: lógica específica del agente
echo "- Agente $NAME ejecutado. Falta implementar lógica específica." >> "$REPORT"

log "Agente $NAME completado: $REPORT"
SCRIPTEOF

chmod +x "$SCRIPT"

log "Actualizando registro de herramientas: $REGISTRO"

ensure_dir "$(dirname "$REGISTRO")"
echo "- $NOMBRE: rol=$ROL, scope=$SCOPE, tags=$TAGS, script=scripts/$NOMBRE.sh" >> "$REGISTRO"

log "Agente $NOMBRE creado con DISENO.md y script base."
