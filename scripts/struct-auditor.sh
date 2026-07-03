#!/usr/bin/env bash
# =============================================================
# FUNCIÓN:   Detectar carpetas duplicadas y abrir issue en GitHub
# TRIGGER:   Manual o cron semanal (ecosystem-guardian.yml)
# AGENTE:    thdora-guardian, ecosystem-guardian
# ETIQUETAS: duplicado, estructura, deuda-tecnica
# RUTAS:     diarios/, osint/, osint-stack/, diary/, diarios/
# =============================================================
# Uso: ./scripts/struct-auditor.sh
# Requisitos: gh CLI autenticado, git
# =============================================================

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || echo '.')"
LOG_DIR="${REPO_ROOT}/diarios"
DATE="$(date +%Y-%m-%d)"
LOG_FILE="${LOG_DIR}/struct-audit-${DATE}.md"
FOUND_ISSUES=0

mkdir -p "${LOG_DIR}"

echo "# Struct Audit — ${DATE}" > "${LOG_FILE}"
echo "" >> "${LOG_FILE}"
echo "**Ejecutado:** $(date '+%Y-%m-%d %H:%M:%S')" >> "${LOG_FILE}"
echo "" >> "${LOG_FILE}"

# ─── PARES DE CARPETAS DUPLICADAS ─────────────────────────────
declare -A DUPLICATES=(
  ["diary"]="diarios"
  ["osint-stack"]="osint"
)

echo "## Duplicados detectados" >> "${LOG_FILE}"
echo "" >> "${LOG_FILE}"

for src in "${!DUPLICATES[@]}"; do
  dst="${DUPLICATES[$src]}"
  src_path="${REPO_ROOT}/${src}"
  dst_path="${REPO_ROOT}/${dst}"

  if [ -d "${src_path}" ] && [ -d "${dst_path}" ]; then
    src_count=$(find "${src_path}" -type f | wc -l | tr -d ' ')
    dst_count=$(find "${dst_path}" -type f | wc -l | tr -d ' ')

    echo "- ⚠️ **${src}/** (${src_count} archivos) y **${dst}/** (${dst_count} archivos) son duplicados" >> "${LOG_FILE}"
    echo "  - Acción: mover contenido de \`${src}/\` → \`${dst}/\` y eliminar \`${src}/\`" >> "${LOG_FILE}"
    FOUND_ISSUES=$((FOUND_ISSUES + 1))

    # Abrir issue si gh está disponible
    if command -v gh &>/dev/null; then
      EXISTING=$(gh issue list --label "duplicado" --search "[DUPLICADO] ${src}" --json number --jq length 2>/dev/null || echo "0")
      if [ "${EXISTING}" -eq 0 ]; then
        gh issue create \
          --title "[DUPLICADO] Consolidar ${src}/ → ${dst}/" \
          --label "duplicado,estructura,deuda-tecnica" \
          --body "## Carpeta duplicada detectada por struct-auditor\n\n**Origen:** \`${src}/\` (${src_count} archivos)\n**Destino:** \`${dst}/\` (${dst_count} archivos)\n\n### Acción requerida\n1. Revisar contenido de \`${src}/\`\n2. Mover archivos únicos a \`${dst}/\`\n3. Eliminar carpeta \`${src}/\`\n4. Actualizar referencias en docs y scripts\n\n*Issue generado automáticamente por \`scripts/struct-auditor.sh\` el ${DATE}*" \
          2>/dev/null && echo "  ✅ Issue creado para ${src}" || echo "  ⚠️ No se pudo crear issue para ${src}"
      else
        echo "  ℹ️ Issue ya existe para ${src}/${dst}"
      fi
    fi
  elif [ -d "${src_path}" ] && [ ! -d "${dst_path}" ]; then
    echo "- ℹ️ **${src}/** existe pero **${dst}/** no — renombrar directamente" >> "${LOG_FILE}"
  fi
done

echo "" >> "${LOG_FILE}"
echo "## Resumen" >> "${LOG_FILE}"
echo "" >> "${LOG_FILE}"
echo "- Issues encontrados: **${FOUND_ISSUES}**" >> "${LOG_FILE}"
echo "- Log guardado en: \`${LOG_FILE}\`" >> "${LOG_FILE}"

echo "[struct-auditor] Completado. Issues encontrados: ${FOUND_ISSUES}"
echo "[struct-auditor] Log: ${LOG_FILE}"

exit 0
