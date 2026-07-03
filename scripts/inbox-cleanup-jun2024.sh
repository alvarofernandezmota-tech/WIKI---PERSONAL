#!/bin/bash
# =============================================================================
# inbox-cleanup-jun2024.sh
# Auditoría: Gemini 2026-06-25 | Ejecutor: Perplexity 2026-06-25 01:49 CEST
# Propósito: Migrar inbox/ de auditorías 23-24 jun al PKM Obsidian estructurado
# Estrategia: ADR-004 (rama chore/ + PR antes de mergear a main)
# EJECUTAR EN: Raíz del repositorio yggdrasil-dew, con madre operativa
# =============================================================================

set -e

echo ""
echo "🧹 Yggdrasil-Dew — Inbox Cleanup Jun 2024"
echo "================================================="
echo "Basado en auditoría Gemini + estructura real del repo"
echo ""

# Verificar que estamos en la raíz del repo
if [ ! -d ".git" ]; then
  echo "❌ ERROR: No estás en la raíz del repositorio. Sal y entra con: cd ~/repos/yggdrasil-dew"
  exit 1
fi

# Crear rama según ADR-004
git checkout main
git pull origin main
git checkout -b chore/inbox-cleanup-jun2024
echo "✅ Rama chore/inbox-cleanup-jun2024 creada"

# =============================================================================
# BLOQUE 1: Capa 24 junio — Ficheros clave (clasificación Gemini)
# =============================================================================
echo ""
echo "[★] BLOQUE 1: Ficheros clave del 24 de junio..."

# Contexto de sesión → diarios/
[ -f inbox/2026-06-24-CONTEXTO-NUEVA-SESION-MIGRACION.md ] && \
  git mv inbox/2026-06-24-CONTEXTO-NUEVA-SESION-MIGRACION.md diarios/2026-06-24-migracion.md

# Investigación modelos → docs/ias/ (documentación viva)
[ -f inbox/2026-06-24-SESION-INVESTIGACION-MODELOS-COMPLETA.md ] && \
  git mv inbox/2026-06-24-SESION-INVESTIGACION-MODELOS-COMPLETA.md docs/ias/investigacion-modelos-2026-06-24.md

# Alineación SSOT → docs/
[ -f inbox/2026-06-24-DEEP-RESEARCH-ALINEACION-SSOT.md ] && \
  git mv inbox/2026-06-24-DEEP-RESEARCH-ALINEACION-SSOT.md docs/2026-06-24-alineacion-ssot.md

# Ecosistema Docker → proyectos/
[ -f inbox/2026-06-24-ECOSISTEMA-COMPLETO-MIGRACION.md ] && \
  git mv inbox/2026-06-24-ECOSISTEMA-COMPLETO-MIGRACION.md proyectos/ecosistema-docker.md

# Bitácora Ollama vs llama.cpp → docs/adr/historico/ (ya formalizado en ADR-003)
mkdir -p docs/adr/historico
[ -f inbox/2026-06-24-BITACORA-FINAL-OLLAMA-VS-LLAMACPP.md ] && \
  git mv inbox/2026-06-24-BITACORA-FINAL-OLLAMA-VS-LLAMACPP.md docs/adr/historico/2026-06-24-bitacora-ollama-vs-llamacpp.md

# =============================================================================
# BLOQUE 2: Capa 24 junio — Por etiqueta (masivo)
# =============================================================================
echo "[★] BLOQUE 2: Clasificación masiva del 24 de junio por etiqueta..."

# Scripts bash → setup/
for f in inbox/2026-06-24-script-*.md inbox/2026-06-24-SCRIPT-*.md; do
  [ -f "$f" ] && git mv "$f" setup/
done

# Fases Docker → proyectos/
for f in inbox/2026-06-24-fase*.md inbox/2026-06-24-docker-*.md; do
  [ -f "$f" ] && git mv "$f" proyectos/
done

# Ollama / modelos → ollama/
for f in inbox/2026-06-24-ollama-*.md inbox/2026-06-24-langchain-*.md \
         inbox/2026-06-24-arch-linux-*.md inbox/2026-06-24-kernel-*.md; do
  [ -f "$f" ] && git mv "$f" ollama/
done

# OSINT → osint/
for f in inbox/2026-06-24-osint-*.md; do
  [ -f "$f" ] && git mv "$f" osint/
