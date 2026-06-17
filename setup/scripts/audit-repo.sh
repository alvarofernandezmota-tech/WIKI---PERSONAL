#!/usr/bin/env bash
# audit-repo.sh — Auditoría rápida de yggdrasil-dew
# Uso: bash setup/scripts/audit-repo.sh
# Última actualización: 17 junio 2026

set -e

echo "🧠 yggdrasil-dew — Auditoría rápida"
echo "======================================"
echo "Fecha: $(date '+%d %b %Y %H:%M')"
echo ""

# Archivos raíz
echo "📄 Archivos raíz:"
for f in AGENT.md CONTEXT.md ECOSISTEMA.md README.md CHANGELOG.md filosofia.md; do
  if [ -f "$f" ]; then
    DAYS=$(( ( $(date +%s) - $(git log -1 --format=%ct -- "$f" 2>/dev/null || echo $(date +%s)) ) / 86400 ))
    echo "  ✅ $f (hace ${DAYS}d)"
  else
    echo "  ❌ $f — NO EXISTE"
  fi
done

echo ""
echo "📁 Carpetas:"
for d in diarios setup proyectos formacion agentes yo; do
  COUNT=$(find "$d" -name "*.md" 2>/dev/null | wc -l)
  echo "  📂 $d/ — ${COUNT} archivos .md"
done

echo ""
echo "⚠️  Deprecados pendientes de limpiar:"
if [ -d "docs" ]; then
  echo "  🔴 docs/ — carpeta deprecada, migrar contenido a setup/ y diarios/"
fi

echo ""
echo "📅 Diario de hoy:"
TODAY=$(date '+%Y-%m-%d')
if [ -f "diarios/${TODAY}.md" ]; then
  echo "  ✅ diarios/${TODAY}.md existe"
else
  echo "  ⚠️  diarios/${TODAY}.md NO existe — ¿crear entrada del día?"
fi

echo ""
echo "🔗 Git status:"
git status --short

echo ""
echo "✅ Auditoría completada."
