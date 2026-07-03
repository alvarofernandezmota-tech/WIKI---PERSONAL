#!/usr/bin/env bash
# scripts/agentes/galatea-fabrica-agentes.sh
# Fábrica completa: crea DISEÑO.md, PROFILE.md, test.sh y script base para un agente nuevo
# Uso: bash scripts/agentes/galatea-fabrica-agentes.sh <nombre> <descripcion> <tipo>
#   tipo: auditor|gestor|reporter|orquestador|vigilante
set -euo pipefail

ROOT="${YGGDRASIL_ROOT:-$(cd "$(dirname "$0")/../.." && pwd)}"
NAME="${1:-agent-nuevo}"
DESC="${2:-Agente generado por Galatea}"
TIPO="${3:-auditor}"
DIR="$ROOT/agentes/$NAME"
SCRIPT="$ROOT/scripts/agentes/${NAME}.sh"

if [ -d "$DIR" ]; then
  echo "ERROR: El agente $NAME ya existe en $DIR" >&2
  exit 1
fi

mkdir -p "$DIR"

# ── DISEÑO.md ────────────────────────────────────────────────────────────────
cat > "$DIR/DISEÑO.md" << DISEÑO
# $NAME

## Identificador
- **Nombre**: $NAME
- **Tipo**: $TIPO
- **Descripción**: $DESC

## Rol
$DESC

## Entradas
- Variables de entorno: YGGDRASIL_ROOT
- Carpetas: ver script base

## Salidas
- Reportes en \`reports/$NAME/\`

## Tests mínimos
- \`agentes/$NAME/test.sh\` debe generar \`reports/$NAME/*.md\`

## Checklist de despliegue
- [ ] DISEÑO.md presente
- [ ] PROFILE.md con personalidad
- [ ] test.sh pasa en CI
DISEÑO

# ── PROFILE.md ───────────────────────────────────────────────────────────────
cat > "$DIR/PROFILE.md" << PROFILE
# Perfil de personalidad — $NAME

## Tono
Profesional, conciso, orientado a acción.

## Estilo
- Pasos numerados
- Propuestas concretas con impacto estimado
- Riesgos claramente señalados

## Límites
- No ejecutar cambios destructivos sin PR y aprobación humana
- Siempre generar reporte antes de cualquier acción

## Prompt base
Eres $NAME, un agente $TIPO del ecosistema Yggdrasil-Dew.
$DESC
Responde siempre en español, de forma concisa y con pasos numerados.
PROFILE

# ── test.sh ──────────────────────────────────────────────────────────────────
cat > "$DIR/test.sh" << 'TESTSH'
#!/usr/bin/env bash
set -euo pipefail
ROOT="${YGGDRASIL_ROOT:-/srv/yggdrasil-dew}"
AGENT_NAME="$(basename "$(dirname "$0")")"
REPORT_DIR="$ROOT/reports/$AGENT_NAME"
mkdir -p "$REPORT_DIR"
TS=$(date +"%Y%m%d-%H%M%S")
OUT="$REPORT_DIR/test-$TS.md"

echo "# test $AGENT_NAME run $TS" > "$OUT"
echo "- Agente detectado: $AGENT_NAME" >> "$OUT"

SCRIPT="$ROOT/scripts/agentes/${AGENT_NAME}.sh"
if [ -f "$SCRIPT" ]; then
  echo "- script base: OK" >> "$OUT"
else
  echo "- WARN: script base no encontrado: $SCRIPT" >> "$OUT"
fi

echo "RESULT: OK" >> "$OUT"
echo "$OUT"
TESTSH
chmod +x "$DIR/test.sh"

# ── Script base ───────────────────────────────────────────────────────────────
cat > "$SCRIPT" << SCRIPTBASE
#!/usr/bin/env bash
# scripts/agentes/$NAME.sh — generado por galatea-fabrica-agentes.sh
# $DESC
set -euo pipefail

ROOT="\${YGGDRASIL_ROOT:-/srv/yggdrasil-dew}"
TS=\$(date +"%Y%m%d-%H%M%S")
OUT="\$ROOT/reports/$NAME/run-\$TS.md"
mkdir -p "\$ROOT/reports/$NAME"

echo "# $NAME run \$TS" > "\$OUT"
echo "TODO: implementar lógica de $NAME" >> "\$OUT"
echo "RESULT: OK" >> "\$OUT"
echo "\$OUT"
SCRIPTBASE
chmod +x "$SCRIPT"

echo "✓ Agente $NAME creado en:"
echo "  $DIR/DISEÑO.md"
echo "  $DIR/PROFILE.md"
echo "  $DIR/test.sh"
echo "  $SCRIPT"
