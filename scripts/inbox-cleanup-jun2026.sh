#!/bin/bash
# =============================================================================
# inbox-cleanup-jun2026.sh
# v2 — Fix crítico Gemini 2026-06-25: shopt -s nullglob
# Auditoría: Gemini | Fix: Gemini 2026-06-25 01:50 CEST
# Propósito: Migrar inbox/ auditorías 23-24 jun al PKM Obsidian estructurado
# Estrategia: ADR-004 (rama chore/ + PR antes de mergear a main)
# EJECUTAR EN: Raíz del repositorio yggdrasil-dew, con madre operativa
#
# CAMBIOS vs v1 (inbox-cleanup-jun2024.sh):
#   - shopt -s nullglob: evita que set -e rompa el script cuando un
#     patrón glob (*.md) no encuentra ficheros (devuelve lista vacía, no error)
#   - Nombre rama corregido: chore/inbox-cleanup-jun2026 (SSOT 2026)
#   - Se eliminan los [ -f "$f" ] redundantes (nullglob los hace innecesarios)
# =============================================================================

set -e
shopt -s nullglob   # ← FIX CRÍTICO: glob sin matches = lista vacía, no error

echo ""
echo "🧹 Yggdrasil-Dew — Inbox Cleanup Jun 2026 (v2)"
echo "================================================="
echo "Fix: shopt nullglob | Rama: chore/inbox-cleanup-jun2026"
echo ""

# Verificar raíz del repo
if [ ! -d ".git" ]; then
  echo "❌ ERROR: No estás en la raíz del repo. Entra con: cd ~/repos/yggdrasil-dew"
  exit 1
fi

# Crear rama según ADR-004
git checkout main
git pull origin main
git checkout -b chore/inbox-cleanup-jun2026
echo "✅ Rama chore/inbox-cleanup-jun2026 creada"

# =============================================================================
# BLOQUE 1: Capa 24 junio — Ficheros clave (clasificación Gemini)
# Estos son explícitos (nombres exactos), no usan glob → [ -f ] sigue siendo útil
# =============================================================================
echo ""
echo "[★] BLOQUE 1: Ficheros clave del 24 de junio..."

[ -f inbox/2026-06-24-CONTEXTO-NUEVA-SESION-MIGRACION.md ] && \
  git mv inbox/2026-06-24-CONTEXTO-NUEVA-SESION-MIGRACION.md \
          diarios/2026-06-24-migracion.md

[ -f inbox/2026-06-24-SESION-INVESTIGACION-MODELOS-COMPLETA.md ] && \
  git mv inbox/2026-06-24-SESION-INVESTIGACION-MODELOS-COMPLETA.md \
          docs/ias/investigacion-modelos-2026-06-24.md

[ -f inbox/2026-06-24-DEEP-RESEARCH-ALINEACION-SSOT.md ] && \
  git mv inbox/2026-06-24-DEEP-RESEARCH-ALINEACION-SSOT.md \
          docs/2026-06-24-alineacion-ssot.md

[ -f inbox/2026-06-24-ECOSISTEMA-COMPLETO-MIGRACION.md ] && \
  git mv inbox/2026-06-24-ECOSISTEMA-COMPLETO-MIGRACION.md \
          proyectos/ecosistema-docker.md

mkdir -p docs/adr/historico
[ -f inbox/2026-06-24-BITACORA-FINAL-OLLAMA-VS-LLAMACPP.md ] && \
  git mv inbox/2026-06-24-BITACORA-FINAL-OLLAMA-VS-LLAMACPP.md \
          docs/adr/historico/2026-06-24-bitacora-ollama-vs-llamacpp.md

# =============================================================================
# BLOQUE 2: Capa 24 junio — Por etiqueta (masivo)
# nullglob activo: si no hay ficheros que coincidan, el for se salta limpiamente
# =============================================================================
echo "[★] BLOQUE 2: Clasificación masiva del 24 de junio por etiqueta..."

for f in inbox/2026-06-24-script-*.md inbox/2026-06-24-SCRIPT-*.md; do
  git mv "$f" setup/
done

for f in inbox/2026-06-24-fase*.md inbox/2026-06-24-docker-*.md; do
  git mv "$f" proyectos/
