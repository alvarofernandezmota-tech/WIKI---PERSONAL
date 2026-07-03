#!/usr/bin/env bash
# ==============================================================================
# Yggdrasil-DEW Ecosistema - FASE 2: Inbox Watcher Daemon
# Nodo: Madre (varpc) | Rol: Sensor de buzón → dispara reconciliation loop
# Instalación: /usr/local/bin/inbox-watcher.sh
# ==============================================================================

set -euo pipefail

# shellcheck source=scripts/lib/common.sh
source "$(dirname "$0")/lib/common.sh"

WATCH_DIR="${YGG_REPO_DIR}/inbox/"

# Validación previa
check_dependency inotifywait
check_dependency git

log "INFO" "Iniciando Inbox Watcher sobre: $WATCH_DIR"

# Bucle infinito asistido por inotifywait (kernel-level, cero polling)
inotifywait -m -e close_write -e moved_to --format '%f' "$WATCH_DIR" | while read -r FILENAME; do

    # Filtrar estrictamente extensiones Markdown
    if [[ "$FILENAME" != *.md ]]; then
        continue
    fi

    log "INFO" "Detectado nuevo fichero Markdown: $FILENAME"

    cd "$YGG_REPO_DIR"

    # Solo añadir el fichero detectado — nunca git add -A
    git add "inbox/$FILENAME"

    COMMIT_MSG="feat(inbox): auto-sync detectado nuevo contenido ($FILENAME) [AUTO]"

    if git commit -m "$COMMIT_MSG" >> "$YGG_LOG_FILE" 2>&1; then
        log "INFO" "Commit generado: $COMMIT_MSG"

        # Tolerancia a fallos de red 4G: 3 intentos con backoff
        PUSH_SUCCESS=false
        for intento in 1 2 3; do
            log "INFO" "Intento push $intento/3..."
            if git push origin main >> "$YGG_LOG_FILE" 2>&1; then
                log "INFO" "Push exitoso → GitHub Actions disparadas."
                PUSH_SUCCESS=true
                break
            else
                log "WARN" "Push fallido. Reintentando en $((intento * 5))s..."
                sleep $((intento * 5))
            fi
        done

        if [ "$PUSH_SUCCESS" = false ]; then
            # Fallback: guardar en failed-pushes/ para reintentar después
            FAIL_DIR="${YGG_REPO_DIR}/inbox/failed-pushes"
            mkdir -p "$FAIL_DIR"
            echo "$FILENAME" >> "${FAIL_DIR}/pending-$(date +%Y%m%d).txt"
            log "ERROR" "Push fallido tras 3 intentos. Guardado en failed-pushes/ para retry."
        fi
    else
        log "INFO" "Sin cambios reales en $FILENAME (ya en índice o idéntico)."
    fi
done
