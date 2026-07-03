#!/usr/bin/env bash
# ==============================================================
# INICIO DE SESIÓN — yggdrasil-dew
# Uso: bash scripts/inicio-sesion.sh
# ==============================================================
set -e
REPO="$HOME/yggdrasil-dew"
cd "$REPO"

echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║        🌳 YGGDRASIL-DEW — INICIO SESIÓN      ║"
echo "╚══════════════════════════════════════════════╝"
echo ""

# 1. Sincronizar repo
echo "📦 [1/5] Sincronizando repo..."
git pull --rebase 2>&1 | tail -3

# 2. Permisos scripts
echo "🔑 [2/5] Fijando permisos scripts..."
find scripts/ -name '*.sh' -exec chmod +x {} \;
find scripts/ -name '*.py' -exec chmod +x {} \;
# Quitar ejecución a archivos sin extensión que no sean scripts
chmod -x scripts/bc 2>/dev/null && chmod +x scripts/bc 2>/dev/null || true

# 3. Estado git
echo "📊 [3/5] Estado repo:"
git status --short | head -20
echo "  Último commit: $(git log --oneline -1)"

# 4. Issues abiertos (requiere gh)
if command -v gh &>/dev/null; then
  echo "🎫 [4/5] Issues abiertos:"
  gh issue list --limit 10 --state open 2>/dev/null | head -15 || echo "  (gh no autenticado)"
else
  echo "⚠️  [4/5] gh no instalado — instalar con: yay -S github-cli"
fi

# 5. Servicios Madre
echo "🖥️  [5/5] Servicios:"
for svc in ollama ssh ufw; do
  status=$(systemctl is-active $svc 2>/dev/null || echo "desconocido")
  icon=$([ "$status" = "active" ] && echo "✅" || echo "❌")
  echo "  $icon $svc: $status"
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📋 Issue activo: https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/29"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
