---
tags: [diario, sesion, 2026-06-25, docker, fase3, ssh, pentest, gemini]
fecha: 2026-06-25
---

# Diario 25 jun 2026

Sesión completa desde Redmi A5 vía Perplexity + MCP. Sin acceso directo a terminal varopc.

---

## ✅ Completado hoy

| Hora | Tarea |
|---|---|
| ~12:10 | Stack Fase 1+2 HEALTHY — ollama + open-webui + qdrant |
| ~12:10 | Fix: pkill ollama nativo que ocupaba :11434 |
| ~12:30 | Fix: healthcheck qdrant cambiado a wget |
| ~12:33 | ESTADO-SISTEMA.md actualizado |
| ~12:34 | MASTER-PENDIENTES.md auditado y cruzado |
| ~12:43 | litellm-config.yaml creado (dos instancias Ollama) |
| ~12:43 | Auditoría Gemini: 10 errores detectados y corregidos |
| ~12:46 | litellm-config.yaml corregido (16GB RAM, ollama-embeddings:11435) |
| ~13:00 | git stash + pull — Madre al día |
| ~13:05 | git remote → HTTPS (fix Permission denied publickey) |
| ~13:08 | Red batcueva creada en Madre |
| ~13:08 | .env generado con N8N_ENCRYPTION_KEY + LITELLM_MASTER_KEY |
| ~13:21 | batcueva-fase3.yml corregido (code-server ruta absoluta) |
| ~13:21 | Documentación completa: ssh-config, fase3-incidencias, env-madre, diario |

## ❌ Pendiente al cerrar sesión

### Crítico — hacer ahora
- [ ] Arreglar ~/.ssh/config en varopc (corrupto — ver ssh-config-varopc.md)
- [ ] Relanzar Fase 3: `ssh madre "cd ~/yggdrasil-dew && docker compose -f setup/servidor/batcueva-fase3.yml up -d"`
- [ ] Levantar Fase 4
- [ ] Pulls modelos Ollama en background
- [ ] Rellenar TELEGRAM_BOT_TOKEN + TELEGRAM_USER_ID en ~/.env de Madre

### Esta semana
- [ ] Tailscale Redmi A5 — Play Store
- [ ] UFW activar Madre
- [ ] Inbox vaciar (~93 archivos)
- [ ] Handlers THDORA en repo thdora

---

## Investigaciones realizadas (con Gemini)

### Bloques A-E — dependencias, archivos, handlers, ADB, orden ejecución
- **10 errores corregidos** en respuesta Gemini
- Errores clave: 32GB→16GB RAM · host.docker.internal→ollama · Arch→Ubuntu · batcueva_net→batcueva
- Documentado en: `setup/servidor/investigacion/2026-06-25-gemini-bloques-auditados.md`

### ADB / Android — BFU vs AFU
- adb-monitor.sh diseñado para varopc (cron cada 5min)
- scrcpy con --turn-screen-on y -S documentado
- Limitación BFU: tras reinicio, ADB TCP bloqueado hasta PIN físico
- Documentado en: `setup/servidor/investigacion/2026-06-25-gemini-bloques-auditados.md`

### Pentest / OSINT — script maestro diseñado
- Fases 0-3: reconocimiento pasivo → activo → WiFi → integración Qdrant
- Prompt preparado para Gemini (pendiente enviar)
- Infraestructura: SpiderFoot en batcueva-osint.yml (pendiente levantar)

### THDORA — handlers diseñados
- /estado: docker ps + free -h → respuesta Telegram
- /inbox: append inbox/ + git commit + push
- /diario: append diario del día + commit
- /pull: docker exec ollama ollama pull
- Alerta proactiva: n8n → THDORA → Telegram
- Código Python documentado, pendiente implementar en repo thdora

---

## Arquitectura verificada desde el repo

```
Fase 1+2 (HEALTHY):
  ollama:11434        ← qwen2.5:3b activo
  ollama-embeddings:11435
  open-webui:3001
  qdrant:6333

Fase 3 (YML corregido, pendiente ejecutar):
  n8n:5678
  gitea:3003
  code-server:8443
  headscale:8085

Fase 4 (YML + litellm-config.yaml listos, pendiente ejecutar):
  nginx-proxy-manager:80/443/81
  watchtower
  litellm:4000

Fase OSINT (pendiente):
  spiderfoot:5001
  ivre

THDORA (pendiente handlers):
  imagen descargada en Madre (531MB)
  repo: github.com/alvarofernandezmota-tech/thdora
```

---
_Sesión: 25 jun 2026 · Perplexity vía MCP · Desde Redmi A5_
_Ver: [[ESTADO-SISTEMA]] · [[MASTER-PENDIENTES]] · [[setup/servidor/fase3-incidencias]]_
