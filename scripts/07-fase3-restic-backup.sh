#!/bin/bash
# ==============================================================================
# SCRIPT: 07-fase3-restic-backup.sh
# OBJETIVO: Automatizar snapshot de ./data/ hacia Cloudflare R2 usando Restic.
# ==============================================================================

set -e

echo "[+] Iniciando Fase 3: Respaldo de seguridad con Restic..."

# 1. Cargar variables de entorno
if [ -f ".env.restic" ]; then
    source .env.restic
else
    echo "[!] Error: No se encuentra el archivo .env.restic con las credenciales."
    echo "    Crea .env.restic a partir de infra/restic-excludes.txt y .env.restic.template"
    exit 1
fi

# 2. Inicializar repo en R2 si no existe
echo "[+] Comprobando conectividad con el repositorio R2..."
if ! restic stats >/dev/null 2>&1; then
    echo "[*] Repositorio no detectado. Inicializando por primera vez en Cloudflare R2..."
    restic init
else
    echo "[+] Repositorio listo y accesible."
fi

# 3. Ejecutar backup con exclusiones
echo "[+] Ejecutando copia de seguridad del directorio ./data/..."
restic backup ./data/ \
    --exclude-file=infra/restic-excludes.txt \
    --tag "madre-core" \
    --verbose

# 4. Política de retención
echo "[+] Aplicando política de retención..."
restic forget \
    --keep-last 7 \
    --keep-weekly 4 \
    --keep-monthly 12 \
    --prune

# 5. Verificación de integridad
echo "[+] Verificando consistencia de los datos en la nube..."
restic check --read-data-subset=10%

echo "[+] Fase 3 completada. Datos protegidos en Cloudflare R2."
