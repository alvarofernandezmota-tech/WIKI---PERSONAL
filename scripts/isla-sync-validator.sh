#!/usr/bin/env bash
# FUNCIÓN:   Validar que MAPA-ISLAS.md refleja la estructura real del repo
# TRIGGER:   Push, cron diario
# AGENTE:    isla-sync-validator
# ETIQUETAS: estructura, islas
# RUTAS:     islas/, MAPA-ISLAS.md
set -euo pipefail

ROOT="${YGGDRASIL_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || echo '.')}"
MAPA="$ROOT/MAPA-ISLAS.md"
DATE=$(date +%Y-%m-%d)
MISMATCH=0

if [ ! -f "$MAPA" ]; then
  echo "[isla-sync-validator] MAPA-ISLAS.md no encontrado → saltando"
  exit 0
fi

# Islas reales en disco
REAL_ISLAS=$(find "$ROOT/islas" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | xargs -I{} basename {} | sort || echo "")

# Islas documentadas en MAPA-ISLAS.md
DOC_ISLAS=$(grep -oP '(?<=## )[A-Za-z0-9_-]+' "$MAPA" | sort || echo "")

# Comparar
DIFF=$(diff <(echo "$REAL_ISLAS") <(echo "$DOC_ISLAS") || true)

if [ -n "$DIFF" ]; then
  MISMATCH=1
  echo "[isla-sync-validator] Desincronización detectada:"
  echo "$DIFF"
  command -v gh &>/dev/null && gh issue create \
    --title "[ISLAS] MAPA-ISLAS.md desincronizado con la realidad" \
    --label "estructura,islas" \
    --body "isla-sync-validator detectó diferencias el $DATE:\n\n\`\`\`\n$DIFF\n\`\`\`\n\nActualizar \`MAPA-ISLAS.md\` para que refleje la realidad." 2>/dev/null || true
else
  echo "[isla-sync-validator] ✅ MAPA-ISLAS.md sincronizado"
fi

exit $MISMATCH
