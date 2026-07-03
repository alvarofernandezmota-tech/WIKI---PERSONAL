#!/bin/bash
# ============================================================
# NEW DAY — Yggdrasil Ecosystem
# Crea el diario del día automáticamente.
# Ideal para ejecutar al arrancar Madre (cron o systemd).
# Uso: bash ~/yggdrasil-dew/scripts/maintenance/new-day.sh
# ============================================================

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
REPO=~/yggdrasil-dew
HOY=$(date '+%Y-%m-%d')
HORA=$(date '+%H:%M')
DIARIO="$REPO/docs/diarios/$HOY.md"

cd $REPO || exit 1
git pull --rebase --quiet

if [ -f "$DIARIO" ]; then
  echo -e "${YELLOW}Diario $HOY ya existe — nada que hacer${NC}"
  exit 0
fi

mkdir -p $REPO/docs/diarios
cat > "$DIARIO" << TEMPLATE
---
fecha: "$HOY"
estado: "en_progreso"
tags: ["diario"]
---

# Diario $HOY

## 🌅 Inicio del día — $HORA CEST

### Estado del sistema

<!-- Generado automáticamente por new-day.sh -->

### Objetivo del día

- 

---
TEMPLATE

git add "$DIARIO"
git commit -m "docs(diario): auto-create $HOY"
git push
echo -e "${GREEN}✅ Diario $HOY creado${NC}"
