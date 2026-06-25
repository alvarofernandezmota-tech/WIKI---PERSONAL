---
tags: [diario, sesion, 2026-06-25, docker, fase3, ssh, pentest]
fecha: 2026-06-25
---

# Diario 25 jun 2026

## Resumen de la sesión

Sesión larga desde el móvil (Redmi A5). Todo por Perplexity + MCP sin terminal directo.

---

## ✅ Completado hoy

### Mañana (desde móvil)
- Stack Fase 1+2 verificado HEALTHY (ollama + open-webui + qdrant)
- SSH varopc→Madre arreglado (clave instalada, config pendiente de fix)
- .env generado en Madre con N8N_ENCRYPTION_KEY y LITELLM_MASTER_KEY
- git remote cambiado a HTTPS en Madre (fix: Permission denied publickey)
- git stash + pull → Madre al día con main
- Red Docker `batcueva` creada
- Carpeta /opt/batcueva en proceso (falta fix sudo)

### Documentación generada hoy (Perplexity vía MCP)
- ESTADO-SISTEMA.md actualizado
- MASTER-PENDIENTES.md auditado y cruzado
- setup/servidor/litellm-config.yaml creado y verificado
- setup/servidor/investigacion/2026-06-25-gemini-bloques-auditados.md
- setup/servidor/ssh-config-varopc.md
- setup/servidor/fase3-incidencias.md
- setup/servidor/env-madre.md
- diarios/2026-06-25-DIARIO-MAESTRO.md (este archivo)

---

## ⚠️ Pendiente al cerrar sesión

### Crítico — terminar hoy
- [ ] Arreglar ~/.ssh/config en varopc (está corrupto — línea `eofcat`)
- [ ] Crear headscale config.yaml en /opt/batcueva/headscale/
- [ ] Relanzar Fase 3 completa
- [ ] Levantar Fase 4
- [ ] Pulls modelos Ollama en background
- [ ] Rellenar TELEGRAM_BOT_TOKEN y TELEGRAM_USER_ID en ~/.env
- [ ] Cambiar CODE_SERVER_PASSWORD por valor real

### Esta semana
- [ ] Tailscale Redmi A5 — Play Store
- [ ] UFW activar en Madre
- [ ] Vaciar inbox (~93 archivos)
- [ ] Handlers THDORA implementar en repo thdora

---

## Incidencias del día

| Hora | Incidencia | Solución |
|---|---|---|
| ~12:10 | puerto 11434 ocupado por ollama nativo | pkill ollama |
| ~12:30 | qdrant healthcheck fallaba con curl | cambiado a wget |
| ~13:00 | git pull fallaba (unstaged changes) | git stash + pull |
| ~13:05 | git@github.com Permission denied | remote cambiado a HTTPS |
| ~13:10 | /opt/batcueva Permission denied | falta ssh -t para sudo |
| ~13:15 | headscale TLS bad record MAC | error transitorio de red, relanzar |
| ~13:19 | ~/.ssh/config corrupto (eofcat) | reescribir con cat > heredoc correcto |

---

## Investigaciones realizadas hoy

1. **Gemini Bloques A-E** — dependencias, archivos, handlers, ADB, orden ejecución
   → 10 errores detectados y corregidos (32GB→16GB RAM, host.docker.internal, etc.)

2. **ADB/Android** — BFU vs AFU, scrcpy, adb-monitor.sh, Tailscale móvil
   → documentado en setup/servidor/investigacion/

3. **Prompt pentest maestro** — nmap + SpiderFoot + n8n pipeline + Qdrant
   → preparado para enviar a Gemini

---

## Contexto THDORA

THDORA es separado del stack infra (repo propio) pero se conecta como cliente:
- Handlers diseñados: /estado /inbox /diario /pull + alerta proactiva n8n→Telegram
- Código Python documentado en investigacion/
- Imagen thdora-bot (531MB) ya en Madre
- Implementación pendiente en repo thdora

---
_Sesión: 25 jun 2026 · Perplexity vía MCP · Desde Redmi A5_
