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
    [ -f "$f" ] || continue
    DEST="docs/diarios/$(basename $f)"
    mv "$f" "$DEST" && echo -e "${GREEN}✅ Movido: $f → $DEST${NC}"
  done
fi

# 2. Mover docs de herramientas procesados
mkdir -p docs/herramientas
for f in inbox/procesado/*blink* inbox/procesado/*ssh* inbox/procesado/*tmux* inbox/procesado/*ollama*; do
  [ -f "$f" ] || continue
  DEST="docs/herramientas/$(basename $f)"
  mv "$f" "$DEST" && echo -e "${GREEN}✅ Movido: $f → $DEST${NC}"
done

# 3. Mover seguridad procesada
mkdir -p docs/seguridad/hallazgos
for f in inbox/procesado/*ftp* inbox/procesado/*hallazgo* inbox/procesado/*pentest* inbox/procesado/*secops*; do
  [ -f "$f" ] || continue
  DEST="docs/seguridad/hallazgos/$(basename $f)"
  mv "$f" "$DEST" && echo -e "${GREEN}✅ Movido: $f → $DEST${NC}"
done

# 4. Mover arquitectura procesada
mkdir -p docs/arquitectura
for f in inbox/procesado/*arquitectura* inbox/procesado/*compose* inbox/procesado/*docker*; do
  [ -f "$f" ] || continue
  DEST="docs/arquitectura/$(basename $f)"
  mv "$f" "$DEST" && echo -e "${GREEN}✅ Movido: $f → $DEST${NC}"
done

# 5. Resto sin clasificar → docs/misc/
if ls inbox/procesado/*.md 2>/dev/null | grep -q .; then
  mkdir -p docs/misc
  for f in inbox/procesado/*.md; do
    [ -f "$f" ] || continue
    DEST="docs/misc/$(basename $f)"
    mv "$f" "$DEST" && echo -e "${YELLOW}📦 Misc: $f → $DEST${NC}"
  done
fi

# 6. Commit automático si hay cambios
git add -A
if ! git diff --cached --quiet; then
  git commit -m "chore: migración inbox → docs/ $(date '+%Y-%m-%d')"
  echo -e "${GREEN}✅ Commit realizado${NC}"
  git push && echo -e "${GREEN}✅ Push OK${NC}" || echo -e "${RED}⚠️  Push falló — haz git pull primero${NC}"
else
  echo -e "${YELLOW}ℹ️  Sin cambios que migrar${NC}"
fi
echo ""
