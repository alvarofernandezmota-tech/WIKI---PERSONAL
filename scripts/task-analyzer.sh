#!/usr/bin/env bash
# =============================================================================
# task-analyzer.sh
# Analiza inbox/ y scripts/ para detectar tareas repetidas y proponer
# automatizacion. Genera un informe en reports/task-analysis-YYYY-MM-DD.md
# =============================================================================
set -euo pipefail

REPORT_DIR="reports"
DATE=$(date +%Y-%m-%d)
OUTPUT="$REPORT_DIR/task-analysis-$DATE.md"

mkdir -p "$REPORT_DIR"

cat > "$OUTPUT" <<HEADER
---
tipo: task-analysis
fecha: $DATE
generado: task-analyzer.sh [AUTO]
---

# Analisis de Tareas Repetidas — $DATE

Este informe detecta patrones repetitivos en inbox y scripts
para proponer nuevas automatizaciones.

HEADER

# --- Analisis inbox ---
{
  echo "## Patrones en inbox/"
  echo ""
  echo "### Archivos por tipo"
  echo '```'
  find inbox/ -maxdepth 2 -name '*.*' 2>/dev/null | sed 's|.*\.||' | sort | uniq -c | sort -rn
  echo '```'
  echo ""
  echo "### Prefijos frecuentes (candidatos a template o automation)"
  echo '```'
  find inbox/ -maxdepth 1 -name '*.md' 2>/dev/null | xargs -I{} basename {} .md | \
    sed 's/-[0-9].*//;s/_[0-9].*//' | sort | uniq -c | sort -rn | head -20
  echo '```'
  echo ""
} >> "$OUTPUT"

# --- Analisis scripts ---
{
  echo "## Analisis de scripts/"
  echo ""
  echo "### Scripts por categoria"
  echo '```'
  find scripts/ -name '*.sh' -o -name '*.py' 2>/dev/null | sed 's|scripts/||;s|/.*||' | sort | uniq -c | sort -rn
  echo '```'
  echo ""
  echo "### Funciones mas usadas (candidatas a libreria comun)"
  echo '```'
  grep -rh '^[a-z_]\+()' scripts/ 2>/dev/null | sort | uniq -c | sort -rn | head -20
  echo '```'
  echo ""
  echo "### Scripts grandes (>200 lineas, candidatos a refactor)"
  echo '```'
  find scripts/ -name '*.sh' 2>/dev/null | while read f; do
    lines=$(wc -l < "$f")
    [[ $lines -gt 200 ]] && echo "$lines $f"
  done | sort -rn
  echo '```'
  echo ""
} >> "$OUTPUT"

# --- Analisis workflows ---
{
  echo "## Analisis de .github/workflows/"
  echo ""
  echo "### Workflows por trigger"
  echo '```'
  grep -h 'on:' .github/workflows/*.yml 2>/dev/null | sort | uniq -c | sort -rn
  echo '```'
  echo ""
  echo "### Workflows con cron activos"
  echo '```'
  grep -l 'schedule:' .github/workflows/*.yml 2>/dev/null | xargs -I{} basename {}
  echo '```'
  echo ""
} >> "$OUTPUT"

# --- Propuestas de automatizacion ---
{
  echo "## Propuestas de nueva automatizacion"
  echo ""
  echo "Basadas en los patrones anteriores, estas son las automatizaciones sugeridas:"
  echo ""
  echo "- [ ] Extraer funciones comunes a \`scripts/lib/common.sh\`"
  echo "- [ ] Crear templates para prefijos frecuentes en inbox"
  echo "- [ ] Refactorizar scripts con >200 lineas"
  echo "- [ ] Consolidar workflows similares"
  echo ""
  echo "*Este informe se genera automaticamente cada semana. No editar manualmente.*"
} >> "$OUTPUT"

echo "[task-analyzer] Informe generado: $OUTPUT"
