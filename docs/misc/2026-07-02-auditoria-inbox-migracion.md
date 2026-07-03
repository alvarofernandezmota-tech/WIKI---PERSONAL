---
titulo: Auditoría inbox y plan migración — 02-jul-2026
fecha: 2026-07-02T21:01
estado: pendiente-migracion
destino: docs/diarios/2026-07-02.md
tags: [audit, inbox, migracion, sesion]
---

# Auditoría inbox — 02-jul-2026 21:01

> Ejecutar en Thdora desde terminal. Este fichero es el plan de acción.

---

## Ficheros con naming incorrecto — Renombrar primero

```bash
git mv inbox/GEMINI-AUDITORIA-ECOSISTEMA-2026-07-01.md inbox/2026-07-01-gemini-auditoria-ecosistema.md
git mv inbox/PROCEDIMIENTO-MADRE-HOY.md inbox/2026-07-01-procedimiento-madre.md
```

---

## Script de migración completa

```bash
#!/bin/bash
# migrar-inbox.sh — ejecutar desde raíz del repo
# Crear destinos si no existen
mkdir -p docs/diarios docs/infra/madre docs/infra/docker docs/infra/seguridad
mkdir -p docs/seguridad/pentest docs/seguridad/hallazgos
mkdir -p docs/herramientas docs/arquitectura docs/dispositivos

# --- 25-jun ---
git mv inbox/2026-06-25-auditoria-infraestructura-engineering-excellence.md docs/arquitectura/auditoria-engineering-excellence.md
git mv inbox/2026-06-25-sesion-tarde-procesado.md docs/diarios/2026-06-25.md

# --- 27-jun ---
git mv inbox/2026-06-27-madre-ap-wifi-debug.md docs/infra/madre/ap-wifi.md
git mv inbox/2026-06-27-monitoring-pentest-research.md docs/seguridad/pentest/monitoring-research.md
git mv inbox/2026-06-27-prompt-gemini-sesion-completa.md docs/diarios/2026-06-27.md

# --- 28-jun ---
git mv inbox/2026-06-28-auditoria-sesion-completa.md docs/diarios/2026-06-28.md

# --- 30-jun ---
git mv inbox/2026-06-30-cierre-sesion.md docs/diarios/2026-06-30.md
git mv inbox/2026-06-30-ollama-modelos-pull.md docs/herramientas/ollama-modelos.md
git mv inbox/2026-06-30-thdora-auditoria-estado.md docs/herramientas/thdora-estado.md

# --- 01-jul ---
git mv inbox/2026-07-01-auditoria-compose-divergencia.md docs/infra/docker/compose-divergencia.md
git mv inbox/2026-07-01-fase1-completada.md docs/diarios/2026-07-01-fase1.md
git mv inbox/2026-07-01-gemini-auditoria-capas-pentest.md docs/seguridad/pentest/capas-pentest.md
git mv inbox/2026-07-01-gemini-bots-secops-arquitectura.md docs/arquitectura/bots-secops.md
git mv inbox/2026-07-01-hallazgo-ftp-puerto21.md docs/seguridad/hallazgos/ftp-puerto21.md
git mv inbox/2026-07-01-modelos-ollama-completos.md docs/herramientas/ollama-modelos-completos.md
git mv inbox/2026-07-01-redmi-adb-bloqueos.md docs/dispositivos/redmi-adb.md
git mv inbox/2026-07-01-sesion-madrugada-docker-pentest.md docs/diarios/2026-07-01-madrugada.md
git mv inbox/2026-07-01-sesion-pentest-completa.md docs/seguridad/pentest/sesion-01-jul.md
git mv inbox/2026-07-01-sesion-tarde-docker-stack.md docs/diarios/2026-07-01-tarde.md
git mv inbox/2026-07-01-ssh-hardening-completo.md docs/infra/seguridad/ssh-hardening.md
git mv inbox/2026-07-01-gemini-auditoria-ecosistema.md docs/seguridad/pentest/gemini-auditoria-ecosistema.md
git mv inbox/2026-07-01-procedimiento-madre.md docs/infra/madre/procedimiento.md

# --- 02-jul ---
git mv inbox/2026-07-02-analisis-productividad-sesion.md docs/diarios/2026-07-02-productividad.md
git mv inbox/2026-07-02-arquitectura-bots-telegram.md docs/arquitectura/bots-telegram.md
git mv inbox/2026-07-02-auditoria-herramientas-github.md docs/herramientas/github-auditoria.md
git mv inbox/2026-07-02-cierre-sesion.md docs/diarios/2026-07-02-cierre-v1.md
git mv inbox/2026-07-02-diario-sesion-noche-fase0-github.md docs/diarios/2026-07-02-noche.md
git mv inbox/2026-07-02-github-actions-fase5-draft.md docs/herramientas/github-actions-draft.md
git mv inbox/2026-07-02-pendientes-sesion-noche.md docs/diarios/2026-07-02-pendientes.md
git mv inbox/2026-07-02-prompt-gemini-fase0-tareas-completas.md docs/diarios/2026-07-02-gemini-fase0.md
git mv inbox/2026-07-02-roadmap-bots-y-scripts.md docs/arquitectura/roadmap-bots.md
git mv inbox/2026-07-02-sesion-acer-bluetooth-chromium.md docs/diarios/2026-07-02-acer.md
git mv inbox/2026-07-02-sesion-tarde-auditoria-ecosistema.md docs/diarios/2026-07-02-tarde.md
git mv inbox/2026-07-02-session-cierre-tarde.md docs/diarios/2026-07-02-cierre-tarde.md
git mv inbox/2026-07-02-auditoria-inbox-migracion.md docs/diarios/2026-07-02-auditoria-inbox.md

# Commit final
git add -A
git commit -m "refactor(inbox): migración completa inbox → docs/ — 02-jul-2026"
echo "✅ Inbox migrada. $(ls inbox/ | grep -v README | grep -v .gitkeep | wc -l) ficheros restantes."
```

---

## Verificación post-migración

```bash
# La inbox debe quedar solo con README.md y .gitkeep
ls inbox/
# Esperado: README.md  .gitkeep

# Verificar destinos
ls docs/diarios/
ls docs/seguridad/
ls docs/infra/
ls docs/herramientas/
ls docs/arquitectura/
```

---

_Creado: 02-jul-2026 21:01 CEST — Perplexity vía MCP_
