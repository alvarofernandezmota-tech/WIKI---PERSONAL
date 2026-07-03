#!/usr/bin/env bash
# ==============================================================
# CIERRE DE SESIÓN — yggdrasil-dew
# Uso: bash scripts/cierre-sesion.sh
# Ruta canónica del repo: /srv/yggdrasil-dew
# Si el repo está en $HOME, crea un symlink:
#   ln -s /srv/yggdrasil-dew ~/yggdrasil-dew
# ==============================================================
set -e

# Ruta canónica: /srv/yggdrasil-dew (con fallback a $HOME/yggdrasil-dew)
if [ -d "/srv/yggdrasil-dew" ]; then
  REPO="/srv/yggdrasil-dew"
elif [ -d "$HOME/yggdrasil-dew" ]; then
  REPO="$HOME/yggdrasil-dew"
else
  echo "[ERROR] No se encuentra el repo. Clona primero con bootstrap-madre.sh"
  exit 1
fi

cd "$REPO"

FECHA=$(date +%Y-%m-%d)
HORA=$(date +%H:%M)

echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║       🌙 YGGDRASIL-DEW — CIERRE SESIÓN       ║"
echo "╚══════════════════════════════════════════════╝"
echo ""
echo "  Repo: $REPO"
echo ""

# 1. Estado git antes de cerrar
echo "📊 [1/4] Estado repo:"
git status --short | head -20

# 2. Commit automático de cambios sin commitear
if ! git diff --quiet || ! git diff --staged --quiet; then
  echo "💾 [2/4] Hay cambios sin commitear. Haciendo commit automático..."
  git add -A
  git commit -m "chore(sesion): auto-commit cierre $FECHA $HORA"
else
  echo "✅ [2/4] Nada pendiente de commit."
fi

# 3. Push
echo "🚀 [3/4] Push al repo..."
git push 2>&1 | tail -3

# 4. Crear entrada diario de cierre
mkdir -p sesiones
DIARIO="sesiones/${FECHA}-cierre.md"
if [ ! -f "$DIARIO" ]; then
  cat > "$DIARIO" << EOF
---
fecha: $FECHA
hora_cierre: $HORA CEST
tipo: cierre-sesion
repo: $REPO
---

# Cierre $FECHA $HORA

## Hecho hoy
- [ ] TODO: rellenar

## Pendiente para mañana
- Ver issue tracker: https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues

## Último commit
$(git log --oneline -1)
EOF
  git add "$DIARIO"
  git commit -m "docs(sesion): cierre $FECHA $HORA"
  git push
  echo "📓 Diario creado: $DIARIO"
else
  echo "📓 Diario ya existe: $DIARIO"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ SESIÓN CERRADA — $FECHA $HORA"
echo "   Repo: $REPO"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
