#!/usr/bin/env bash
# ==============================================================================
# Yggdrasil-DEW Ecosistema - Biblioteca del Núcleo Común
# Versión: 1.0.0 | Fecha: 2026-07-03
# Uso: source scripts/lib/common.sh
# ==============================================================================

# No aplicar set -euo pipefail aquí — se aplica en el script que hace source.
# El sourcing heredará el set del script padre.

# ── Variables globales de entorno ─────────────────────────────────────────────
export YGG_LOG_FILE="${YGG_LOG_FILE:-/var/log/yggdrasil-dew-maintenance.log}"
export YGG_REPO_DIR="${YGG_REPO_DIR:-/srv/yggdrasil-dew}"
export YGG_INBOX_DIR="${YGG_INBOX_DIR:-${YGG_REPO_DIR}/inbox}"
export YGG_DRY_RUN="${YGG_DRY_RUN:-false}"

# ── 1. Logging unificado ISO 8601 ─────────────────────────────────────────────
log() {
    local level="${1:-INFO}"
    local msg="${2:-}"
    local timestamp
    timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    printf "[%s] [%s] [AUTO] %s\n" "$timestamp" "$level" "$msg" | tee -a "$YGG_LOG_FILE"
}

error() {
    log "ERROR" "${1:-}" >&2
}

warn() {
    log "WARN" "${1:-}"
}

# ── 2. Verificación de dependencias ───────────────────────────────────────────
check_dependency() {
    local cmd="$1"
    if ! command -v "$cmd" &>/dev/null; then
        error "Dependencia crítica ausente: '$cmd'. Instalación requerida."
        return 1
    fi
    log "DEBUG" "Dependencia OK: $cmd"
}

# ── 3. Modo dry-run ───────────────────────────────────────────────────────────
# Uso: dry_run_exec git push origin main
# En modo dry-run solo loguea, no ejecuta.
dry_run_exec() {
    if [ "$YGG_DRY_RUN" = "true" ]; then
        log "DRY-RUN" "[NO EJECUTADO] $*"
        return 0
    fi
    "$@"
}

# ── 4. Creación de GitHub Issues (con fallback local) ─────────────────────────
create_issue() {
    local title="$1"
    local body="$2"
    local label="${3:-AUTO}"

    log "GIT" "Creando issue [$label]: $title"

    check_dependency gh || return 1
    cd "$YGG_REPO_DIR"

    if dry_run_exec gh issue create \
        --title "[$label] $title" \
        --body "$body" \
        --label "$label" >> "$YGG_LOG_FILE" 2>&1; then
        log "GIT" "Issue creado correctamente."
    else
        warn "Fallo API GitHub. Guardando en inbox como fallback."
        local fail_file="${YGG_INBOX_DIR}/failed-issue-$(date +%s).md"
        mkdir -p "$YGG_INBOX_DIR"
        {
            printf -- '---\n'
            printf 'type: auto-issue-fallback\n'
            printf 'title: %s\n' "$title"
            printf 'label: %s\n' "$label"
            printf 'date: %s\n' "$(date -u +%Y-%m-%d)"
            printf -- '---\n\n'
            printf '%s\n' "$body"
        } > "$fail_file"
        log "INFO" "Fallback guardado en: $fail_file"
    fi
}

# ── 5. Push con reintentos y backoff ──────────────────────────────────────────
git_push_with_retry() {
    local max_attempts="${1:-3}"
    local branch="${2:-main}"

    for intento in $(seq 1 "$max_attempts"); do
        log "INFO" "Push intento $intento/$max_attempts → origin/$branch"
        if dry_run_exec git push origin "$branch" >> "$YGG_LOG_FILE" 2>&1; then
            log "INFO" "Push exitoso en intento $intento."
            return 0
        fi
        local delay=$((intento * 5))
        warn "Push fallido. Reintentando en ${delay}s..."
        sleep "$delay"
    done

    error "Push fallido tras $max_attempts intentos. Red 4G inaccesible."
    return 1
}

# ── 6. Verificar que estamos en el repo correcto ──────────────────────────────
check_repo_context() {
    local expected_remote="yggdrasil-dew"
    if ! git -C "$YGG_REPO_DIR" remote -v 2>/dev/null | grep -q "$expected_remote"; then
        error "Contexto Git incorrecto. No estamos en $expected_remote."
        return 1
    fi
}

# ── 7. Timestamp para nombres de archivo ─────────────────────────────────────
timestamp_filename() {
    local prefix="${1:-log}"
    local ext="${2:-md}"
    printf '%s-%s.%s' "$prefix" "$(date -u +%Y-%m-%d)" "$ext"
}

log "DEBUG" "common.sh cargado correctamente. DRY_RUN=${YGG_DRY_RUN}"
