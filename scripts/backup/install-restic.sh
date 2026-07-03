#!/usr/bin/env bash
# =============================================================================
# install-restic.sh — Instalar Restic + crear estructura en Madre
# Ejecutar UNA vez como root o con sudo
# =============================================================================
set -euo pipefail

echo "=== Instalando Restic ==="
apt-get update -qq
apt-get install -y restic
restic self-update 2>/dev/null || true  # actualizar a ultima version

echo "=== Creando estructura de directorios ==="
mkdir -p /mnt/backup/restic
mkdir -p /etc/restic
mkdir -p /var/log/restic

echo "=== Generando password para repositorios ==="
if [[ ! -f /etc/restic/password ]]; then
  openssl rand -base64 32 > /etc/restic/password
  chmod 600 /etc/restic/password
  echo "Password generado en /etc/restic/password"
  echo ">>> GUARDA ESTE PASSWORD EN UN LUGAR SEGURO (Vaultwarden) <<<"
  cat /etc/restic/password
else
  echo "Password ya existe en /etc/restic/password"
fi

echo "=== Permisos ==="
chown -R varopc:varopc /mnt/backup /var/log/restic
chmod 700 /mnt/backup/restic

echo "=== Instalando cron ==="
CRON_LINE="0 3 * * * /home/varopc/yggdrasil-dew/scripts/backup/run-backup.sh all >> /var/log/restic/cron.log 2>&1"
(crontab -u varopc -l 2>/dev/null; echo "$CRON_LINE") | crontab -u varopc -
echo "Cron instalado: backup diario a las 03:00"

CRON_CHECK="0 4 * * 0 /home/varopc/yggdrasil-dew/scripts/backup/check-backup.sh all >> /var/log/restic/check.log 2>&1"
(crontab -u varopc -l 2>/dev/null; echo "$CRON_CHECK") | crontab -u varopc -
echo "Cron instalado: check integridad domingos 04:00"

echo ""
echo "=== SIGUIENTE PASO ==="
echo "Añade al .env de yggdrasil-dew:"
echo ""
echo "  RESTIC_REPO_LOCAL=/mnt/backup/restic"
echo "  RESTIC_REPO_SFTP=sftp:varopc@IP_VAROPC:/backup/restic-madre"
echo "  RESTIC_REPO_B2=b2:batcueva-backup:/restic"
echo "  B2_ACCOUNT_ID=TU_ID"
echo "  B2_ACCOUNT_KEY=TU_KEY"
echo ""
echo "Luego ejecuta: ./run-backup.sh local"
