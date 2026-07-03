#!/bin/bash
# ============================================================
# MIGRATE INBOX → docs/
# Mueve archivos procesados a su destino final en docs/
# Uso: bash ~/yggdrasil-dew/scripts/maintenance/migrate-inbox.sh
# ============================================================

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
REPO=~/yggdrasil-dew
cd $REPO || exit 1

echo ""
echo -e "${YELLOW}═══════════════════════════════════════${NC}"
echo -e "${YELLOW}  MIGRATE INBOX → docs/${NC}"
echo -e "${YELLOW}═══════════════════════════════════════${NC}"
echo ""

# 1. Mover diarios procesados
if ls inbox/procesado/*diario* 2>/dev/null | grep -q .; then
  mkdir -p docs/diarios
  for f in inbox/procesado/*diario*; do
    DEST="docs/diarios/$(basename $f)"
    mv "$f" "$DEST" && echo -e "${GREEN}✅ Movido: $f → $DEST${NC}"
  done
fi

# 2. Mover docs de herramientas procesados
if ls inbox/procesado/*blink* inbox/procesado/*ssh* inbox/procesado/*tmux* inbox/procesado/*ollama* 2>/dev/null | grep -q .; then
  mkdir -p docs/herramientas
  for f in inbox/procesado/*blink* inbox/procesado/*ssh* inbox/procesado/*tmux* inbox/procesado/*ollama* 2>/dev/null; do
    [ -f "$f" ] || continue
    DEST="docs/herramientas/$(basename $f)"
    mv "$f" "$DEST" && echo -e "${GREEN}✅ Movido: $f → $DEST${NC}"
  done
fi

# 3. Commit automático si hay cambios
git add -A
if ! git diff --cached --quiet; then
  git commit -m "chore: migración inbox → docs/ $(date '+%Y-%m-%d')"
  echo -e "${GREEN}✅ Commit realizado${NC}"
  git push && echo -e "${GREEN}✅ Push OK${NC}"
else
  echo -e "${YELLOW}ℹ️  Sin cambios que migrar${NC}"
fi
echo ""
