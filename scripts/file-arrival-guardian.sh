#!/usr/bin/env bash
# ============================================================
# ARCHIVO      : file-arrival-guardian.sh
# VERSIÓN      : 1.0.0
# FUNCIÓN ÚNICA: Verificar que cada archivo nuevo del repo
#                existe en su carpeta canónica correcta y NO
#                en carpetas duplicadas o prohibidas.
#                Si detecta un archivo mal ubicado → abre issue.
# AUTOR        : alvarofernandezmota-tech
# REPO         : alvarofernandezmota-tech/yggdrasil-dew
# USO          : bash scripts/file-arrival-guardian.sh
#                bash scripts/file-arrival-guardian.sh --dry-run
# DISPARA      : .github/workflows/file-arrival-guardian.yml
# ============================================================

set -euo pipefail

DRY_RUN=false
[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=true

REPO_ROOT="$(git rev-parse --show-toplevel)"
DATE_NOW=$(date "+%Y-%m-%d %H:%M:%S")
REPORT="$REPO_ROOT/inbox/_meta/arrival-report-$(date +%Y%m%dT%H%M%S).md"
ERRORS=0
WARNINGS=0

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

echo -e "${CYAN}${BOLD}============================================${RESET}"
echo -e "${CYAN}${BOLD}  FILE ARRIVAL GUARDIAN — yggdrasil-dew    ${RESET}"
echo -e "${CYAN}${BOLD}============================================${RESET}"
echo -e "Fecha: ${DATE_NOW}"
$DRY_RUN && echo -e "${YELLOW}[DRY-RUN activado — no se abren issues]${RESET}"
echo ""

mkdir -p "$REPO_ROOT/inbox/_meta"

# ══════════════════════════════════════════════════════════════
# MAPA CANÓNICO DE CARPETAS
# Define: qué carpetas son válidas y cuáles están prohibidas
# ══════════════════════════════════════════════════════════════

# Carpetas CANÓNICAS — aquí SÍ deben vivir los archivos
declare -a CANONICAL=(
  "diarios"
  "osint-stack"
  "scripts"
  "scripts/agentes"
  "inbox"
  "islas"
  ".github/workflows"
  "docs"
  "core"
  "templates"
  "formacion"
  "hardware"
  "investigacion"
  "proyectos"
  "sesiones"
  "thdora"
  "mcp"
  "infra"
  "docker"
  "tests"
  "setup"
  "assets"
  "tools"
  "agentes"
  "yo"
  "mocs"
  "ollama"
  "cli-tools"
)

# Carpetas PROHIBIDAS — no deben recibir archivos nuevos
# (son legacy/duplicadas, se están consolidando)
declare -a FORBIDDEN=(
  "diary"
  "osint"
  "diarios/legacy-diary"
  "osint-stack/legacy-osint"
)

# Archivos que NO deben estar en la RAÍZ del repo
# (solo se permiten los listados aquí)
declare -a ROOT_ALLOWED=(
  "README.md"
  "AGENT.md"
  "CHANGELOG.md"
  "CONTEXT.md"
  "CONTRIBUTING.md"
  "CONVENCIONES.md"
  "COPILOT-CONTEXT.md"
  "ECOSISTEMA.md"
  "ECOSYSTEM-ARCHITECTURE.md"
  "ESTADO-SISTEMA.md"
  "HERRAMIENTAS-ECOSISTEMA.md"
  "HOME.md"
  "MAPA-ISLAS.md"
  "MASTER-PENDIENTES.md"
  "PLAN-SEGURIDAD-Y-DESPLIEGUE.md"
  "ROADMAP-MASTER.md"
  "ROADMAP.md"
  "mcp-config.json"
  "package.json"
  "server.js"
  ".env.template"
  ".gitignore"
)

ISSUES_BODY=""

# ══════════════════════════════════════════════════════════════
# CHECK 1: Archivos en carpetas PROHIBIDAS
# ══════════════════════════════════════════════════════════════
echo -e "${YELLOW}[CHECK 1] Archivos en carpetas prohibidas (legacy/duplicadas)...${RESET}"

for forbidden in "${FORBIDDEN[@]}"; do
  if [ -d "$REPO_ROOT/$forbidden" ]; then
    count=$(find "$REPO_ROOT/$forbidden" -type f ! -name '.gitkeep' ! -name '.keep' 2>/dev/null | wc -l)
    if [ "$count" -gt 0 ]; then
      echo -e "  ${RED}✗ PROHIBIDA: $forbidden ($count archivos)${RESET}"
      find "$REPO_ROOT/$forbidden" -type f ! -name '.gitkeep' ! -name '.keep' | while read -r f; do
        rel="${f#$REPO_ROOT/}"
        echo -e "    → $rel"
        ISSUES_BODY+="- PROHIBIDA: \`$rel\`\n"
      done
      ((ERRORS++)) || true
    else
      echo -e "  ${GREEN}✓ $forbidden (vacía — ok)${RESET}"
    fi
  fi
done

# ══════════════════════════════════════════════════════════════
# CHECK 2: Archivos inesperados en RAÍZ del repo
# ══════════════════════════════════════════════════════════════
echo ""
echo -e "${YELLOW}[CHECK 2] Archivos inesperados en raíz del repo...${RESET}"

while IFS= read -r f; do
  name=$(basename "$f")
  allowed=false
  for ok in "${ROOT_ALLOWED[@]}"; do
    [[ "$name" == "$ok" ]] && allowed=true && break
  done
  if ! $allowed; then
    echo -e "  ${RED}✗ RAÍZ: $name no debería estar aquí${RESET}"
    ISSUES_BODY+="- RAÍZ INESPERADO: \`$name\`\n"
    ((ERRORS++)) || true
  fi
done < <(find "$REPO_ROOT" -maxdepth 1 -type f ! -name '.*' 2>/dev/null)

# ══════════════════════════════════════════════════════════════
# CHECK 3: Scripts sin extensión .sh en scripts/
# ══════════════════════════════════════════════════════════════
echo ""
echo -e "${YELLOW}[CHECK 3] Archivos sin extensión .sh en scripts/...${RESET}"

while IFS= read -r f; do
  name=$(basename "$f")
  if [[ "$name" != *.sh && "$name" != *.py && "$name" != *.md && "$name" != ".keep" && "$name" != ".gitkeep" ]]; then
    echo -e "  ${YELLOW}⚠ SIN EXTENSIÓN: scripts/$name${RESET}"
    ISSUES_BODY+="- SIN EXTENSIÓN: \`scripts/$name\`\n"
    ((WARNINGS++)) || true
  fi
done < <(find "$REPO_ROOT/scripts" -maxdepth 1 -type f 2>/dev/null)

# ══════════════════════════════════════════════════════════════
# CHECK 4: Archivos en inbox/ sin clasificar >24h
# ══════════════════════════════════════════════════════════════
echo ""
echo -e "${YELLOW}[CHECK 4] Archivos en inbox/ sin clasificar >24h...${RESET}"

OLD_INBOX=$(find "$REPO_ROOT/inbox" -maxdepth 1 -type f ! -name '.keep' ! -name '.gitkeep' -mmin +1440 2>/dev/null | wc -l)
if [ "$OLD_INBOX" -gt 0 ]; then
  echo -e "  ${YELLOW}⚠ $OLD_INBOX archivos llevan >24h en inbox/ sin clasificar${RESET}"
  find "$REPO_ROOT/inbox" -maxdepth 1 -type f ! -name '.keep' -mmin +1440 | while read -r f; do
    rel="${f#$REPO_ROOT/}"
    echo -e "    → $rel"
    ISSUES_BODY+="- INBOX ESTANCADO >24h: \`$rel\`\n"
  done
  ((WARNINGS++)) || true
else
  echo -e "  ${GREEN}✓ inbox/ limpio${RESET}"
fi

# ══════════════════════════════════════════════════════════════
# ESCRIBIR REPORTE
# ══════════════════════════════════════════════════════════════
echo ""
echo -e "${YELLOW}Escribiendo reporte en inbox/_meta/...${RESET}"

cat > "$REPORT" << REPORT_EOF
# FILE ARRIVAL GUARDIAN — Reporte
> Fecha: ${DATE_NOW}
> Errores: ${ERRORS} | Advertencias: ${WARNINGS}

## Problemas detectados

$(echo -e "$ISSUES_BODY" | sed 's/^$/— ninguno —/')

## Checks ejecutados
- [x] Archivos en carpetas prohibidas (legacy/duplicadas)
- [x] Archivos inesperados en raíz del repo
- [x] Scripts sin extensión correcta en scripts/
- [x] Archivos en inbox/ estancados >24h
REPORT_EOF

# ══════════════════════════════════════════════════════════════
# ABRIR ISSUE SI HAY ERRORES
# ══════════════════════════════════════════════════════════════
if [ "$ERRORS" -gt 0 ]; then
  echo ""
  echo -e "${RED}${BOLD}✗ $ERRORS errores detectados${RESET}"

  if ! $DRY_RUN && command -v gh &>/dev/null; then
    ISSUE_TITLE="[file-arrival-guardian] $ERRORS archivos mal ubicados — $(date +%Y-%m-%d)"
    ISSUE_BODY="## Archivos mal ubicados detectados por file-arrival-guardian\n\nFecha: ${DATE_NOW}\n\n### Problemas:\n${ISSUES_BODY}\n\n### Acción requerida:\nMover cada archivo a su carpeta canónica y hacer commit.\n\nReporte completo: \`$REPORT\`"
    gh issue create \
      --title "$ISSUE_TITLE" \
      --body "$(echo -e "$ISSUE_BODY")" \
      --label "deuda-tecnica,estructura" \
      --repo alvarofernandezmota-tech/yggdrasil-dew 2>/dev/null || \
      echo -e "${YELLOW}⚠ gh CLI no disponible — issue no creado automáticamente${RESET}"
    echo -e "${GREEN}✓ Issue abierto en GitHub${RESET}"
  else
    $DRY_RUN && echo -e "${YELLOW}[DRY-RUN] Issue NO abierto${RESET}"
  fi

  echo -e "${RED}Reporte: $REPORT${RESET}"
  exit 1
fi

if [ "$WARNINGS" -gt 0 ]; then
  echo -e "${YELLOW}${BOLD}⚠ $WARNINGS advertencias (no bloquean)${RESET}"
fi

echo ""
echo -e "${GREEN}${BOLD}✅ Todos los archivos están en su sitio correcto${RESET}"
echo -e "${GREEN}Reporte: $REPORT${RESET}"
exit 0
