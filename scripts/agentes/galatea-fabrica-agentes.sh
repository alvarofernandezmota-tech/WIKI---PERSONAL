#!/usr/bin/env bash
# scripts/agentes/galatea-fabrica-agentes.sh
# Fábrica: dado un nombre, genera agentes/<nombre>/ con PROFILE.md y test.sh
# Uso: bash galatea-fabrica-agentes.sh <nombre-agente> ["descripción"]
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
TPL_PROFILE="$ROOT/scripts/agentes/agent-templates/PROFILE-TEMPLATE.md"
TPL_TEST="$ROOT/scripts/agentes/agent-templates/TEST-TEMPLATE.sh"

NAME="${1:-}"
DESC="${2:-Agente generado por Galatea el $(date +%Y-%m-%d)}"

if [ -z "$NAME" ]; then
  echo "ERROR: Uso: $0 <nombre-agente> [descripción]" >&2
  exit 1
fi

DIR="$ROOT/agentes/$NAME"
if [ -d "$DIR" ]; then
  echo "WARN: $DIR ya existe, omitiendo creación"
  exit 0
fi

mkdir -p "$DIR"

# PROFILE.md
if [ -f "$TPL_PROFILE" ]; then
  sed "s/AGENT_NAME/$NAME/g; s/AGENT_DESC/$DESC/g" "$TPL_PROFILE" > "$DIR/PROFILE.md"
else
  cat > "$DIR/PROFILE.md" <<EOF
# Agente: $NAME
> $DESC

## Propósito
TODO: definir propósito del agente.

## Entradas
- TODO

## Salidas
- TODO

## Siguiente-paso
- [ ] Implementar lógica principal
EOF
fi

# test.sh
if [ -f "$TPL_TEST" ]; then
  sed "s/AGENT_NAME/$NAME/g" "$TPL_TEST" > "$DIR/test.sh"
else
  cat > "$DIR/test.sh" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
echo "[TEST] TODO: implementar tests para este agente"
EOF
fi
chmod +x "$DIR/test.sh"

echo "OK: agente $NAME creado en $DIR"