done

for f in inbox/2026-06-24-ollama-*.md inbox/2026-06-24-langchain-*.md \
         inbox/2026-06-24-arch-linux-*.md inbox/2026-06-24-kernel-*.md; do
  git mv "$f" ollama/
done

for f in inbox/2026-06-24-osint-*.md; do
  git mv "$f" osint/
done

for f in inbox/2026-06-24-formacion-*.md; do
  git mv "$f" formacion/
done

for f in inbox/2026-06-24-PROMPT-*.md inbox/2026-06-24-prompt-*.md; do
  git mv "$f" templates/
done

for f in inbox/2026-06-24-proyecto-*.md inbox/2026-06-24-batcueva-*.md; do
  git mv "$f" proyectos/
done

for f in inbox/2026-06-24-sesion-*.md  inbox/2026-06-24-cierre-*.md  \
         inbox/2026-06-24-CIERRE-*.md  inbox/2026-06-24-SESION-*.md  \
         inbox/2026-06-24-ESTADO-*.md  inbox/2026-06-24-auditoria-*.md \
         inbox/2026-06-24-AUDITORIA-*.md inbox/2026-06-24-PLAN-*.md  \
         inbox/2026-06-24-PLANIFICACION-*.md inbox/2026-06-24-flujo-*.md \
         inbox/2026-06-24-PROBLEMA-*.md inbox/2026-06-24-DEBATE-*.md  \
         inbox/2026-06-24-BITACORA-*.md inbox/2026-06-24-DESCARGAS-*.md \
         inbox/2026-06-24-REPOS-*.md   inbox/2026-06-24-TESIS-*.md   \
         inbox/2026-06-24-ADR-*.md     inbox/2026-06-24-PLANTILLA-*.md; do
  git mv "$f" diarios/
done

# Remanentes 24-jun → diarios/ (catch-all)
for f in inbox/2026-06-24-*.md; do
  git mv "$f" diarios/
done

# =============================================================================
# BLOQUE 3: Capa 23 junio — Por etiqueta
# =============================================================================
echo "[★] BLOQUE 3: Clasificación del 23 de junio..."

for f in inbox/2026-06-23-adr-*.md; do
  git mv "$f" docs/adr/
done

for f in inbox/2026-06-23-ollama-*.md inbox/2026-06-23-local-brain-*.md; do
  git mv "$f" ollama/
done

for f in inbox/2026-06-23-osint-*.md; do
  git mv "$f" osint/
done

for f in inbox/2026-06-23-proyecto-*.md inbox/2026-06-23-decision-*.md; do
  git mv "$f" proyectos/
done

for f in inbox/2026-06-23-prompt-*.md; do
  git mv "$f" templates/
done

# Remanentes 23-jun → diarios/ (catch-all, incluye sesion-, auditoria-, etc.)
for f in inbox/2026-06-23-sesion-*.md  inbox/2026-06-23-auditoria-*.md \
         inbox/2026-06-23-*.md; do
  git mv "$f" diarios/
done

# Restaurar comportamiento estándar de Bash
shopt -u nullglob

# =============================================================================
# BLOQUE 4: Commit semántico y push
# =============================================================================
echo ""
echo "[★] BLOQUE 4: Commit semántico (ADR-004)..."
git add -A
git commit -m "chore(inbox): migración PKM auditorías 23-24 jun — inbox zero

- Fix: shopt nullglob (Gemini 2026-06-25) — script seguro ante globs vacíos
- 5 ficheros clave 24-jun → diarios/, docs/ias/, proyectos/, docs/adr/historico/
- ~50 ficheros 24-jun clasificados por etiqueta
- ~35 ficheros 23-jun clasificados por etiqueta
- Destinos: diarios/, ollama/, osint/, proyectos/, templates/, docs/, setup/
- Basado en auditoría Gemini + ADR-003 + ADR-004"

git push origin chore/inbox-cleanup-jun2026

echo ""
echo "✅ Inbox Zero completado."
echo "🔗 Abre PR: https://github.com/alvarofernandezmota-tech/yggdrasil-dew/compare/chore/inbox-cleanup-jun2026"
echo "📝 Revisa ficheros movidos, verifica links Obsidian y mergea a main."
