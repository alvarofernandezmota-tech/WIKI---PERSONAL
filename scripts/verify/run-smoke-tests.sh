#!/usr/bin/env bash
# scripts/verify/run-smoke-tests.sh
# Suite de smoke tests del ecosistema Yggdrasil-Dew.
# Retorna 0 si todos pasan, 1 si alguno falla.
set -euo pipefail

ROOT="${YGGDRASIL_ROOT:-$(pwd)}"
FAILS=0
PASS=0

check() {
  local desc="$1"
  local cmd="$2"
  if eval "$cmd" >/dev/null 2>&1; then
    echo "  ✓ $desc"
    PASS=$((PASS+1))
  else
    echo "  ✗ $desc"
    FAILS=$((FAILS+1))
  fi
}

echo "═══════════════════════════════════════"
echo "  Smoke Tests — Yggdrasil-Dew          "
echo "  $(date -Iseconds)                    "
echo "═══════════════════════════════════════"
echo ""
echo "── Estructura de carpetas"
check "scripts/ existe"                    "[ -d '$ROOT/scripts' ]"
check "inbox/ existe"                      "[ -d '$ROOT/inbox' ]"
check "diarios/ existe"                    "[ -d '$ROOT/diarios' ]"
check "agentes/ existe"                    "[ -d '$ROOT/agentes' ]"
check "tools/ existe"                      "[ -d '$ROOT/tools' ]"
check "docs/ existe"                       "[ -d '$ROOT/docs' ]"
check ".github/workflows/ existe"          "[ -d '$ROOT/.github/workflows' ]"

echo ""
echo "── Scripts ejecutables"
check "file-arrival-guardian.sh"           "[ -x '$ROOT/scripts/file-arrival-guardian.sh' ]"
check "inbox-commit.sh"                    "[ -x '$ROOT/scripts/inbox-commit.sh' ]"
check "inbox-clasificador.sh"              "[ -x '$ROOT/scripts/inbox-clasificador.sh' ]"
check "cierre-sesion.sh"                   "[ -x '$ROOT/scripts/cierre-sesion.sh' ]"
check "master_run.sh"                      "[ -x '$ROOT/scripts/maintenance/master_run.sh' ]"
check "agente-meta-deep.sh"                "[ -x '$ROOT/scripts/agentes/agente-meta-deep.sh' ]"
check "observador-obsidian.sh"             "[ -x '$ROOT/scripts/observador-obsidian.sh' ]"

echo ""
echo "── Herramientas Python"
check "tools/perplexity_adapter.py existe" "[ -f '$ROOT/tools/perplexity_adapter.py' ]"
check "python3 disponible"                 "command -v python3"

echo ""
echo "── Agentes"
check "agent-perplexity-informer/run.sh"   "[ -x '$ROOT/agentes/agent-perplexity-informer/run.sh' ]"
check "agent-perplexity-informer/DISEÑO"   "[ -f '$ROOT/agentes/agent-perplexity-informer/DISEÑO.md' ]"

echo ""
echo "── Documentación"
check "OPERATIONAL-PLAYBOOK.md"            "[ -f '$ROOT/docs/OPERATIONAL-PLAYBOOK.md' ]"
check "OWNERS.md"                          "[ -f '$ROOT/docs/OWNERS.md' ]"
check "SCRIPTS-AUDITORIA.md"               "[ -f '$ROOT/scripts/SCRIPTS-AUDITORIA.md' ]"

echo ""
echo "── Git"
check "git disponible"                     "command -v git"
check "repo es git"                        "[ -d '$ROOT/.git' ]"

echo ""
echo "═══════════════════════════════════════"
echo "  Resultado: $PASS OK / $FAILS FAIL    "
echo "═══════════════════════════════════════"
[ "$FAILS" -eq 0 ] && exit 0 || exit 1
