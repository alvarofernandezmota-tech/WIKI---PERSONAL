#!/bin/bash
# procesar-inbox-masivo.sh
# Clasifica los ~120 ficheros del inbox a sus carpetas definitivas
# Usa git mv para preservar historial
# Ejecutar desde la RAÍZ del repo: bash scripts/procesar-inbox-masivo.sh

set -e
shopt -s nullglob

echo "🧹 Iniciando clasificación masiva de Inbox..."

# Crear estructura si no existe
mkdir -p diarios/ ollama/ osint/ docs/arquitectura/ docs/ias/debates/ \
         docs/ias/prompts/ setup/servidor/scripts/ proyectos/ formacion/ tools/ yo/

# --- SESIONES Y DIARIOS ---
for f in inbox/*sesion*.md inbox/*cierre*.md inbox/*vaciado*.md \
         inbox/*SESION*.md inbox/*CIERRE*.md inbox/*VACIADO*.md; do
    git mv "$f" diarios/ && echo "  diarios/ ← $(basename $f)"
done

# --- OLLAMA ---
for f in inbox/*ollama*.md inbox/*OLLAMA*.md; do
    git mv "$f" ollama/ && echo "  ollama/ ← $(basename $f)"
done

# --- OSINT ---
for f in inbox/*osint*.md inbox/*OSINT*.md; do
    git mv "$f" osint/ && echo "  osint/ ← $(basename $f)"
done

# --- ARQUITECTURA (ADRs y decisiones) ---
for f in inbox/*adr*.md inbox/*ADR*.md inbox/*decision*.md inbox/*DECISION*.md; do
    git mv "$f" docs/arquitectura/ && echo "  docs/arquitectura/ ← $(basename $f)"
done

# --- DEBATES, BITÁCORAS, TESIS ---
for f in inbox/*debate*.md inbox/*DEBATE*.md inbox/*bitacora*.md \
         inbox/*BITACORA*.md inbox/*tesis*.md inbox/*TESIS*.md; do
    git mv "$f" docs/ias/debates/ && echo "  docs/ias/debates/ ← $(basename $f)"
done

# --- PROMPTS ---
for f in inbox/*prompt*.md inbox/*PROMPT*.md; do
    git mv "$f" docs/ias/prompts/ && echo "  docs/ias/prompts/ ← $(basename $f)"
done

# --- SCRIPTS E INFRAESTRUCTURA ---
for f in inbox/*script*.md inbox/*SCRIPT*.md inbox/*macro*.md \
         inbox/*MACRO*.md inbox/*mega*.md inbox/*MEGA*.md; do
    git mv "$f" setup/servidor/scripts/ && echo "  setup/servidor/scripts/ ← $(basename $f)"
done

# --- BATCUEVA, FASES, DOCKER ---
for f in inbox/*batcueva*.md inbox/*BATCUEVA*.md inbox/*fase*.md \
         inbox/*FASE*.md inbox/*docker*.md inbox/*DOCKER*.md; do
    git mv "$f" setup/servidor/ && echo "  setup/servidor/ ← $(basename $f)"
done

# --- PROYECTOS ---
for f in inbox/*proyecto*.md inbox/*PROYECTO*.md; do
    git mv "$f" proyectos/ && echo "  proyectos/ ← $(basename $f)"
done

# --- FORMACIÓN ---
for f in inbox/*formacion*.md inbox/*FORMACION*.md; do
    git mv "$f" formacion/ && echo "  formacion/ ← $(basename $f)"
done

# --- TOOLS ---
for f in inbox/*tools*.md inbox/*TOOLS*.md; do
    git mv "$f" tools/ && echo "  tools/ ← $(basename $f)"
done

# --- YO ---
for f in inbox/*auditoria-yo*.md; do
    git mv "$f" yo/ && echo "  yo/ ← $(basename $f)"
done

shopt -u nullglob

echo ""
echo "📊 Ficheros restantes en inbox (requieren revisión manual):"
ls inbox/*.md 2>/dev/null | grep -v .gitkeep || echo "  ✅ Inbox vacío!"

echo ""
echo "✅ Listo. Revisa con: git status"
echo "   Commit con:  git commit -m '🏗️ restructura: inbox vaciado, ficheros clasificados'"
