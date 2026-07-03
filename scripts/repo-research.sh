#!/usr/bin/env bash
# ==============================================================
# REPO-RESEARCH.sh — Investigación de mejora del repo
# Genera un fichero .md en inbox/ con:
#   - Scripts sueltos sin isla
#   - Subdirectorios sin README
#   - Duplicados detectados
#   - Inventario por directorio
#   - Issues GitHub abiertos
#   - Propuestas de mejora
#
# Uso:
#   bash scripts/repo-research.sh            # genera + push
#   bash scripts/repo-research.sh --dry-run  # solo muestra, no escribe
#
# Para issues GitHub necesitas GH_TOKEN o gh auth login:
#   export GH_TOKEN="ghp_xxxx"
# ==============================================================
set -euo pipefail

DRY_RUN=false
[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=true

# ── Ruta canónica
if [ -d "/srv/yggdrasil-dew" ]; then
  REPO_DIR="/srv/yggdrasil-dew"
elif [ -d "$HOME/yggdrasil-dew" ]; then
  REPO_DIR="$HOME/yggdrasil-dew"
else
  echo "[ERROR] Repo no encontrado"; exit 1
fi

REPO_NAME="alvarofernandezmota-tech/yggdrasil-dew"
DATE_STR=$(date +%Y-%m-%d)          # <─ fix: era DATE_ (unbound)
TIMESTAMP=$(date +%H:%M)

if $DRY_RUN; then
  OUT="/tmp/${DATE_STR}-repo-research-dryrun.md"
else
  OUT="$REPO_DIR/inbox/${DATE_STR}-repo-research.md"
  mkdir -p "$REPO_DIR/inbox"
fi

log()  { echo -e "\033[1;36m[→]\033[0m $*"; }
warn() { echo -e "\033[1;33m[⚠]\033[0m $*"; }
ok()   { echo -e "\033[1;32m[✓]\033[0m $*"; }

echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║   REPO RESEARCH — Mejora yggdrasil-dew       ║"
echo "╚══════════════════════════════════════════════╝"
echo ""
$DRY_RUN && warn "Modo DRY-RUN activo — salida en /tmp/"

# ── Cabecera del informe
cat > "$OUT" << HEADER
---
type: report
date: ${DATE_STR}
hora: ${TIMESTAMP}
source: repo-research.sh
priority: medium
status: pending
processed_by: pending
title: Investigación mejora repo
---

# Repo Research — ${DATE_STR} ${TIMESTAMP}

> Generado automáticamente por \`scripts/repo-research.sh\`
> Usuario: varopc · Repo: ${REPO_NAME}

HEADER

cd "$REPO_DIR"

# === 1. Scripts sueltos en raíz de scripts/ ===
log "Scripts sueltos en scripts/ raíz..."
echo "" >> "$OUT"
echo "## 1. Scripts sueltos (sin subdirectorio de isla)" >> "$OUT"
echo "" >> "$OUT"
SUELTOS=0
while IFS= read -r f; do
  echo "- \`$f\`" >> "$OUT"
  warn "Suelto: $f"
  ((SUELTOS++)) || true
done < <(find scripts/ -maxdepth 1 \( -name "*.sh" -o -name "*.py" \) | sort)
[ "$SUELTOS" -eq 0 ] && echo "- Sin scripts sueltos detectados ✅" >> "$OUT"

# === 2. Subdirectorios sin README ===
log "READMEs faltantes..."
echo "" >> "$OUT"
echo "## 2. Subdirectorios sin README.md" >> "$OUT"
echo "" >> "$OUT"
SIN_README=0
for dir in scripts/*/; do
  if [[ ! -f "${dir}README.md" ]]; then
    echo "- \`$dir\`" >> "$OUT"
    warn "Sin README: $dir"
    ((SIN_README++)) || true
  fi
done
[ "$SIN_README" -eq 0 ] && echo "- Todos los subdirectorios tienen README ✅" >> "$OUT"

# === 3. Duplicados / solapamientos ===
log "Posibles duplicados..."
echo "" >> "$OUT"
echo "## 3. Posibles duplicados / solapamientos" >> "$OUT"
echo "" >> "$OUT"
DUPS=0
[[ -d "scripts/osint" && -d "scripts/osint-stack" ]] && { echo "- \`osint/\` y \`osint-stack/\` — candidatos a fusionar" >> "$OUT"; ((DUPS++)) || true; }
[[ -d "scripts/tools" && -d "scripts/cli-tools" ]] && { echo "- \`tools/\` y \`cli-tools/\` — revisar" >> "$OUT"; ((DUPS++)) || true; }
[[ -d "scripts/docker" && -d "scripts/infra" ]] && { echo "- \`docker/\` y \`infra/\` — revisar" >> "$OUT"; ((DUPS++)) || true; }
[ "$DUPS" -eq 0 ] && echo "- Sin duplicados obvios detectados ✅" >> "$OUT"

# === 4. Inventario por directorio ===
log "Inventario de directorios..."
echo "" >> "$OUT"
echo "## 4. Inventario de ficheros por directorio" >> "$OUT"
echo "" >> "$OUT"
echo "| Directorio | Ficheros |" >> "$OUT"
echo "|---|---|" >> "$OUT"
find . -maxdepth 1 -type d | sort | while read -r d; do
  count=$(find "$d" -type f 2>/dev/null | wc -l)
  echo "| \`$d\` | $count |" >> "$OUT"
done

# === 5. Issues GitHub ===
log "Consultando issues GitHub..."
echo "" >> "$OUT"
echo "## 5. Issues GitHub abiertos" >> "$OUT"
echo "" >> "$OUT"

GH_OK=false
if command -v gh &>/dev/null; then
  # Intenta con gh auth o GH_TOKEN env var
  if gh auth status &>/dev/null 2>&1 || [ -n "${GH_TOKEN:-}" ]; then
    GH_OK=true
  fi
fi

if $GH_OK; then
  gh issue list \
    --repo "$REPO_NAME" \
    --state open --limit 30 \
    --json number,title,labels \
    --template '{{range .}}- #{{.number}} {{.title}}{{"\n"}}{{end}}' >> "$OUT" 2>/dev/null || \
    echo "- (error consultando issues)" >> "$OUT"
else
  cat >> "$OUT" << 'GHEOF'
- gh no autenticado en esta sesión.
  Opciones:
  1. `gh auth login` (interactivo)
  2. `export GH_TOKEN="ghp_xxxx"` + relanzar script
  3. El agente-investigacion usará GitHub API directamente (próximamente)
GHEOF
  warn "gh no autenticado — issues no disponibles"
fi

# === 6. Propuestas de mejora ===
echo "" >> "$OUT"
echo "## 6. Propuestas de mejora detectadas" >> "$OUT"
echo "" >> "$OUT"
cat >> "$OUT" << 'EOF'
### Estructura
- [ ] Mover scripts sueltos de `scripts/` raíz a su isla correspondiente
- [ ] Crear `scripts/sesion/` → mover `inicio-sesion.sh`, `cierre-sesion.sh`
- [ ] Crear `scripts/agents/` → para los proto-agentes que vienen
- [ ] Añadir `README.md` a: `ci/`, `infra/`, `maintenance/`, `osint/`, `seguridad/`, `setup/`, `tests/`, `thdora/`

### Nomenclatura
- [ ] Eliminar prefijos numéricos (`01-`, `02-`...) en scripts legacy → renombrar a nombre descriptivo
- [ ] Estandarizar: todo lo que genera inbox usa sufijo `[AUTO]` en commit

### Deuda técnica
- [ ] `gemini-brief.md` en `scripts/` → mover a `docs/research/`
- [ ] `scripts/bc` (sin extensión) → revisar si es activo o legacy
- [ ] `scripts/backup/` → ¿activo o muerto? documentar estado

### Siguiente nivel (agentes)
- [ ] Convertir `repo-research.sh` en tool del agente-investigacion
- [ ] Convertir `audit-and-migrate.sh` en tool del agente-auditoria
- [ ] Los scripts pasan a ser **reglas ejecutables** que los agentes llaman
EOF

echo "" >> "$OUT"
echo "---" >> "$OUT"
echo "" >> "$OUT"
echo "*Generado por \`repo-research.sh\` [AUTO] · ${DATE_STR} ${TIMESTAMP} · varopc@Madre*" >> "$OUT"

ok "Informe generado: $OUT"

if ! $DRY_RUN; then
  cd "$REPO_DIR"
  git add "$OUT"
  git commit -m "feat(inbox): repo-research ${DATE_STR} [AUTO]" 2>/dev/null && \
  git push && ok "Pusheado a GitHub" || \
  warn "Push fallido — revisa \`git status\`"
fi

echo ""
echo "  └─ Ver en GitHub: https://github.com/${REPO_NAME}/blob/main/inbox/${DATE_STR}-repo-research.md"
echo ""