done

# Formación → formacion/
for f in inbox/2026-06-24-formacion-*.md; do
  [ -f "$f" ] && git mv "$f" formacion/
done

# Prompts / templates → templates/
for f in inbox/2026-06-24-PROMPT-*.md inbox/2026-06-24-prompt-*.md; do
  [ -f "$f" ] && git mv "$f" templates/
done

# Proyectos (fichas) → proyectos/
for f in inbox/2026-06-24-proyectos-*.md inbox/2026-06-24-batcueva-*.md; do
  [ -f "$f" ] && git mv "$f" proyectos/
done

# Sesiones, cierres y estado → diarios/
for f in inbox/2026-06-24-sesion-*.md inbox/2026-06-24-cierre-*.md \
         inbox/2026-06-24-CIERRE-*.md inbox/2026-06-24-SESION-*.md \
         inbox/2026-06-24-ESTADO-*.md inbox/2026-06-24-auditoria-*.md \
         inbox/2026-06-24-AUDITORIA-*.md inbox/2026-06-24-PLAN-*.md \
         inbox/2026-06-24-PLANIFICACION-*.md inbox/2026-06-24-flujo-*.md \
         inbox/2026-06-24-PROBLEMA-*.md inbox/2026-06-24-DEBATE-*.md \
         inbox/2026-06-24-BITACORA-*.md inbox/2026-06-24-DESCARGAS-*.md \
         inbox/2026-06-24-REPOS-*.md inbox/2026-06-24-TESIS-*.md \
         inbox/2026-06-24-ADR-*.md inbox/2026-06-24-PLANTILLA-*.md; do
  [ -f "$f" ] && git mv "$f" diarios/
done

# Remanentes del 24 que no cayeron en ninguna categoría → diarios/
for f in inbox/2026-06-24-*.md; do
  [ -f "$f" ] && git mv "$f" diarios/
done

# =============================================================================
# BLOQUE 3: Capa 23 junio — Por etiqueta (misma lógica)
# =============================================================================
echo "[★] BLOQUE 3: Clasificación del 23 de junio..."

# ADRs → docs/adr/
for f in inbox/2026-06-23-adr-*.md; do
  [ -f "$f" ] && git mv "$f" docs/adr/
done

# Ollama → ollama/
for f in inbox/2026-06-23-ollama-*.md inbox/2026-06-23-local-brain-*.md; do
  [ -f "$f" ] && git mv "$f" ollama/
done

# OSINT → osint/
for f in inbox/2026-06-23-osint-*.md; do
  [ -f "$f" ] && git mv "$f" osint/
done

# Proyectos → proyectos/
for f in inbox/2026-06-23-proyecto-*.md inbox/2026-06-23-decision-*.md; do
  [ -f "$f" ] && git mv "$f" proyectos/
done

# Prompts → templates/
for f in inbox/2026-06-23-prompt-*.md; do
  [ -f "$f" ] && git mv "$f" templates/
done

# Sesiones, auditorías y remanentes → diarios/
for f in inbox/2026-06-23-sesion-*.md inbox/2026-06-23-auditoria-*.md \
         inbox/2026-06-23-*.md; do
  [ -f "$f" ] && git mv "$f" diarios/
done

# =============================================================================
# BLOQUE 4: Commit semántico y push
# =============================================================================
echo ""
echo "[★] BLOQUE 4: Commit semántico (ADR-004)..."
git add -A
git commit -m "chore(inbox): migración PKM auditorías 23-24 jun — inbox zero

- 5 ficheros clave 24-jun: diarios/, docs/ias/, proyectos/, docs/adr/historico/
- ~50 ficheros 24-jun clasificados por etiqueta
- ~35 ficheros 23-jun clasificados por etiqueta
- Destinos: diarios/, ollama/, osint/, proyectos/, templates/, docs/, setup/
- Basado en auditoría Gemini 2026-06-25 + ADR-003 + ADR-004"

git push origin chore/inbox-cleanup-jun2024

echo ""
echo "✅ Inbox Zero completado."
echo "🔗 Abre PR en GitHub: https://github.com/alvarofernandezmota-tech/yggdrasil-dew/compare/chore/inbox-cleanup-jun2024"
echo "📝 Revisa los ficheros movidos, verifica links Obsidian y mergea a main."
