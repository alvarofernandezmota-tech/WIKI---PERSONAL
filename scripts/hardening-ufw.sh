#!/bin/bash
# ============================================================
# hardening-ufw.sh — Corregir y endurecer UFW en madre
# Fecha: 2026-07-01
# Ejecutar: bash ~/yggdrasil-dew/scripts/hardening-ufw.sh
# ============================================================

set -e

echo "[🔒] Iniciando hardening UFW madre..."

# --- PASO 1: Borrar reglas incorrectas 192.168.1.0/24 ---
echo "[1/4] Borrando reglas incorrectas 192.168.1.0/24..."
for port in 3001 5678 8443 3003 9000 3002 3000 9090 11434 6333 8000 5001 6901 6334; do
  sudo ufw delete allow from 192.168.1.0/24 to any port $port 2>/dev/null || true
done
echo "    ✅ Reglas 192.168.1.0/24 eliminadas"

# --- PASO 2: Añadir reglas correctas ---
echo "[2/4] Añadiendo reglas correctas..."
REDES="10.48.234.0/24 192.168.72.0/24 100.64.0.0/10"
PUERTOS="3000 3001 3002 3003 5001 5678 6333 6334 6901 8000 8443 9000 9090 11434 11435 19999 2222"

for red in $REDES; do
  for puerto in $PUERTOS; do
    sudo ufw allow from $red to any port $puerto 2>/dev/null || true
  done
done
echo "    ✅ Reglas LAN + MadreAP + Tailscale añadidas"

# --- PASO 3: Cerrar puertos peligrosos ---
echo "[3/4] Cerrando puertos peligrosos..."
sudo ufw deny 24800   # input-leaps KVM
sudo ufw deny 5355    # mDNS/LLMNR
echo "    ✅ 24800 (input-leaps) y 5355 (mDNS) bloqueados"

# --- PASO 4: Verificar ---
echo "[4/4] Estado UFW final:"
sudo ufw status numbered

echo ""
echo "[✅] Hardening completado."
echo "[!] Recuerda: Ollama :11434 y Qdrant :6333 siguen sin auth dentro de LAN."
echo "[!] Pendiente: configurar auth en Ollama y Qdrant (SEC-004)"
