#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# =============================================================================
# Nombre:       copilot-fases.sh
# Función única: Prepara el contexto completo para Copilot en Fase 1 o Fase 2
# Rol:          orquestador-copilot
# Versión:      1.0
# Autor:        Perplexity-MCP <alvarofernandezmota@gmail.com>
# Creado:       2026-07-03 23:55 CEST
# Actualizado:  2026-07-03 23:55 CEST
# Ruta:         scripts/copilot-fases.sh
# Tags:         [copilot, fases, contexto, orquestador]
# Flags:
#   --fase 1    Prepara Fase 1: Copilot como generador de código con contexto
#   --fase 2    Prepara Fase 2: Copilot como revisor de PRs
#   --check     Solo verifica si el contexto está listo (sin hacer nada)
#   --verbose   Log detallado
# =============================================================================

FASE=""
CHECK_ONLY=false
VERBOSE=false
REPO_ROOT="${REPO_ROOT:-.}"

log(){ printf '%s %s\n' "$(date -u +'%Y-%m-%dT%H:%M:%SZ')" "$*"; }
ok(){  printf '%s ✅ %s\n' "$(date -u +'%Y-%m-%dT%H:%M:%SZ')" "$*"; }
warn(){ printf '%s ⚠️  %s\n' "$(date -u +'%Y-%m-%dT%H:%M:%SZ')" "$*"; }
err(){  printf '%s ❌ %s\n' "$(date -u +'%Y-%m-%dT%H:%M:%SZ')" "$*" >&2; }
on_err(){ err "Error en línea $1"; exit 2; }
trap 'on_err $LINENO' ERR

while [[ "${1:-}" != "" ]]; do
  case "$1" in
    --fase) FASE="$2"; shift 2 ;;
    --check) CHECK_ONLY=true; shift ;;
    --verbose) VERBOSE=true; shift ;;
    *) shift ;;
  esac
done

# ─── ARCHIVOS DE CONTEXTO OBLIGATORIOS PARA COPILOT ──────────────────────────
CONTEXT_FILES=(
  "AGENT.md"
  "CONVENCIONES.md"
  "COPILOT-CONTEXT.md"
  "CONTEXT.md"
  "HERRAMIENTAS-ECOSISTEMA.md"
  "MAPA-ISLAS.md"
  "MASTER-PENDIENTES.md"
)

check_context(){
  log "Verificando archivos de contexto..."
  local missing=0
  for f in "${CONTEXT_FILES[@]}"; do
    if [[ -f "$REPO_ROOT/$f" ]]; then
      local size
      size=$(wc -c < "$REPO_ROOT/$f")
      if [[ "$size" -gt 500 ]]; then
        ok "$f (${size}B)"
      else
        warn "$f existe pero es muy pequeño (${size}B) — posiblemente incompleto"
      fi
    else
      err "$f NO EXISTE"
      missing=$((missing+1))
    fi
  done
  return $missing
}

check_inbox(){
  log "Verificando inbox..."
  local count
  count=$(find "$REPO_ROOT/inbox" -type f -not -path '*/.tracker/*' 2>/dev/null | wc -l | tr -d ' ')
  if [[ "$count" -ge 3 ]]; then
    ok "inbox tiene $count artefactos (mínimo 3 para Copilot Fase 1)"
    return 0
  else
    warn "inbox tiene solo $count artefactos (necesita ≥3 para Copilot Fase 1)"
    return 1
  fi
}

check_prs_for_review(){
  if ! command -v gh >/dev/null 2>&1; then
    warn "gh CLI no disponible — no se puede verificar PRs"
    return 1
  fi
  local count
  count=$(gh pr list --base main --json number --jq 'length' 2>/dev/null || echo 0)
  if [[ "$count" -gt 0 ]]; then
    ok "Hay $count PRs abiertos para revisar (Copilot Fase 2)"
    return 0
  else
    warn "No hay PRs abiertos para revisar"
    return 1
  fi
}

print_fase1_instructions(){
  cat <<EOF

╔══════════════════════════════════════════════════════════════════╗
║           COPILOT FASE 1 — GENERADOR DE CÓDIGO                  ║
╚══════════════════════════════════════════════════════════════════╝

✅ El contexto está listo. Para usar Copilot en Fase 1:

1. Crea una rama:
   git checkout -b copilot/$(date +%Y-%m-%d)-<tarea>

2. Abre GitHub Copilot Chat y pásale este contexto:
   @workspace Eres un agente que trabaja en yggdrasil-dew.
   Lee AGENT.md, CONVENCIONES.md y COPILOT-CONTEXT.md antes de
   escribir código. Siempre usa la cabecera de script obligatoria
   de CONVENCIONES.md sección 7. Siempre dry-run primero.
   Tu tarea: [DESCRIBE LA TAREA]

3. Copilot trabaja SOLO en la rama copilot/*
4. Cuando termine: abre PR → agente-fixer.sh --dry-run lo valida
5. Si pasa ELO: merge a main

⚠️  NUNCA permitas que Copilot escriba directo a main.
EOF
}

print_fase2_instructions(){
  cat <<EOF

╔══════════════════════════════════════════════════════════════════╗
║           COPILOT FASE 2 — REVISOR DE PRs                       ║
╚══════════════════════════════════════════════════════════════════╝

✅ Hay PRs listos para revisión. Para usar Copilot en Fase 2:

1. Ve a GitHub → Pull Requests
2. Abre cada PR de agent-fix/* o debt/*
3. En Copilot Chat del PR:
   @copilot Revisa este PR según CONVENCIONES.md.
   Verifica: cabecera de script, dry-run, set -euo pipefail,
   función única declarada, tests correspondientes.

4. Copilot añade comentarios de revisión
5. Tú o agente-fixer aplican los cambios sugeridos
6. Merge solo si pasa protocolo ELO completo

PRs abiertos:
EOF
  gh pr list --base main --json number,title,headRefName 2>/dev/null | \
    jq -r '.[] | "  PR #\(.number) — \(.title) (\(.headRefName))"' || true
}

main(){
  log "copilot-fases.sh iniciado (fase=${FASE:-check})"

  local context_ok=true
  check_context || context_ok=false

  if $CHECK_ONLY; then
    if $context_ok; then
      ok "Contexto listo para Copilot"
    else
      err "Contexto incompleto — revisa archivos faltantes"
      exit 1
    fi
    exit 0
  fi

  case "$FASE" in
    1)
      log "Preparando Fase 1..."
      check_inbox || warn "Inbox escaso — considera ejecutar más agentes primero"
      $context_ok || { err "Contexto incompleto. Ejecuta primero: git pull && verifica los archivos de contexto"; exit 1; }
      print_fase1_instructions
      ;;
    2)
      log "Preparando Fase 2..."
      check_prs_for_review || { warn "No hay PRs. Genera con: agente-mejorador.sh --apply"; exit 0; }
      print_fase2_instructions
      ;;
    "")
      log "Sin fase especificada. Verificando estado general..."
      check_inbox || true
      check_prs_for_review || true
      echo ""
      log "Usa --fase 1 o --fase 2 para continuar"
      ;;
    *)
      err "Fase inválida: $FASE. Usa --fase 1 o --fase 2"
      exit 1
      ;;
  esac

  log "copilot-fases.sh finalizado"
}

main "$@"
