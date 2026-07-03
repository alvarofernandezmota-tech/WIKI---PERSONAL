#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# entrypoint.sh
# FUNCIÓN ÚNICA: Entrypoint para agentes en contenedor Docker

AGENT="${AGENT:-agente-meta-deep.sh}"
exec /agent/scripts/"$AGENT" "$@"
