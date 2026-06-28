#!/bin/bash
# FASE 2 — Crear scripts/start-batcueva.sh y subirlo al repo
# Prerequisito: Fase 1 completada y Madre rebooted

set -euo pipefail

REPO_DIR="$HOME/yggdrasil-dew"
SCRIPT_PATH="$REPO_DIR/scripts/start-batcueva.sh"

echo "🔴 [04] FASE 2 — Script levantamiento seguro"

echo ""
echo "→ Verificando Fase 1..."
FASE1_OK=true

sudo ufw status | grep -q "Status: active" && echo "✅ UFW activo" || { echo "❌ UFW inactivo"; FASE1_OK=false; }
tailscale status 2>/dev/null | grep -q "100\." && echo "✅ Tailscale conectado" || { echo "❌ Tailscale no conectado"; FASE1_OK=false; }

[ "$FASE1_OK" = true ] || { echo "❌ Completa Fase 1 primero."; exit 1; }

mkdir -p "$REPO_DIR/scripts"

cat > "$SCRIPT_PATH" << 'STARTSCRIPT'
#!/bin/bash
# start-batcueva.sh — Levantamiento seguro del stack Batcueva
set -euo pipefail

echo "🛡️ Verificando seguridad antes de levantar..."

if ! sudo ufw status | grep -q "Status: active"; then
  echo "❌ UFW inactivo. Abortando."; exit 1
fi
echo "✅ UFW activo"

if ! tailscale status | grep -q "100\."; then
  echo "❌ Tailscale no conectado. Abortando."; exit 1
fi
echo "✅ Tailscale activo"

if ! systemctl is-active hostapd > /dev/null 2>&1; then
  echo "⚠️ hostapd no activo (MadreAP caído)"
fi

echo "🚀 Levantando stack principal..."
docker compose -f ~/docker/docker-compose.yml up -d

echo "✅ Stack levantado."
echo "   Portainer:   http://100.91.112.32:9000"
echo "   Open WebUI:  http://100.91.112.32:3000"
echo "   Uptime Kuma: http://100.91.112.32:3002"
echo ""
docker compose -f ~/docker/docker-compose.yml ps
STARTSCRIPT

chmod +x "$SCRIPT_PATH"
echo "✅ $SCRIPT_PATH creado"

bash -n "$SCRIPT_PATH" && echo "✅ Sintaxis OK"

cd "$REPO_DIR"
git add scripts/start-batcueva.sh
git commit -m "feat: add start-batcueva.sh — levantamiento seguro [Fase 2]"
git push origin main
echo "✅ Subido a GitHub"

echo ""
echo "✅ COMPLETADO — $(date '+%d-%m-%Y %H:%M CEST')"
echo "📝 Marca en PLAN: [x] scripts/start-batcueva.sh creado"
echo ""
echo "🚀 Para levantar el stack: bash $SCRIPT_PATH"
