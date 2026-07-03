#!/usr/bin/env bash
# ==============================================================
# CIERRE DE SESIÓN — yggdrasil-dew
# Uso: bash scripts/cierre-sesion.sh
# Ruta canónica: /srv/yggdrasil-dew (con fallback a $HOME/yggdrasil-dew)
#
# REQUISITO para modo automático sin passphrase:
#   eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_ed25519_github
#   O añadir al ~/.bashrc / ~/.zshrc para que se cargue al login.
# ==============================================================
set -euo pipefail

# ── Ruta canónica ──────────────────────────────────────────────
if [ -d "/srv/yggdrasil-dew" ]; then
  REPO="/srv/yggdrasil-dew"
elif [ -d "$HOME/yggdrasil-dew" ]; then
  REPO="$HOME/yggdrasil-dew"
else
  echo "[ERROR] Repo no encontrado. Ejecuta bootstrap-madre.sh primero."
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
echo "  Repo : $REPO"
echo "  Fecha: $FECHA $HORA"
echo ""

# ── 0. Limpieza de ficheros basura en worktree ─────────────────
# Elimina ficheros sueltos que no deberían estar en la raíz
echo "🧹 [0/5] Limpiando worktree..."
for f in GitHub "GitHub:" cd find; do
  [ -f "$f" ] && rm -f "$f" && echo "    rm: $f"
done
# Limpia symlinks rotos
find . -maxdepth 1 -type l ! -name '.git*' | while read -r link; do
  [ ! -e "$link" ] && echo "    rm symlink roto: $link" && rm -f "$link"
done

# ── 1. Estado git ──────────────────────────────────────────────
echo "📊 [1/5] Estado repo:"
git status --short | head -20

# ── 2. Commit automático ───────────────────────────────────────
if ! git diff --quiet || ! git diff --staged --quiet; then
  echo "💾 [2/5] Cambios detectados — commit automático..."
  git add -A
  git commit -m "chore(sesion): auto-commit cierre $FECHA $HORA"
else
  echo "✅ [2/5] Nada pendiente de commit."
fi

# ── 3. Pull rebase (SIEMPRE antes de push) ────────────────────
echo "⬇️  [3/5] Pull rebase para sincronizar con remoto..."
if git pull --rebase --autostash 2>&1 | tee /tmp/ygg-pull.log | grep -q "CONFLICT"; then
  echo "❌ [3/5] Conflicto de merge — resuelve manualmente:"
  cat /tmp/ygg-pull.log
  exit 1
fi

# ── 4. Push ───────────────────────────────────────────────────
echo "🚀 [4/5] Push al repo..."
git push 2>&1 | tail -3 || {
  echo "❌ [4/5] Push fallido. Posibles causas:"
  echo "   - SSH passphrase no cargada. Ejecuta: ssh-add ~/.ssh/id_ed25519_github"
  echo "   - Sin conexión. Verifica Tailscale o red."
  exit 1
}

# ── 5. Diario de cierre ────────────────────────────────────────
mkdir -p sesiones
DIARIO="sesiones/${FECHA}-cierre.md"
if [ ! -f "$DIARIO" ]; then
  echo "📓 [5/5] Creando diario de cierre..."
  cat > "$DIARIO" << EOF
---
fecha: $FECHA
hora_cierre: $HORA CEST
tipo: cierre-sesion
repo: $REPO
---

# Cierre $FECHA $HORA

## Hecho hoy
- [ ] TODO: rellenar antes de cerrar

## Pendiente para mañana
- Issues: https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues

## Último commit
$(git log --oneline -1)
EOF
  git add "$DIARIO"
  git commit -m "docs(sesion): cierre $FECHA $HORA"
  git push
  echo "    Diario: $DIARIO"
else
  echo "📓 [5/5] Diario ya existe: $DIARIO"
fi

# ── Resumen ────────────────────────────────────────────────────
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ SESIÓN CERRADA — $FECHA $HORA"
echo "   Issues: https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "  Para modo autónomo sin passphrase, añade al ~/.bashrc:"
echo "  eval \"\$(ssh-agent -s)\" && ssh-add ~/.ssh/id_ed25519_github 2>/dev/null"
echo ""
