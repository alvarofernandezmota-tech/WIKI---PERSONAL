#!/bin/bash
# cierre-sesion.sh — Crea un diario de cierre y hace push al repo
# Uso: ./scripts/cierre-sesion.sh
#
# Pide resumen de lo que hiciste hoy, crea el archivo y hace commit+push

set -e

FECHA=$(date +%Y%m%dT%H%M%S)
ARCHIVO="diarios/cierre-${FECHA}.md"

echo "🌙 Cierre de sesión Yggdrasil"
echo "=============================="
echo ""
read -p "¿Qué hiciste hoy? (resumen breve): " RESUMEN
read -p "¿Algún bloqueo o pendiente importante?: " PENDIENTE
read -p "¿Cómo está el sistema? (🟢/🟡/🔴): " ESTADO

cat > "$ARCHIVO" << EOF
# 🌙 Cierre — $(date +%Y-%m-%d)

## Resumen
$RESUMEN

## Pendientes para mañana
$PENDIENTE

## Estado del sistema
$ESTADO

## Timestamp
$FECHA
EOF

echo ""
echo "✅ Archivo creado: $ARCHIVO"
echo ""

# Commit y push
git add -A
git commit -m "🌙 cierre: $(date +%Y-%m-%d) — $RESUMEN"
git push

echo "✅ Sincronizado con GitHub"
