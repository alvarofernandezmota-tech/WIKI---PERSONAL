#!/usr/bin/env bash
# ==============================================================================
# yggdrasil-dew/scripts/setup/servidor/fase1b-ssh-hardening.sh
# Propósito: Hardening SSH + Fail2Ban
# OS: Arch Linux
# ADVERTENCIA: Mantén una sesión SSH abierta mientras ejecutas esto
# Generado: Sesión Gemini 2026-06-27
# ==============================================================================

set -euo pipefail

NEW_SSH_PORT="2222"

echo "[*] Iniciando hardening de SSH..."

cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak.$(date +%F)

sed -i -E "s/^#?Port .*/Port $NEW_SSH_PORT/" /etc/ssh/sshd_config
sed -i -E "s/^#?PermitRootLogin .*/PermitRootLogin no/" /etc/ssh/sshd_config
sed -i -E "s/^#?PasswordAuthentication .*/PasswordAuthentication no/" /etc/ssh/sshd_config
sed -i -E "s/^#?PubkeyAuthentication .*/PubkeyAuthentication yes/" /etc/ssh/sshd_config
sed -i -E "s/^#?X11Forwarding .*/X11Forwarding no/" /etc/ssh/sshd_config

cat <<EOF > /etc/fail2ban/jail.local
[DEFAULT]
bantime = 1h
findtime = 10m
maxretry = 3
backend = systemd

[sshd]
enabled = true
port = $NEW_SSH_PORT
logpath = %(sshd_log)s
backend = systemd
EOF

sshd -t
if [ $? -eq 0 ]; then
    systemctl restart sshd
    systemctl restart fail2ban
    echo "[+] SSH asegurado en puerto $NEW_SSH_PORT. Fail2Ban activado."
else
    echo "[-] Error en sshd_config. Revertiendo..."
    cp /etc/ssh/sshd_config.bak.$(date +%F) /etc/ssh/sshd_config
    exit 1
fi
