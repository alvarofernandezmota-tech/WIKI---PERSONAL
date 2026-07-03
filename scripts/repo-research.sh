#!/usr/bin/env bash
# ==============================================================
# REPO-RESEARCH.sh — Investigación de mejora del repo
# Analiza estado real, detecta gaps, propone mejoras
# Genera informe en inbox/ para el ecosistema
# Uso: bash scripts/repo-research.sh [--dry-run]
# ==============================================================
set -euo pipefail

DRY_RUN=false
[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=true

# Ruta canónica
if [ -d "/srv/yggdrasil-dew" ]; then
  REPO_DIR="/srv/yggdrasil-dew"
elif [ -d "$HOME/yggdrasil-dew" ]; then
  REPO_DIR="$HOME/yggdrasil-dew"
else
  echo "[ERROR] Repo no encontrado"; exit 1
fi

DATE=$(date +%Y-%m-%d)
OUT="$REPO_DIR/inbox/${DATE}-repo-research.md"

log()  { echo -e "\033[1;36m[→]\033[0m $*"; }
warn() { echo -e "\033[1;33m[⚠]\033[0m $*"; }
ok()   { echo -e "\033[1;32m[✓]\033[0m $*"; }

echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║   REPO RESEARCH — Mejora yggdrasil-dew       ║"
echo "╚══════════════════════════════════════════════╝"
echo ""
$DRY_RUN && warn "Modo DRY-RUN activo — no se escribe nada"

mkdir -p "$REPO_DIR/inbox"

if $DRY_RUN; then
  OUT="/tmp/${DATE}-repo-research-dryrun.md"
fi

cat > "$OUT" << HEREDOC
---
type: report
date: $DATE
source: manual
priority: medium
status: pending
title: Investigación mejora repo
processed_by: pending
---

# Investigación de mejora del repo — $DATE

HEREDOC

cd "$REPO_DIR"

# === 1. Scripts sueltos en raíz de scripts/ ===
log "Detectando scripts sueltos..."
echo "## 1. Scripts sueltos en scripts/ (sin subdirectorio de isla)" >> "$OUT"
echo "" >> "$OUT"
find scripts/ -maxdepth 1 \( -name "*.sh" -o -name "*.py" \) | sort | while read -r f; do
  echo "- \`$f\`" >> "$OUT"
  warn "Suelto: $f"
done

# === 2. Islas sin README ===
log "Detectando READMEs faltantes..."
echo "" >> "$OUT"
echo "## 2. Subdirectorios de scripts/ sin README.md" >> "$OUT"
echo "" >> "$OUT"
for dir in scripts/*/; do
  if [[ ! -f "${dir}README.md" ]]; then
    echo "- \`$dir\` — falta README" >> "$OUT"
    warn "Sin README: $dir"
  fi
done

# === 3. Directorios con posibles solapamientos ===
log "Detectando posibles duplicados..."
echo "" >> "$OUT"
echo "## 3. Posibles duplicados / solapamientos detectados" >> "$OUT"
echo "" >> "$OUT"
[[ -d osint && -d osint-stack ]] && echo "- \`osint/\` y \`osint-stack/\` — candidatos a fusionar" >> "$OUT"
[[ -d tools && -d cli-tools ]] && echo "- \`tools/\` y \`cli-tools/\` — revisar separación" >> "$OUT"
[[ -d docker && -d infra ]] && echo "- \`docker/\` y \`infra/\` — revisar separación" >> "$OUT"
[[ ! -d osint && ! -d osint-stack && ! -d tools && ! -d docker ]] && echo "- Sin duplicados obvios detectados" >> "$OUT"

# === 4. Inventario de ficheros por directorio ===
log "Contando ficheros por directorio..."
echo "" >> "$OUT"
echo "## 4. Inventario de directorios (ficheros totales)" >> "$OUT"
echo "" >> "$OUT"
echo "| Directorio | Ficheros |" >> "$OUT"
echo "|---|---|" >> "$OUT"
find . -maxdepth 1 -type d | sort | while read -r d; do
  count=$(find "$d" -type f 2>/dev/null | wc -l)
  echo "| \`$d\` | $count |" >> "$OUT"
done

# === 5. Issues abiertos en GitHub ===
log "Consultando issues GitHub..."
echo "" >> "$OUT"
echo "## 5. Issues GitHub abiertos" >> "$OUT"
echo "" >> "$OUT"
if command -v gh &>/dev/null && gh auth status &>/dev/null 2>&1; then
  gh issue list \
    --repo alvarofernandezmota-tech/yggdrasil-dew \
    --state open --limit 20 \
    --json number,title \
    --template "{{range .}}- #{{.number}} {{.title}}\n{{end}}" >> "$OUT" 2>/dev/null || \
    echo "- (error listando issues — revisar token)" >> "$OUT"
else
  echo "- gh no autenticado. Ejecutar: \`gh auth login\`" >> "$OUT"
  warn "gh no autenticado"
fi

# === 6. Propuestas de mejora ===
echo "" >> "$OUT"
echo "## 6. Propuestas de mejora" >> "$OUT"
echo "" >> "$OUT"
cat >> "$OUT" << 'EOF'
- [ ] Mover scripts sueltos de `scripts/` raíz a su subdirectorio de isla
- [ ] Crear `scripts/sesion/` con `inicio-sesion.sh` y `cierre-sesion.sh`
- [ ] Añadir README.md a cada subdirectorio de scripts/
- [ ] Estandarizar nombres: eliminar prefijos numéricos (01-, 02-) → nombre descriptivo
- [ ] Publicar REGISTRO-ISLAS.md con todas las islas y su estado
- [ ] Revisar `backup/` dentro de scripts/ — ¿muerto o activo?
- [ ] Mover `gemini-brief.md` a `docs/` o `inbox/` — no pertenece a scripts/
- [ ] Crear `scripts/agents/` para los scripts de agentes que vienen
EOF

echo "" >> "$OUT"
echo "_Generado automáticamente por repo-research [AUTO] · $DATE_" >> "$OUT"

echo ""
ok "Reporte guardado en: $OUT"

if ! $DRY_RUN; then
  cd "$REPO_DIR"
  git add "$OUT"
  git commit -m "feat(inbox): repo-research $DATE [AUTO]" && \
  git push && \
  ok "Push a GitHub completado" || \
  warn "Push fallido — revisa git status"
fi

echo ""
echo "  Ver en GitHub:"
echo "  https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/inbox/${DATE}-repo-research.md"
echo ""
