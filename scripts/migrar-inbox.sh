#!/bin/bash
# migrar-inbox.sh
# Ejecutar desde la raiz del repo en Thdora
# Creado: 02-jul-2026 por Perplexity via MCP
# Uso: bash scripts/migrar-inbox.sh

set -e

echo "📦 Iniciando migracion inbox..."

# Crear estructura de destinos
mkdir -p docs/diarios docs/infra/madre docs/infra/docker docs/infra/seguridad
mkdir -p docs/seguridad/pentest docs/seguridad/hallazgos
mkdir -p docs/herramientas docs/arquitectura docs/dispositivos

echo "📁 Estructura de destinos creada"

# === RENOMBRAR FICHEROS CON NAMING INCORRECTO ===
[ -f inbox/GEMINI-AUDITORIA-ECOSISTEMA-2026-07-01.md ] && \
  git mv inbox/GEMINI-AUDITORIA-ECOSISTEMA-2026-07-01.md inbox/2026-07-01-gemini-auditoria-ecosistema.md && \
  echo "✅ Renombrado GEMINI-AUDITORIA-ECOSISTEMA"

[ -f inbox/PROCEDIMIENTO-MADRE-HOY.md ] && \
  git mv inbox/PROCEDIMIENTO-MADRE-HOY.md inbox/2026-07-01-procedimiento-madre.md && \
  echo "✅ Renombrado PROCEDIMIENTO-MADRE-HOY"

# === 25-JUN ===
[ -f inbox/2026-06-25-auditoria-infraestructura-engineering-excellence.md ] && \
  git mv inbox/2026-06-25-auditoria-infraestructura-engineering-excellence.md \
    docs/arquitectura/auditoria-engineering-excellence.md

[ -f inbox/2026-06-25-sesion-tarde-procesado.md ] && \
  git mv inbox/2026-06-25-sesion-tarde-procesado.md docs/diarios/2026-06-25.md

# === 27-JUN ===
[ -f inbox/2026-06-27-madre-ap-wifi-debug.md ] && \
  git mv inbox/2026-06-27-madre-ap-wifi-debug.md docs/infra/madre/ap-wifi.md

[ -f inbox/2026-06-27-monitoring-pentest-research.md ] && \
  git mv inbox/2026-06-27-monitoring-pentest-research.md docs/seguridad/pentest/monitoring-research.md

[ -f inbox/2026-06-27-prompt-gemini-sesion-completa.md ] && \
  git mv inbox/2026-06-27-prompt-gemini-sesion-completa.md docs/diarios/2026-06-27.md

# === 28-JUN ===
[ -f inbox/2026-06-28-auditoria-sesion-completa.md ] && \
  git mv inbox/2026-06-28-auditoria-sesion-completa.md docs/diarios/2026-06-28.md

# === 30-JUN ===
[ -f inbox/2026-06-30-cierre-sesion.md ] && \
  git mv inbox/2026-06-30-cierre-sesion.md docs/diarios/2026-06-30.md

[ -f inbox/2026-06-30-ollama-modelos-pull.md ] && \
  git mv inbox/2026-06-30-ollama-modelos-pull.md docs/herramientas/ollama-modelos.md

[ -f inbox/2026-06-30-thdora-auditoria-estado.md ] && \
  git mv inbox/2026-06-30-thdora-auditoria-estado.md docs/herramientas/thdora-estado.md

# === 01-JUL ===
[ -f inbox/2026-07-01-auditoria-compose-divergencia.md ] && \
  git mv inbox/2026-07-01-auditoria-compose-divergencia.md docs/infra/docker/compose-divergencia.md

[ -f inbox/2026-07-01-fase1-completada.md ] && \
  git mv inbox/2026-07-01-fase1-completada.md docs/diarios/2026-07-01-fase1.md

[ -f inbox/2026-07-01-gemini-auditoria-capas-pentest.md ] && \
  git mv inbox/2026-07-01-gemini-auditoria-capas-pentest.md docs/seguridad/pentest/capas-pentest.md

[ -f inbox/2026-07-01-gemini-bots-secops-arquitectura.md ] && \
  git mv inbox/2026-07-01-gemini-bots-secops-arquitectura.md docs/arquitectura/bots-secops.md

[ -f inbox/2026-07-01-hallazgo-ftp-puerto21.md ] && \
  git mv inbox/2026-07-01-hallazgo-ftp-puerto21.md docs/seguridad/hallazgos/ftp-puerto21.md

[ -f inbox/2026-07-01-modelos-ollama-completos.md ] && \
  git mv inbox/2026-07-01-modelos-ollama-completos.md docs/herramientas/ollama-modelos-completos.md

[ -f inbox/2026-07-01-redmi-adb-bloqueos.md ] && \
  git mv inbox/2026-07-01-redmi-adb-bloqueos.md docs/dispositivos/redmi-adb.md

