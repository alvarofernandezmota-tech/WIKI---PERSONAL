#!/usr/bin/env bash
# audit-repo.sh — Auditoría rápida del estado del repo
# Uso: bash scripts/maintenance/audit-repo.sh
# needs-terminal: true | mobile-ok: false
# Autor: Gemini + Perplexity MCP — 2026-07-02

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
INBOX="$REPO_ROOT/inbox"
DATE=$(date +%Y-%m-%d)

echo "====================================="
echo " AUDIT YGGDRASIL-DEW — $DATE"
echo "====================================="

# 1. Contar ficheros inbox
INBOX_COUNT=$(find "$INBOX" -maxdepth 1 -name '*.md' | wc -l)
echo ""
echo "📥 INBOX: $INBOX_COUNT ficheros (límite: 10)"
if [ "$INBOX_COUNT" -gt 10 ]; then
  echo "  ⚠️  SUPERA EL LÍMITE — procesar inbox"
fi

# 2. Archivos críticos
echo ""
echo "📄 ARCHIVOS CRÍTICOS:"
for f in CONTEXT.md AGENT.md CONVENCIONES.md MASTER-PENDIENTES.md ECOSISTEMA.md HOME.md; do
  if [ -f "$REPO_ROOT/$f" ]; then
    LAST=$(git log -1 --format='%ar' -- "$f" 2>/dev/null || echo 'sin commits')
    echo "  ✅ $f — último cambio: $LAST"
  else
    echo "  ❌ $f — NO EXISTE"
  fi
done

# 3. CONTEXT.md no más de 7 días
echo ""
echo "🕐 CONTEXT.md antigüedad:"
CONTEXT_DATE=$(git log -1 --format='%ct' -- CONTEXT.md 2>/dev/null || echo 0)
NOW=$(date +%s)
DAYS_OLD=$(( (NOW - CONTEXT_DATE) / 86400 ))
if [ "$DAYS_OLD" -gt 7 ]; then
  echo "  ⚠️  Sin actualizar hace $DAYS_OLD días"
else
  echo "  ✅ Actualizado hace $DAYS_OLD días"
fi

# 4. Archivos grandes >500KB
echo ""
echo "🔍 FICHEROS GRANDES (>500KB):"
find "$REPO_ROOT" -not -path '*/.git/*' -size +500k \
  -exec ls -lh {} \; 2>/dev/null | awk '{print "  " $5 " " $9}' || echo "  Ninguno"

# 5. Archivos sensibles rastreados
echo ""
echo "⚠️  POSIBLES ARCHIVOS SENSIBLES RASTREADOS:"
git ls-files | grep -E '\.(apk|env|pem|key|pfx|p12)$|^\.obsidian/' \
  || echo "  Ninguno detectado"

# 6. Conventional Commits últimos 10
echo ""
echo "📝 ÚLTIMOS 10 COMMITS:"
git log --oneline -10 | while read -r line; do
  if echo "$line" | grep -qE '^[a-f0-9]+ (feat|fix|docs|chore|refactor|test|infra|security|style)(\([a-z-]+\))?:'; then
    echo "  ✅ $line"
  else
    echo "  ⚠️  $line — no sigue Conventional Commits"
  fi
done

echo ""
echo "====================================="
echo " FIN AUDITORÍA"
echo "====================================="
