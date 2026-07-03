#!/bin/bash
# FASE 1 — SSH Hardening + UFW + Tailscale autoarranque + Deshabilitar suspensión
# ⚠️ Requiere confirmaciones manuales en cada paso crítico

set -euo pipefail

SSHD_CONFIG="/etc/ssh/sshd_config"
UFW_SCRIPT="$HOME/yggdrasil-dew/setup/servidor/ufw-reglas-completas.sh"

echo "🔴 [03] FASE 1 — Seguridad de red Madre"
echo ""
read -p "¿Continuar? (escribe 'si'): " CONFIRM
[ "$CONFIRM" = "si" ] || { echo "Abortado."; exit 0; }

# ── 1.1 SSH Hardening ──────────────────────────────────────
echo ""
echo "━━ 1.1 SSH Hardening ━━"

sudo cp "$SSHD_CONFIG" "${SSHD_CONFIG}.bak.$(date +%Y%m%d)"
echo "✅ Backup creado"

if grep -q "^PasswordAuthentication" "$SSHD_CONFIG"; then
  sudo sed -i 's/^PasswordAuthentication.*/PasswordAuthentication no/' "$SSHD_CONFIG"
else
  echo "PasswordAuthentication no" | sudo tee -a "$SSHD_CONFIG"
fi
echo "✅ PasswordAuthentication → no"

if grep -q "^PubkeyAuthentication" "$SSHD_CONFIG"; then
  sudo sed -i 's/^PubkeyAuthentication.*/PubkeyAuthentication yes/' "$SSHD_CONFIG"
else
  echo "PubkeyAuthentication yes" | sudo tee -a "$SSHD_CONFIG"
fi
echo "✅ PubkeyAuthentication → yes"

if [ ! -s "$HOME/.ssh/authorized_keys" ]; then
  echo "❌ ALERTA: No hay authorized_keys. Añade tu clave antes de continuar."
  echo "   ssh-copy-id -i ~/.ssh/id_rsa.pub varopc@100.91.112.32"
  read -p "¿Continuar de todas formas? (escribe 'fuerza'): " FORCE
  [ "$FORCE" = "fuerza" ] || { echo "Abortado."; exit 1; }
fi

sudo systemctl restart sshd
echo "✅ sshd reiniciado"

echo ""
echo "⚠️  Verifica desde otra terminal: ssh varopc@100.91.112.32"
read -p "¿SSH sigue funcionando? (escribe 'si'): " SSH_OK
if [ "$SSH_OK" != "si" ]; then
  echo "⚠️ Restaurando backup..."
  sudo cp "${SSHD_CONFIG}.bak.$(date +%Y%m%d)" "$SSHD_CONFIG"
  sudo systemctl restart sshd
  echo "Restaurado. Revisa manualmente."
  exit 1
fi

# ── 1.2 UFW ────────────────────────────────────────────────
echo ""
echo "━━ 1.2 UFW Firewall ━━"

if [ -f "$UFW_SCRIPT" ]; then
  echo "→ Usando script del repo..."
  sudo bash "$UFW_SCRIPT"
else
  echo "→ Script repo no encontrado — ejecutando reglas inline"
  sudo ufw --force reset
  sudo ufw default deny incoming
  sudo ufw default allow outgoing
  sudo ufw allow 22/tcp

  PORTS="3001 5678 8443 3003 9000 3002 3000 9090 11434 6333 8000 5001 6901 6334"
  for range in "192.168.1.0/24" "100.64.0.0/10"; do
    for port in $PORTS; do
      sudo ufw allow from "$range" to any port "$port" proto tcp
    done
    echo "✅ Servicios permitidos desde $range"
  done

  sudo ufw allow in on wlan0 to any port 67 proto udp
  echo "✅ DHCP wlan0 permitido"
  sudo ufw --force enable
fi

echo ""
echo "→ Estado UFW:"
sudo ufw status verbose

# ── 1.3 Tailscale autoarranque ─────────────────────────────
echo ""
echo "━━ 1.3 Tailscale autoarranque ━━"
sudo systemctl enable tailscaled
echo "✅ tailscaled habilitado"
tailscale ip -4 || echo "⚠️ Tailscale no conectado — verifica manualmente"

# ── 1.4 Deshabilitar suspensión ────────────────────────────
echo ""
echo "━━ 1.4 Deshabilitar suspensión ━━"
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
echo "✅ Todos los targets de suspensión enmascarados"

# ── 1.5 Reboot ─────────────────────────────────────────────
echo ""
echo "━━ 1.5 Reboot ━━"
echo ""
echo "📝 Documenta en ESTADO-SISTEMA.md antes de rebotar:"
echo "   [x] SSH hardening — PasswordAuthentication no"
echo "   [x] UFW activo con reglas LAN + Tailscale"
echo "   [x] tailscaled habilitado para autoarranque"
echo "   [x] Suspensión enmascarada"
echo ""
read -p "¿Rebotar ahora? (escribe 'reboot'): " DO_REBOOT
if [ "$DO_REBOOT" = "reboot" ]; then
  echo "🔄 Reiniciando en 5 segundos..."
  sleep 5
  sudo reboot
else
  echo "⏸️ Reboot pospuesto. Ejecuta: sudo reboot"
fi
