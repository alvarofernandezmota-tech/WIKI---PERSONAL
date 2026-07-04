#!/bin/bash
# estado-madre.sh — Snapshot rápido del estado de Madre
# Uso: ssh alvaro@100.91.112.32 'bash -s' < scripts/estado-madre.sh
# O si estás dentro de Madre: ./scripts/estado-madre.sh

echo "============================="
echo "🖥  MADRE — Estado del sistema"
echo "============================="
echo ""
echo "📅 Fecha: $(date)"
echo "⏱  Uptime: $(uptime -p)"
echo ""
echo "💾 Disco:"
df -h / | tail -1
echo ""
echo "🧠 RAM:"
free -h | grep Mem
echo ""
echo "🐳 Docker (contenedores activos):"
docker ps --format "  • {{.Names}} — {{.Status}}" 2>/dev/null || echo "  Docker no disponible"
echo ""
echo "🌐 Tailscale:"
tailscale status 2>/dev/null | head -5 || echo "  Tailscale no disponible"
echo ""
echo "============================="
