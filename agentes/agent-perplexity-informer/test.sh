#!/usr/bin/env bash
set -euo pipefail
DIR="$(dirname "$0")"
echo "[TEST] Verificando estructura de agent-perplexity-informer..."
[ -f "$DIR/DISEÑO.md" ]  && echo "  ✅ DISEÑO.md"  || { echo "  ❌ DISEÑO.md";  exit 1; }
[ -f "$DIR/PROFILE.md" ] && echo "  ✅ PROFILE.md" || { echo "  ❌ PROFILE.md"; exit 1; }
echo "[TEST] agent-perplexity-informer OK"
