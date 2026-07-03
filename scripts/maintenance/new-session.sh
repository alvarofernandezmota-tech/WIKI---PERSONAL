#!/bin/bash
# ============================================================
# NEW SESSION — Yggdrasil Ecosystem
# Lanza una sesión de trabajo nueva:
#   - Crea diario del día si no existe
#   - git pull
#   - Abre tmux sesión 'trabajo'
#   - Muestra estado rápido
# Uso: bash ~/yggdrasil-dew/scripts/maintenance/new-session.sh
# ============================================================

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; RED='\033[0;31m'; NC='\033[0m'
REPO=~/yggdrasil-dew
HOY=$(date '+%Y-%m-%d')
HORA=$(date '+%H:%M')

echo ""
echo -e "${BLUE}╔══════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   NUEVA SESIÓN — $HOY $HORA CEST   ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════╝${NC}"
echo ""

cd $REPO || { echo -e "${RED}❌ Repo no encontrado${NC}"; exit 1; }

# ---- 1. GIT PULL ----
echo -e "${YELLOW}[ 1/4 ] Git pull...${NC}"
git pull --rebase 2>&1 | tail -3
echo ""

# ---- 2. CREAR DIARIO ----
DIARIO="$REPO/docs/diarios/$HOY.md"
if [ -f "$DIARIO" ]; then
  echo -e "${GREEN}[ 2/4 ] Diario del día ya existe: $DIARIO${NC}"
else
  echo -e "${YELLOW}[ 2/4 ] Creando diario $HOY...${NC}"
  mkdir -p $REPO/docs/diarios

  # Contar sesiones del día (0 al crear)
  NUM_SESION=1

  cat > "$DIARIO" << TEMPLATE
---
fecha: "$HOY"
estado: "en_progreso"
tags: ["diario", "sesion"]
---

# Diario $HOY

## Sesión $NUM_SESION — $HORA CEST

### 🎯 Objetivo de la sesión

<!-- ¿Qué quieres conseguir hoy? -->

### ✅ Completado

- 

### 🔄 En progreso

- 

### ⏳ Aplazado

- 

### 📝 Notas

<!-- Hallazgos, decisiones, contexto importante -->

---
TEMPLATE

  git add "$DIARIO"
  git commit -m "docs(diario): crear $HOY"
  git push
  echo -e "${GREEN}  ✅ Diario creado y pusheado${NC}"
fi
echo ""

# ---- 3. APLAZADOS CRÍTICOS ----
echo -e "${YELLOW}[ 3/4 ] Aplazados críticos...${NC}"
HOY_S=$(date +%s)
CRITICOS=0
for f in $REPO/inbox/APLAZADO-*.md; do
  [ -f "$f" ] || continue
  FECHA=$(grep '^fecha_creacion:' "$f" | head -1 | sed 's/fecha_creacion: *"\?//;s/"\?$//')
  [ -z "$FECHA" ] || [ "$FECHA" = "YYYY-MM-DD" ] && continue
  FECHA_S=$(date -d "$FECHA" +%s 2>/dev/null) || continue
  DIAS=$(( (HOY_S - FECHA_S) / 86400 ))
  [ "$DIAS" -ge 7 ] && { echo -e "  ${RED}🔴 $(basename $f) — $DIAS días${NC}"; ((CRITICOS++)); }
done
[ "$CRITICOS" -eq 0 ] && echo -e "  ${GREEN}✅ Sin críticos${NC}"
echo ""

# ---- 4. TMUX ----
echo -e "${YELLOW}[ 4/4 ] Abriendo tmux 'trabajo'...${NC}"
if tmux has-session -t trabajo 2>/dev/null; then
  echo -e "${GREEN}  ✅ Sesión 'trabajo' ya activa — usa: tmux attach -t trabajo${NC}"
else
  tmux new-session -d -s trabajo
  echo -e "${GREEN}  ✅ Sesión 'trabajo' creada — usa: tmux attach -t trabajo${NC}"
fi
echo ""

# ---- RESUMEN ----
echo -e "${BLUE}════════════════════════════════════════════${NC}"
echo -e "  📖 Diario: docs/diarios/$HOY.md"
echo -e "  📝 Issues: https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues"
echo -e "  📺 tmux:   tmux attach -t trabajo"
echo -e "${BLUE}════════════════════════════════════════════${NC}"
echo ""
echo -e "${GREEN}¡Sesión lista! 🚀${NC}"
echo ""
