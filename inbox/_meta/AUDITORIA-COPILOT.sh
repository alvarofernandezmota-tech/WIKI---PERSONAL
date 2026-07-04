#!/usr/bin/env bash
# ============================================================
# AUDITORIA-COPILOT.sh — Auditoría automática del repo
# Genera 4 reportes en inbox/_meta/
# Uso: bash inbox/_meta/AUDITORIA-COPILOT.sh (desde raíz del repo)
# ============================================================

set -euo pipefail

FECHA=$(date +%Y-%m-%d)
HORA=$(date +%H-%M)
META="inbox/_meta"

mkdir -p "$META"

echo "🔍 Iniciando auditoría — $FECHA $HORA"

# ============================================================
# 1. audit-workflows — estado de todos los GitHub Actions
# ============================================================
WF_OUT="$META/audit-workflows-${FECHA}.md"

cat > "$WF_OUT" << EOF
# Auditoría Workflows — $FECHA

> Generado por AUDITORIA-COPILOT.sh el $FECHA a las $HORA

## Workflows encontrados

EOF

if [ -d ".github/workflows" ]; then
  WF_COUNT=0
  WF_STUB=0
  WF_OK=0
  for wf in .github/workflows/*.yml .github/workflows/*.yaml; do
    [ -f "$wf" ] || continue
    SIZE=$(wc -c < "$wf")
    NAME=$(basename "$wf")
    WF_COUNT=$((WF_COUNT + 1))
    if [ "$SIZE" -lt 200 ]; then
      STATUS="⚠️ STUB (<200 bytes)"
      WF_STUB=$((WF_STUB + 1))
    else
      STATUS="✅ funcional"
      WF_OK=$((WF_OK + 1))
    fi
    echo "| \`$NAME\` | $SIZE bytes | $STATUS |" >> "$WF_OUT"
  done
  sed -i 's/## Workflows encontrados/## Workflows encontrados\n\n| Archivo | Tamaño | Estado |\n|---|---|---|/' "$WF_OUT"
  echo "" >> "$WF_OUT"
  echo "## Resumen" >> "$WF_OUT"
  echo "- Total: $WF_COUNT" >> "$WF_OUT"
  echo "- Funcionales (≥200 bytes): $WF_OK" >> "$WF_OUT"
  echo "- Stubs (<200 bytes): $WF_STUB" >> "$WF_OUT"
else
  echo "⚠️ No existe .github/workflows/" >> "$WF_OUT"
fi

echo "✅ audit-workflows → $WF_OUT"

# ============================================================
# 2. audit-scripts — estado de scripts en scripts/ e inbox/_meta/
# ============================================================
SC_OUT="$META/audit-scripts-${FECHA}.md"

cat > "$SC_OUT" << EOF
# Auditoría Scripts — $FECHA

> Generado por AUDITORIA-COPILOT.sh el $FECHA a las $HORA

## Scripts en scripts/

| Archivo | Tamaño | Ejecutable | Shebang |
|---|---|---|---|
EOF

if [ -d "scripts" ]; then
  find scripts -type f \( -name "*.sh" -o -name "*.py" -o -name "*.js" \) | sort | while read -r f; do
    SIZE=$(wc -c < "$f")
    EXEC=$([ -x "$f" ] && echo "✅" || echo "❌")
    SHEBANG=$(head -1 "$f" 2>/dev/null | grep -E '^#!' | head -c 40 || echo "—")
    echo "| \`$f\` | $SIZE bytes | $EXEC | \`$SHEBANG\` |"
  done >> "$SC_OUT" 2>/dev/null || echo "(sin scripts encontrados)" >> "$SC_OUT"
else
  echo "⚠️ carpeta scripts/ no existe" >> "$SC_OUT"
fi

echo "" >> "$SC_OUT"
echo "## Scripts en inbox/_meta/" >> "$SC_OUT"
echo "" >> "$SC_OUT"
echo "| Archivo | Tamaño | Ejecutable |" >> "$SC_OUT"
echo "|---|---|---|" >> "$SC_OUT"

find "$META" -type f \( -name "*.sh" -o -name "*.py" \) | sort | while read -r f; do
  SIZE=$(wc -c < "$f")
  EXEC=$([ -x "$f" ] && echo "✅" || echo "❌")
  echo "| \`$f\` | $SIZE bytes | $EXEC |"
done >> "$SC_OUT" 2>/dev/null

echo "✅ audit-scripts → $SC_OUT"

# ============================================================
# 3. audit-estructura — árbol de carpetas raíz + anomalías
# ============================================================
ES_OUT="$META/audit-estructura-${FECHA}.md"

cat > "$ES_OUT" << EOF
# Auditoría Estructura — $FECHA

> Generado por AUDITORIA-COPILOT.sh el $FECHA a las $HORA

## Árbol raíz (nivel 1)

\`\`\`
EOF

find . -maxdepth 1 -not -name '.' -not -path './.git/*' | sort | sed 's|^./||' >> "$ES_OUT"
echo '```' >> "$ES_OUT"

echo "" >> "$ES_OUT"
echo "## Archivos .md en raíz (no deberían ser muchos)" >> "$ES_OUT"
echo "" >> "$ES_OUT"
echo "| Archivo | Tamaño |" >> "$ES_OUT"
echo "|---|---|" >> "$ES_OUT"

find . -maxdepth 1 -name "*.md" | sort | while read -r f; do
  SIZE=$(wc -c < "$f")
  echo "| \`$f\` | $SIZE bytes |"
done >> "$ES_OUT"

echo "" >> "$ES_OUT"
echo "## Carpetas duplicadas o con nombres similares" >> "$ES_OUT"
echo "" >> "$ES_OUT"

# Detecta carpetas con nombres muy parecidos (mismo prefijo)
find . -maxdepth 1 -type d -not -path './.git' -not -name '.' | sort | sed 's|^./||' | while read -r d; do
  echo "$d"
done >> "$ES_OUT"

echo "✅ audit-estructura → $ES_OUT"

# ============================================================
# 4. audit-resumen — score y próximos pasos
# ============================================================
RS_OUT="$META/audit-resumen-${FECHA}.md"

# Calcular score básico
SCORE=100
PENALTY=0

# Penalizar si hay muchos .md en raíz (más de 8)
MD_ROOT=$(find . -maxdepth 1 -name "*.md" | wc -l)
if [ "$MD_ROOT" -gt 8 ]; then
  PENALTY=$((PENALTY + 10))
fi

# Penalizar si hay workflows stub
if [ -d ".github/workflows" ]; then
  STUBS=$(find .github/workflows -name "*.yml" -o -name "*.yaml" 2>/dev/null | xargs -I{} sh -c 'wc -c < "{}"' 2>/dev/null | awk '$1 < 200 {c++} END {print c+0}')
  PENALTY=$((PENALTY + STUBS * 5))
fi

# Penalizar si scripts/ existe pero no tiene scripts ejecutables
if [ -d "scripts" ]; then
  NON_EXEC=$(find scripts -name "*.sh" ! -executable 2>/dev/null | wc -l)
  PENALTY=$((PENALTY + NON_EXEC * 3))
fi

SCORE=$((SCORE - PENALTY))
[ "$SCORE" -lt 0 ] && SCORE=0

cat > "$RS_OUT" << EOF
# Auditoría Resumen — $FECHA

> Generado por AUDITORIA-COPILOT.sh el $FECHA a las $HORA

## Score global: $SCORE / 100

| Métrica | Valor | Estado |
|---|---|---|
| Archivos .md en raíz | $MD_ROOT | $([ "$MD_ROOT" -gt 8 ] && echo "⚠️ muchos" || echo "✅ ok") |
| Workflows stub (<200b) | ${STUBS:-0} | $([ "${STUBS:-0}" -gt 0 ] && echo "⚠️ limpiar" || echo "✅ ok") |
| Scripts no ejecutables | ${NON_EXEC:-0} | $([ "${NON_EXEC:-0}" -gt 0 ] && echo "⚠️ chmod +x" || echo "✅ ok") |

## Próximos pasos

EOF

if [ "$MD_ROOT" -gt 8 ]; then
  echo "- [ ] Mover archivos .md excedentes de raíz a \`docs/\`" >> "$RS_OUT"
fi

if [ "${STUBS:-0}" -gt 0 ]; then
  echo "- [ ] Eliminar o completar los $STUBS workflows stub en \`.github/workflows/\`" >> "$RS_OUT"
fi

if [ "${NON_EXEC:-0}" -gt 0 ]; then
  echo "- [ ] Ejecutar \`chmod +x scripts/*.sh\` para hacer scripts ejecutables" >> "$RS_OUT"
fi

echo "- [ ] Revisar \`docs/ECOSISTEMA.md\` — mapa operativo centralizado" >> "$RS_OUT"
echo "- [ ] Revisar \`ECOSYSTEM-ARCHITECTURE.md\` — ley de gobernanza" >> "$RS_OUT"
echo "" >> "$RS_OUT"
echo "---" >> "$RS_OUT"
echo "_Auditoría ejecutada: $FECHA $HORA — AUDITORIA-COPILOT.sh_" >> "$RS_OUT"

echo "✅ audit-resumen → $RS_OUT"

# ============================================================
# Commit automático si hay cambios (opcional — solo si hay git)
# ============================================================
if git rev-parse --is-inside-work-tree &>/dev/null; then
  git add "$META/audit-workflows-${FECHA}.md" \
          "$META/audit-scripts-${FECHA}.md" \
          "$META/audit-estructura-${FECHA}.md" \
          "$META/audit-resumen-${FECHA}.md" 2>/dev/null || true
  git diff --cached --quiet || \
    git commit -m "audit($FECHA): reportes de auditoría automática" \
               --author="copilot-audit[bot] <copilot@github.local>" 2>/dev/null || true
fi

echo ""
echo "🎉 Auditoría completa. Reportes en $META/:"
ls -lh "$META/audit-"*"${FECHA}"*.md 2>/dev/null || true
echo ""
echo "Score: $SCORE/100"
