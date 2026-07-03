#!/usr/bin/env bash
# =============================================================================
# smoke-test-scripts.sh
# Descripción: Testeo rápido de todos los scripts del ecosistema
# Ejecutar:    bash ~/yggdrasil-dew/scripts/tests/smoke-test-scripts.sh
# Compatible:  bash, zsh (NO blink — usa arrays)
# Autor:       thdora-guardian | 2026-07-03
# =============================================================================

PASS=0
FAIL=0
SKIP=0
REPO_ROOT="$HOME/yggdrasil-dew"

check() {
  local desc="$1"
  local cmd="$2"
  if eval "$cmd" > /dev/null 2>&1; then
    echo "  ✅ $desc"
    ((PASS++))
  else
    echo "  ❌ $desc"
    ((FAIL++))
  fi
}

skip() {
  local desc="$1"
  local reason="$2"
  echo "  ⏭️ $desc — SKIP: $reason"
  ((SKIP++))
}

echo ""
echo "🧪 SMOKE TEST — Scripts Ecosistema Yggdrasil"
echo "$(date '+%Y-%m-%d %H:%M')"
echo "────────────────────────────────────────"

# ─── 1. Verificar que los scripts existen ─────────────────────────────────
echo ""
echo "📂 1. Scripts existen:"
check "close-session.sh existe"     "[ -f $REPO_ROOT/scripts/maintenance/close-session.sh ]"
check "new-session.sh existe"       "[ -f $REPO_ROOT/scripts/maintenance/new-session.sh ]"
check "health-check.sh existe"      "[ -f $REPO_ROOT/scripts/maintenance/health-check.sh ]"
check "night-cron.sh existe"        "[ -f $REPO_ROOT/scripts/maintenance/night-cron.sh ]"
check "SCRIPTS.md existe"           "[ -f $REPO_ROOT/scripts/SCRIPTS.md ]"

# ─── 2. Verificar que son ejecutables o tienen shebang ───────────────────
echo ""
echo "⚡ 2. Shebang correcto:"
for script in $REPO_ROOT/scripts/**/*.sh $REPO_ROOT/scripts/*.sh; do
  [ -f "$script" ] || continue
  NAME=$(basename "$script")
  check "$NAME tiene shebang" "head -1 '$script' | grep -q '#!/'"
done

# ─── 3. Verificar que los scripts NO tienen set -e sin compat note ───────
echo ""
echo "📱 3. Compatibilidad blink:"
for script in $REPO_ROOT/scripts/maintenance/*.sh; do
  [ -f "$script" ] || continue
  NAME=$(basename "$script")
  if grep -q 'set -euo pipefail' "$script" && ! grep -q 'Compatible.*blink' "$script"; then
    echo "  ⚠️  $NAME — tiene set -euo pipefail sin nota de compatibilidad"
    ((FAIL++))
  else
    echo "  ✅ $NAME — OK compatibilidad"
    ((PASS++))
  fi
done

# ─── 4. Verificar GitHub Actions ──────────────────────────────────────────
echo ""
echo "⚡ 4. GitHub Actions existen:"
check "audit-on-push.yml"           "[ -f $REPO_ROOT/.github/workflows/audit-on-push.yml ]"
check "clasificador.yml"            "[ -f $REPO_ROOT/.github/workflows/clasificador.yml ]"
check "sync-estado.yml"             "[ -f $REPO_ROOT/.github/workflows/sync-estado.yml ]"

# ─── 5. Verificar docs obligatorios ───────────────────────────────────────
echo ""
echo "📖 5. Docs obligatorios:"
check "ROADMAP.md"                  "[ -f $REPO_ROOT/ROADMAP.md ]"
check "MASTER-PENDIENTES.md"        "[ -f $REPO_ROOT/MASTER-PENDIENTES.md ]"
check "ESTADO-SISTEMA.md"           "[ -f $REPO_ROOT/ESTADO-SISTEMA.md ]"
check "CONVENCIONES.md"             "[ -f $REPO_ROOT/CONVENCIONES.md ]"
check "LIGA.md Thdora Guardian"     "[ -f $REPO_ROOT/docs/thdora-guardian/LIGA.md ]"
check "CLASIFICADOR.md"             "[ -f $REPO_ROOT/docs/thdora-guardian/CLASIFICADOR.md ]"

# ─── 6. Conectividad (skip si no hay red) ─────────────────────────────────
echo ""
echo "🌐 6. Conectividad:"
if ping -c 1 -W 2 8.8.8.8 > /dev/null 2>&1; then
  check "GitHub alcanzable" "curl -s --max-time 5 https://api.github.com > /dev/null"
  check "Thdora local (si Docker arriba)" "curl -s --max-time 2 http://localhost:8000/health > /dev/null"
else
  skip "Conectividad" "sin red"
fi

# ─── RESULTADO FINAL ──────────────────────────────────────────────────────
echo ""
echo "────────────────────────────────────────"
echo "📊 RESULTADO: ✅ $PASS | ❌ $FAIL | ⏭️ $SKIP"
if [ "$FAIL" -gt 0 ]; then
  echo "🚨 HAY FALLOS — revisar antes de merge"
  exit 1
else
  echo "✅ Todo OK"
  exit 0
fi
