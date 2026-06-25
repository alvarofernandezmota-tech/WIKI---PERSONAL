#!/usr/bin/env bash
# fix-permisos.sh — dar permisos de ejecución a todos los scripts
# Ejecutar: bash scripts/fix-permisos.sh
set -e
echo "🔧 Aplicando permisos..."
chmod +x scripts/bc
chmod +x scripts/batcueva-control.sh
chmod +x scripts/inicio-sesion.sh 2>/dev/null || true
echo "✅ Permisos OK"
echo ""
echo "📋 Recuerda añadir el alias en ~/.zshrc:"
echo '   echo "alias bc=~/yggdrasil-dew/scripts/bc" >> ~/.zshrc'
echo '   source ~/.zshrc'