[ -f inbox/2026-07-01-sesion-madrugada-docker-pentest.md ] && \
  git mv inbox/2026-07-01-sesion-madrugada-docker-pentest.md docs/diarios/2026-07-01-madrugada.md

[ -f inbox/2026-07-01-sesion-pentest-completa.md ] && \
  git mv inbox/2026-07-01-sesion-pentest-completa.md docs/seguridad/pentest/sesion-01-jul.md

[ -f inbox/2026-07-01-sesion-tarde-docker-stack.md ] && \
  git mv inbox/2026-07-01-sesion-tarde-docker-stack.md docs/diarios/2026-07-01-tarde.md

[ -f inbox/2026-07-01-ssh-hardening-completo.md ] && \
  git mv inbox/2026-07-01-ssh-hardening-completo.md docs/infra/seguridad/ssh-hardening.md

[ -f inbox/2026-07-01-gemini-auditoria-ecosistema.md ] && \
  git mv inbox/2026-07-01-gemini-auditoria-ecosistema.md docs/seguridad/pentest/gemini-auditoria-ecosistema.md

[ -f inbox/2026-07-01-procedimiento-madre.md ] && \
  git mv inbox/2026-07-01-procedimiento-madre.md docs/infra/madre/procedimiento.md

# === 02-JUL ===
[ -f inbox/2026-07-02-analisis-productividad-sesion.md ] && \
  git mv inbox/2026-07-02-analisis-productividad-sesion.md docs/diarios/2026-07-02-productividad.md

[ -f inbox/2026-07-02-arquitectura-bots-telegram.md ] && \
  git mv inbox/2026-07-02-arquitectura-bots-telegram.md docs/arquitectura/bots-telegram.md

[ -f inbox/2026-07-02-auditoria-herramientas-github.md ] && \
  git mv inbox/2026-07-02-auditoria-herramientas-github.md docs/herramientas/github-auditoria.md

[ -f inbox/2026-07-02-cierre-sesion.md ] && \
  git mv inbox/2026-07-02-cierre-sesion.md docs/diarios/2026-07-02-cierre-v1.md

[ -f inbox/2026-07-02-diario-sesion-noche-fase0-github.md ] && \
  git mv inbox/2026-07-02-diario-sesion-noche-fase0-github.md docs/diarios/2026-07-02-noche.md

[ -f inbox/2026-07-02-github-actions-fase5-draft.md ] && \
  git mv inbox/2026-07-02-github-actions-fase5-draft.md docs/herramientas/github-actions-draft.md

[ -f inbox/2026-07-02-pendientes-sesion-noche.md ] && \
  git mv inbox/2026-07-02-pendientes-sesion-noche.md docs/diarios/2026-07-02-pendientes.md

[ -f inbox/2026-07-02-prompt-gemini-fase0-tareas-completas.md ] && \
  git mv inbox/2026-07-02-prompt-gemini-fase0-tareas-completas.md docs/diarios/2026-07-02-gemini-fase0.md

[ -f inbox/2026-07-02-roadmap-bots-y-scripts.md ] && \
  git mv inbox/2026-07-02-roadmap-bots-y-scripts.md docs/arquitectura/roadmap-bots.md

[ -f inbox/2026-07-02-sesion-acer-bluetooth-chromium.md ] && \
  git mv inbox/2026-07-02-sesion-acer-bluetooth-chromium.md docs/diarios/2026-07-02-acer.md

[ -f inbox/2026-07-02-sesion-tarde-auditoria-ecosistema.md ] && \
  git mv inbox/2026-07-02-sesion-tarde-auditoria-ecosistema.md docs/diarios/2026-07-02-tarde.md

[ -f inbox/2026-07-02-session-cierre-tarde.md ] && \
  git mv inbox/2026-07-02-session-cierre-tarde.md docs/diarios/2026-07-02-cierre-tarde.md

[ -f inbox/2026-07-02-auditoria-inbox-migracion.md ] && \
  git mv inbox/2026-07-02-auditoria-inbox-migracion.md docs/diarios/2026-07-02-auditoria-inbox.md

[ -f inbox/2026-07-02-volcado-sesion-completa.md ] && \
  git mv inbox/2026-07-02-volcado-sesion-completa.md docs/diarios/2026-07-02-volcado.md

# Commit
git add -A
git commit -m "refactor(inbox): migracion completa inbox -> docs/ -- 02-jul-2026"

RESTANTES=$(ls inbox/ 2>/dev/null | grep -v README | grep -v .gitkeep | wc -l)
echo ""
echo "✅ Migracion completada."
echo "📥 Ficheros restantes en inbox/: $RESTANTES"
[ "$RESTANTES" -eq 0 ] && echo "🎉 Inbox limpia!" || echo "⚠️ Revisar inbox/ manualmente"
