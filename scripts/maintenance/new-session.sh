#!/usr/bin/env bash
# =============================================================================
# new-session.sh — Protocolo de inicio de sesion en yggdrasil-dew
# Versión: 2.0 — S21 — 2026-07-03
# Uso: bash scripts/maintenance/new-session.sh [NOMBRE_SESION]
# =============================================================================

set -euo pipefail

# ─── Colores ────────────────────────────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; CYAN='\033[0;36m'; BOLD='\033[1m'; NC='\033[0m'

# ─── Config ─────────────────────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
SESSION_NAME="${1:-S$(date +%Y%m%d)}"
FECHA=$(date '+%d-%b-%Y %H:%M CEST')

echo -e "${BOLD}${BLUE}"
echo "╔══════════════════════════════════════════════════════════╗"
echo "║          🌳 YGGDRASIL-DEW — INICIO DE SESION            ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo -e "  ${CYAN}Sesion:${NC} ${SESSION_NAME}"
echo -e "  ${CYAN}Fecha:${NC}  ${FECHA}"
echo -e "  ${CYAN}Repo:${NC}   ${REPO_ROOT}"
echo ""

# ─── 1. Pull del repo ───────────────────────────────────────────────────────
echo -e "${YELLOW}[1/5] Sincronizando con GitHub...${NC}"
cd "${REPO_ROOT}"
git pull --ff-only 2>&1 | tail -3
echo -e "${GREEN}✅ Repo actualizado${NC}"
echo ""

# ─── 2. Estado del ecosistema ───────────────────────────────────────────────
echo -e "${YELLOW}[2/5] Estado del ecosistema...${NC}"
if [ -f "ESTADO-SISTEMA.md" ]; then
  echo -e "${CYAN}--- ESTADO-SISTEMA.md (primeras 20 lineas) ---${NC}"
  head -20 ESTADO-SISTEMA.md
fi
echo ""

# ─── 3. Mapa de islas — resumen rapido ──────────────────────────────────────
echo -e "${YELLOW}[3/5] Resumen de islas...${NC}"
if [ -f "MAPA-ISLAS.md" ]; then
  # Extraer la tabla resumen
  awk '/## .*TABLA RESUMEN/,/^---/' MAPA-ISLAS.md | head -20
fi
echo ""

# ─── 4. Pendientes criticos ─────────────────────────────────────────────────
echo -e "${YELLOW}[4/5] Issues criticos abiertos...${NC}"
if command -v gh &>/dev/null; then
  gh issue list --repo alvarofernandezmota-tech/yggdrasil-dew \
    --state open --limit 5 \
    --json number,title,labels \
    --template '{{range .}}  #{{.number}} {{.title}}{{"\n"}}{{end}}' 2>/dev/null || \
    echo "  (gh CLI no autenticado o sin issues abiertos)"
else
  echo "  gh CLI no disponible — ver https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues"
fi
echo ""

# ─── 5. Audit rapido de ficheros maestros ───────────────────────────────────
echo -e "${YELLOW}[5/5] Auditando ficheros maestros...${NC}"
MAESTROS=("ECOSISTEMA.md" "MAPA-ISLAS.md" "HERRAMIENTAS-ECOSISTEMA.md" "CONVENCIONES.md" "ESTADO-SISTEMA.md")
ALL_OK=true
for f in "${MAESTROS[@]}"; do
  if [ -f "${REPO_ROOT}/${f}" ]; then
    SIZE=$(wc -c < "${REPO_ROOT}/${f}")
    if [ "$SIZE" -lt 100 ]; then
      echo -e "  ${RED}⚠️  ${f} — DEMASIADO PEQUENO (${SIZE} bytes) posible zombie${NC}"
      ALL_OK=false
    else
      echo -e "  ${GREEN}✅ ${f} (${SIZE} bytes)${NC}"
    fi
  else
    echo -e "  ${RED}❌ ${f} — AUSENTE${NC}"
    ALL_OK=false
  fi
done

if [ "$ALL_OK" = false ]; then
  echo -e "\n${RED}⚠️  Hay problemas en ficheros maestros — revisalos antes de continuar${NC}"
fi
echo ""

# ─── Resumen final ──────────────────────────────────────────────────────────
echo -e "${BOLD}${GREEN}"
echo "╔══════════════════════════════════════════════════════════╗"
echo "║  ✅ SESION ${SESSION_NAME} INICIADA — LISTO PARA TRABAJAR  ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo -e "${CYAN}Comandos utiles:${NC}"
echo "  git pull                           → sincronizar"
echo "  git add -A && git commit -m '...'  → guardar cambios"
echo "  git push                           → subir a GitHub"
echo ""
echo -e "${CYAN}Ficheros maestros de esta sesion:${NC}"
echo "  MAPA-ISLAS.md          → estado de todas las islas"
echo "  HERRAMIENTAS-ECOSISTEMA.md → inventario completo"
echo "  MASTER-PENDIENTES.md   → tareas pendientes"
echo "  HOME.md                → punto de entrada Obsidian"
echo ""
