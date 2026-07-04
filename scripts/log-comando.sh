#!/bin/bash
# log-comando.sh — Registra un comando ejecutado en el repo wiki
# Uso: ./scripts/log-comando.sh "descripción de lo que hiciste"
#
# Para ejecutar automáticamente después de comandos importantes:
# Añade al final de tu ~/.bashrc o ~/.zshrc:
#   alias madre-log='~/scripts/log-comando.sh'

set -e

DESCRIPCION=${1:-"acción sin descripción"}
FECHA=$(date +%Y-%m-%dT%H:%M:%S)
ARCHIVO_LOG="diarios/ops-$(date +%Y%m%d).md"

# Si el archivo de hoy no existe, crearlo con cabecera
if [ ! -f "$ARCHIVO_LOG" ]; then
  cat > "$ARCHIVO_LOG" << EOF
# 📋 Ops Log — $(date +%Y-%m-%d)

_Registro automático de operaciones del día._

---

EOF
fi

# Añadir entrada
cat >> "$ARCHIVO_LOG" << EOF
## $FECHA

**Acción:** $DESCRIPCION
**Usuario:** $(whoami)@$(hostname)

---

EOF

echo "✅ Registrado en $ARCHIVO_LOG"
echo "   → '$DESCRIPCION'"

# Opcional: auto-commit al repo
# git add "$ARCHIVO_LOG" && git commit -m "📋 ops: $DESCRIPCION" && git push
