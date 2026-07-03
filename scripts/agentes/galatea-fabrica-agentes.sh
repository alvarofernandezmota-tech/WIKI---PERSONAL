#!/usr/bin/env bash
# ============================================================
# NOMBRE:   scripts/agentes/galatea-fabrica-agentes.sh
# VERSION:  1.0.0
# FUNCIÓN:  Fábrica de agentes bash con plantilla estándar.
#           Genera agentes nuevos con estructura, cabecera,
#           bloques y documentación consistentes.
# AUTOR:    yggdrasil-dew ecosystem (Galatea)
# REPO:     alvarofernandezmota-tech/yggdrasil-dew
# USO:      bash scripts/agentes/galatea-fabrica-agentes.sh <nombre> <funcion> [tipo]
# TIPOS:    auditor | gestor | reporter | orquestador | vigilante
# ============================================================
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}}")/../../" && pwd)"
NOMBRE="${1:-}"
FUNCION="${2:-}"
TIPO="${3:-auditor}"
TS="$(date +%Y-%m-%d)"

if [ -z "$NOMBRE" ] || [ -z "$FUNCION" ]; then
  echo "USO: $0 <nombre> <funcion> [tipo]"
  echo "TIPOS: auditor | gestor | reporter | orquestador | vigilante"
  exit 1
fi

NOMBRE_LOWER="$(echo "$NOMBRE" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"
DESTINO="$ROOT/scripts/agentes/$NOMBRE_LOWER.sh"

if [ -f "$DESTINO" ]; then
  echo "[WARN] Ya existe: $DESTINO"
  read -r -p "¿Sobreescribir? [s/N] " resp
  [[ "$resp" =~ ^[sS]$ ]] || exit 0
fi

cat > "$DESTINO" << TEMPLATE
#!/usr/bin/env bash
# ============================================================
# NOMBRE:   scripts/agentes/$NOMBRE_LOWER.sh
# VERSION:  1.0.0
# FUNCIÓN:  $FUNCION
# TIPO:     $TIPO
# CREADO:   $TS por Galatea (galatea-fabrica-agentes.sh)
# REPO:     alvarofernandezmota-tech/yggdrasil-dew
# USO:      bash scripts/agentes/$NOMBRE_LOWER.sh
# ============================================================
set -euo pipefail

ROOT="\$(cd "\$(dirname "\${BASH_SOURCE[0]}")/../../" && pwd)"
INBOX="\$ROOT/inbox"
DIARY="\$ROOT/diary"
TS="\$(date +%Y%m%d-%H%M%S)"
LOG="\$INBOX/$NOMBRE_LOWER-\$TS.log"
mkdir -p "\$INBOX" "\$DIARY"

log() { echo "[\$(date +%H:%M:%S)] [$NOMBRE_LOWER] \$*" | tee -a "\$LOG"; }

log "=== $NOMBRE_LOWER v1.0 INICIO ==="

# ── VALIDACIÓN ────────────────────────────────────────────
log "Validando entorno..."
[ -d "\$ROOT/docs" ] || { log "ERROR: docs/ no encontrado"; exit 1; }

# ── LÓGICA PRINCIPAL ──────────────────────────────────────
# TODO: Implementar lógica de: $FUNCION
log "Ejecutando: $FUNCION"

# ── DOCUMENTAR RESULTADO ──────────────────────────────────
log "=== $NOMBRE_LOWER COMPLETADO ==="
echo "  → Log: \$LOG"
TEMPLATE

chmod +x "$DESTINO"
echo "[OK] Agente generado: scripts/agentes/$NOMBRE_LOWER.sh"
echo "  Función: $FUNCION"
echo "  Tipo: $TIPO"
echo "  Siguiente paso: implementar lógica en sección TODO"
