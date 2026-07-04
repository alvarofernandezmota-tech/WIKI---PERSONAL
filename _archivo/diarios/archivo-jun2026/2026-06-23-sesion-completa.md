---
tags: [sesion, control-sesion, docker, ollama, limpieza, migracion, segundo-cerebro]
fecha: 2026-06-23
estado: procesar
ruta-obsidian: inbox/2026-06-23-sesion-completa.md
---

# Sesión completa 2026-06-23

## Resumen ejecutivo

Sesión larga y muy productiva. Dos frentes: **limpieza y migración del segundo cerebro** + **setup de Ollama/Open-WebUI en Madre**. El segundo cerebro quedó completamente limpio y sincronizado. Ollama sigue pendiente por inestabilidad del hotspot.

---

## Cronología de la sesión

### 1. Auditoría inbox
- Gemini auditó el inbox (Grok y Claude rechazaron por límites de contexto)
- Perplexity ejecutó la migración de 35 archivos del inbox a sus carpetas destino vía MCP
- Frontmatter añadido a todos los archivos migrados
- Commit masivo: `🧹 inbox limpia: 33 archivos migrados eliminados`
- **Resultado:** inbox/ completamente limpia

### 2. Descubrimiento estructura Madre
- Se auditó la estructura de carpetas de `/home/varopc/`
- Encontrados repos duplicados en `~/dev/`:
  - `dev/personal` → duplicado de `Projects/personal`
  - `dev/thdora` → duplicado de `Projects/thdora`
  - `dev/personal-v2` → versión anterior del cerebro con contenido útil
- `~/sfd_tool` identificado: fork de spreadtrum_flash para flashear dispositivos UNISOC (Redmi A5)

### 3. Migración personal-v2 → yggdrasil-dew
- Revisado contenido de `~/dev/personal-v2/`
- Migrados a yggdrasil-dew:
  - `agentes/perplexity.md` — cómo usar Perplexity como agente
  - `agentes/gemini.md` — ecosistema Google + protocolo handoff
  - `agentes/prompts.md` — plantillas (pendiente completar)
  - `formacion/python/README.md` — estructura curso Python
- `~/dev/` borrado completamente tras migración

### 4. Documentación de Madre
- Creado `setup/servidor/estructura-madre.md` — mapa completo del sistema
- Creado `setup/servidor/limpieza-repos-madre.md` — plan de limpieza ejecutado
- Creado `tools/inbox-processor/README.md` — diseño del script de automatización
- Creado `diarios/2026-06-23.md` — diario del día

### 5. Docker / Ollama
- Creado `~/docker/batcueva-nueva/docker-compose.yml` con Ollama + Open-WebUI
- Problema persistente: `failed to copy: local error: tls: bad record MAC`
- Causa: hotspot móvil inestable corta transferencias TLS de >100MB
- Intentos fallidos: `--no-parallel`, `COMPOSE_HTTP_TIMEOUT=300`, reintentos manuales
- Solución pendiente: configurar `daemon.json` con reintentos + descargar esta noche con tmux
- Capas ya descargadas: `56c5b2edf423`, `0c212ded268e` (no se re-descargan)

### 6. Git pull final
- `git pull` en `~/Projects/yggdrasil-dew` sincronizó 45 archivos
- 393 inserciones, 4658 borrados
- Repo local = repo remoto ✅

---

## Archivos creados/modificados hoy

| Archivo | Acción |
|---|---|
| `agentes/perplexity.md` | Migrado desde personal-v2 |
| `agentes/gemini.md` | Migrado desde personal-v2 |
| `agentes/prompts.md` | Migrado desde personal-v2 |
| `formacion/python/README.md` | Migrado desde personal-v2 |
| `setup/servidor/estructura-madre.md` | Creado nuevo |
| `setup/servidor/limpieza-repos-madre.md` | Creado nuevo |
| `tools/inbox-processor/README.md` | Creado nuevo |
| `diarios/2026-06-23.md` | Creado nuevo |
| `inbox/` (33 archivos) | Borrados tras migración |

---

## Decisiones tomadas

- **Ruta canónica de repos:** `~/Projects/` (no `~/dev/`)
- **`~/dev/`** → borrado definitivamente
- **Ollama:** en Docker con GPU NVIDIA, puerto 11434
- **Open-WebUI:** puerto 3001
- **sfd_tool:** herramienta para Redmi A5, mantener en `~/` o mover a `~/Projects/`
- **Descargas grandes:** siempre con tmux + `daemon.json` con reintentos

---

## Estado dockers Madre

| Contenedor | Puerto | Estado |
|---|---|---|
| uptime-kuma | :3002 | ✅ healthy |
| portainer | :9000 | ✅ healthy |
| thdora | :8000 | ✅ healthy |
| thdora-bot | — | ✅ healthy |
| grafana | :3000 | ✅ healthy |
| prometheus | :9090 | ✅ healthy |
| ollama | :11434 | ⏳ descargando |
| open-webui | :3001 | ⏳ pendiente ollama |

---

## Pendientes inmediatos

- [ ] Configurar `daemon.json` Docker con reintentos
```bash
sudo tee /etc/docker/daemon.json <<'EOF'
{"max-concurrent-downloads": 1, "max-download-attempts": 10}
EOF
sudo systemctl restart docker
```
- [ ] Completar descarga Ollama esta noche con tmux
- [ ] `docker compose up -d` cuando imágenes descargadas
- [ ] `ollama pull llama3:latest` + `nomic-embed-text`
- [ ] Mover `~/sfd_tool` → `~/Projects/sfd_tool`
- [ ] Completar `agentes/prompts.md` con prompts reales
- [ ] Diseñar `inbox_processor.py`
- [ ] Configurar Caddy como proxy inverso
- [ ] Configurar ssh-agent para no pedir passphrase en cada push

---

## Notas técnicas

### Error TLS bad record MAC
Ocurre cuando el hotspot corta una transferencia TCP a mitad. La suma de verificación del paquete TLS no cuadra. No es un problema de Docker ni de los registros — es la conexión. Solución definitiva: WiFi estable o configurar reintentos automáticos en daemon.json.

### SSH passphrase en cada push
La clave `~/.ssh/id_ed25519_github` tiene passphrase. Para no escribirla en cada push:
```bash
eval $(ssh-agent)
ssh-add ~/.ssh/id_ed25519_github
# O configurar ssh-agent en .zshrc para que arranque automáticamente
```
