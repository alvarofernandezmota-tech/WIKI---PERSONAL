#!/usr/bin/env bash
# scripts/verify/run-smoke-tests.sh
# Comprueba que todos los ficheros clave del ecosistema existen.
set -euo pipefail

ROOT="${YGGDRASIL_ROOT:-$(pwd)}"
PASS=0
FAIL=0

check() {
  local desc="$1"
  local path="$2"
  if [ -e "$ROOT/$path" ]; then
    echo "  ✓ $desc"
    PASS=$((PASS+1))
  else
    echo "  ✗ $desc — NOT FOUND: $path"
    FAIL=$((FAIL+1))
  fi
}

echo "=== SMOKE TESTS — Yggdrasil-Dew ==="
echo ""
echo "[Herramientas]"
check "Perplexity adapter"          "tools/perplexity_adapter.py"

echo ""
echo "[Agentes]"
check "Informer run.sh"             "agentes/agent-perplexity-informer/run.sh"
check "Informer DISEÑO.md"          "agentes/agent-perplexity-informer/DISEÑO.md"
check "Informer PROFILE.md"         "agentes/agent-perplexity-informer/PROFILE.md"
check "Informer test.sh"            "agentes/agent-perplexity-informer/test.sh"

echo ""
echo "[Scripts]"
check "Master runner"               "scripts/maintenance/master_run.sh"
check "Agente meta-deep"            "scripts/agentes/agente-meta-deep.sh"
check "Obsidian observer"           "scripts/observador-obsidian.sh"
check "Create perplexity patch"     "scripts/maintenance/create_perplexity_patch.sh"

echo ""
echo "[Inbox]"
check "Prompt template Perplexity"  "inbox/context/perplexity/PERPLEXITY_PROMPT_TEMPLATE.txt"
check "Inbox drop zone"             "inbox/drop/.gitkeep"

echo ""
echo "[Docker]"
check "Docker compose"              "docker/docker-compose.yml"
check "MCP Dockerfile"              "docker/mcp/Dockerfile"
check "Retrieval Dockerfile"        "docker/retrieval/Dockerfile"

echo ""
echo "[Workflows]"
check "CI readonly"                 ".github/workflows/ci-readonly.yml"
check "Bot writer template"         ".github/workflows/bot-writer-template.yml"

echo ""
echo "[Docs]"
check "Operational playbook"        "docs/OPERATIONAL-PLAYBOOK.md"
check "Owners"                      "docs/OWNERS.md"
check "Audit log"                   "docs/AUDIT-LOG.md"
check "Scripts README"              "scripts/README.md"
check "Scripts auditoria"           "scripts/SCRIPTS-AUDITORIA.md"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " Smoke tests: $PASS passed, $FAIL failed."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

[ "$FAIL" -eq 0 ] && exit 0 || exit 1
