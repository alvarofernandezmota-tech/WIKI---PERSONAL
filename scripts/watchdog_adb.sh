#!/bin/bash
# =============================================================================
# watchdog_adb.sh — Monitor y reconector de dispositivos Android vía ADB
# Autor: Álvaro Fernández Mota | yggdrasil-dew
# Contexto: Auditoría/gestión de activos móviles en red local o Tailscale
# Risk_Level: Medium — ADB abierto permite ejecución remota de comandos
# Context: Red local o VPN Tailscale privada, sin exposición a WAN
# =============================================================================

set -euo pipefail

# --- CONFIGURACIÓN -----------------------------------------------------------
DEVICE_IP="${1:-10.28.231.115}"   # IP por defecto o pasar como argumento $1
DEVICE_PORT="5555"
LOG_FILE="${HOME}/.local/log/watchdog_adb.log"
SCRCPY_TITLE="Device Monitor"

# --- FUNCIONES ---------------------------------------------------------------
log() {
    local level="$1"
    shift
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] [$level] $*" | tee -a "$LOG_FILE"
}

check_deps() {
    for dep in adb scrcpy; do
        if ! command -v "$dep" &>/dev/null; then
            log ERROR "Dependencia no encontrada: $dep"
            exit 1
        fi
    done
}

connect_device() {
    log INFO "Intentando conexión a ${DEVICE_IP}:${DEVICE_PORT}..."
    adb connect "${DEVICE_IP}:${DEVICE_PORT}" 2>&1 | tee -a "$LOG_FILE"
}

verify_connection() {
    if adb -s "${DEVICE_IP}:${DEVICE_PORT}" shell getprop ro.product.model &>/dev/null; then
        local model
        model=$(adb -s "${DEVICE_IP}:${DEVICE_PORT}" shell getprop ro.product.model 2>/dev/null)
        local android_ver
        android_ver=$(adb -s "${DEVICE_IP}:${DEVICE_PORT}" shell getprop ro.build.version.release 2>/dev/null)
        log INFO "Conectado: $model (Android $android_ver)"
        return 0
    else
        log ERROR "Dispositivo no responde en ${DEVICE_IP}:${DEVICE_PORT}"
        return 1
    fi
}

launch_scrcpy() {
    log INFO "Lanzando scrcpy..."
    scrcpy \
        --serial "${DEVICE_IP}:${DEVICE_PORT}" \
        --window-title "${SCRCPY_TITLE} — ${DEVICE_IP}" \
        --turn-screen-off \
        --stay-awake
}

# --- MAIN --------------------------------------------------------------------
main() {
    mkdir -p "$(dirname "$LOG_FILE")"
    log INFO "=== watchdog_adb iniciado ==="
    
    check_deps
    connect_device
    
    if verify_connection; then
        launch_scrcpy
    else
        log ERROR "Fallo de conexión. Revisa: IP correcta, Tailscale activo, depuración USB habilitada."
        exit 1
    fi
    
    log INFO "=== watchdog_adb finalizado ==="
}

main "$@"
