#!/usr/bin/env bash
# scripts/agentes/galatea-fabrica-agentes.sh — Fábrica completa de agentes
set -euo pipefail

NOMBRE="${1:-agent-nuevo}"
DESCRIPCION="${2:-Agente generado por Galatea}"
ROL="${3:-generico}"

ROOT="${YGGDRASIL_ROOT:-$(pwd)}"
AGENT_DIR="$ROOT/agentes/$NOMBRE"

if [ -d "$AGENT_DIR" ]; then
  echo "[ERROR] El agente $NOMBRE ya existe en $AGENT_DIR"
  exit 1
fi

mkdir -p "$AGENT_DIR"

# DISEÑO.md
cat > "$AGENT_DIR/DISEÑO.md" <<EOF
# $NOMBRE

## Descripción
$DESCRIPCION

## Rol
$ROL

## Responsabilidades
- [ ] Definir responsabilidades específicas
- [ ] Integrar con MCP server
- [ ] Conectar con llm-router si aplica

## Entradas
- Archivos de inbox/
- Contexto de COPILOT-CONTEXT.md

## Salidas
- reports/$NOMBRE/
- inbox/context/

## Dependencias
- scripts/agentes/llm-router.sh
- mcp/server.py
EOF

# PROFILE.md (personalidad y memoria)
cat > "$AGENT_DIR/PROFILE.md" <<EOF
# Perfil — $NOMBRE

## Tono
Técnico, preciso, sin adornos.

## Estilo
Respuestas estructuradas con bullets y código cuando aplica.

## Límites
- No ejecutar acciones destructivas sin aprobación humana
- No enviar PII a modelos externos
- Crear PR en modo draft para cambios significativos

## PII a enmascarar
- Emails → [REDACTED_EMAIL]
- API keys → [REDACTED_KEY]
- Tokens → Bearer [REDACTED]

## Ejemplos de prompts
- "Audita el estado de $NOMBRE y genera un reporte"
- "Sugiere mejoras para $NOMBRE con diffs"
EOF

# test.sh
cat > "$AGENT_DIR/test.sh" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
DIR="$(dirname "$0")"
echo "[TEST] Verificando estructura de $(basename "$DIR")..."
[ -f "$DIR/DISEÑO.md" ]  && echo "  ✅ DISEÑO.md" || { echo "  ❌ DISEÑO.md"; exit 1; }
[ -f "$DIR/PROFILE.md" ] && echo "  ✅ PROFILE.md" || { echo "  ❌ PROFILE.md"; exit 1; }
echo "[TEST] OK"
EOF
chmod +x "$AGENT_DIR/test.sh"

# Script del agente en scripts/agentes/
SCRIPT="$ROOT/scripts/agentes/$NOMBRE.sh"
cat > "$SCRIPT" <<EOF
#!/usr/bin/env bash
# scripts/agentes/$NOMBRE.sh — $DESCRIPCION
set -euo pipefail

ROOT="\${YGGDRASIL_ROOT:-\$(pwd)}"
REPORT_DIR="\$ROOT/reports/$NOMBRE"
mkdir -p "\$REPORT_DIR"

TS=\$(date +"%Y%m%d-%H%M%S")
OUT="\$REPORT_DIR/$NOMBRE-\$TS.md"

echo "# $NOMBRE — \$TS" > "\$OUT"
echo "$DESCRIPCION" >> "\$OUT"
echo "\$OUT"
EOF
chmod +x "$SCRIPT"

# Registrar en REGISTRO-HERRAMIENTAS.md
REGISTRO="$ROOT/docs/REGISTRO-HERRAMIENTAS.md"
mkdir -p "$ROOT/docs"
[ -f "$REGISTRO" ] || echo "# Registro de Herramientas\n" > "$REGISTRO"
echo "- **$NOMBRE** — $DESCRIPCION (rol: $ROL) — $(date +%Y-%m-%d)" >> "$REGISTRO"

echo "[Galatea] Agente '$NOMBRE' creado en $AGENT_DIR"
echo "  Script: $SCRIPT"
echo "  Test:   $AGENT_DIR/test.sh"
