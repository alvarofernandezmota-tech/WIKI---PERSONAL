#!/usr/bin/env bash
set -euo pipefail
DIR="$(dirname "$0")"
echo "[TEST] Verificando estructura de agent-ocr-auditor..."
[ -f "$DIR/DISEÑO.md" ]  && echo "  ✅ DISEÑO.md"  || { echo "  ❌ DISEÑO.md";  exit 1; }
[ -f "$DIR/PROFILE.md" ] && echo "  ✅ PROFILE.md" || { echo "  ❌ PROFILE.md"; exit 1; }
echo "[TEST] agent-ocr-auditor OK"
