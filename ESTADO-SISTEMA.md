---
tags: [estado, sistema, operativo, servicios, ahora]
fecha-actualizacion: 2026-06-25
hora: 14:33
---

# 📊 ESTADO DEL SISTEMA — 25 jun 2026

> Este archivo refleja el estado REAL operativo ahora mismo.
> Actualizar cada vez que cambie algo importante.
> Ver auditoría completa en [[diarios/2026-06-25-DIARIO-MAESTRO]]

---

## 🖥️ Máquinas

| Máquina | Estado | Observaciones |
|---|---|---|
| **Madre** | ✅ encendida y accesible | SSH funciona · alias `madre` en ~/.ssh/config ✅ |
| **varopc (Acer)** | ⚠️ lento | Usando ahora mismo — rendimiento degradado |
| **Redmi A5** | ✅ activo | Tailscale pendiente instalar desde Play Store |

---

## 🔐 SSH — Estado RESUELTO ✅

### Configuración final en Madre (`~/.ssh/config`)
```
Host madre
  HostName 100.91.112.32
  User varopc

Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_github
```

### Claves en Madre (`~/.ssh/`)
| Fichero | Uso | Estado |
|---|---|---|
| `id_ed25519_github` | GitHub (clave registrada 14 jun) | ✅ activa, **sin passphrase** |
| `id_ed25519` | uso general local | ✅ presente |
| `id_madre_github` | clave nueva generada hoy (descartada) | ⚠️ no registrada en GitHub |

### Configuración shell (`~/.zshrc`)
```bash
export GIT_SSH_COMMAND="ssh -i ~/.ssh/id_ed25519_github"
```

### Historial del problema (25 jun 2026)
- **Causa raíz**: comandos pegados con comentarios `#` en línea — el shell los concatenaba al comando anterior
- **Causa SSH**: el `.ssh/config` tenía `User git` duplicado dentro del bloque `Host madre`, corrompiendo la config
- **Clave correcta**: `id_ed25519_github` (SHA256:SCaxT9LH38VtS...) — registrada en GitHub desde jun 14
- **Solución**: reescribir `~/.ssh/config` limpio + quitar passphrase de `id_ed25519_github` + `GIT_SSH_COMMAND` en zshrc
- **Lección**: pegar bloques de comandos con comentarios en zsh/bash causa errores silenciosos — usar scripts o pegar línea a línea

---

## 🗂️ Git — Estado repos

| Repo | Último commit | Estado |
|---|---|---|
| yggdrasil-dew (madre) | 25 jun 14:33 | ✅ sincronizado — `b5dd1a6` pushed |
| yggdrasil-dew (GitHub) | 25 jun 14:33 | ✅ up to date |
| thdora | 24 jun 03:12 | 🔧 pendiente handlers /estado /inbox /diario |
| local-brain | 24 jun 03:13 | ⚠️ pendiente documentar Docker |
| osint-stack | 24 jun 03:13 | ⚠️ pendiente documentar Docker |
| personal | 24 jun 02:19 | ✅ ok |

---

## 🐳 Docker — Estado Madre

### Stack Fase 1+2 — LEVANTADO Y HEALTHY ✅

| Contenedor | Puerto | Estado |
|---|---|---|
| `ollama` | 11434 | ✅ healthy |
| `open-webui` | 3001 | ✅ healthy |
| `qdrant` | 6333 | ✅ healthy |

### Stack Fase 3 — YML LISTO, NO EJECUTADO ⏳
```
batcueva-fase3.yml → n8n (:5678) + Paperless-ngx (:8010) + Vaultwarden (:8888)
```

### Stack Fase 4 — YML LISTO, NO EJECUTADO ⏳
```
batcueva-fase4.yml → LiteLLM + Caddy + Watchtower
```

### Stack OSINT — YML LISTO, NO EJECUTADO ⏳
```
batcueva-osint.yml → SpiderFoot (:5001) + IVRE
```

---

## 🤖 Ollama — Estado modelos

| Modelo | Estado | Verificado |
|---|---|---|
| qwen2.5:3b | ✅ listo | 25 jun 12:10 |
| qwen2.5:14b | ❌ no presente | pendiente verificar |
| qwen2.5:7b | ❌ no presente | pendiente `ollama pull` |
| llama3.1:8b | ❌ no presente | pendiente `ollama pull` |
| mistral:7b | ❌ no presente | pendiente `ollama pull` |
| bge-m3 | ❌ no presente | pendiente `ollama pull` |
| nomic-embed-text | ❌ no presente | pendiente `ollama pull` |

> Pull en background sin que se corte:
> ```bash
> ssh madre "nohup bash -c 'for m in qwen2.5:7b llama3.1:8b mistral:7b bge-m3 nomic-embed-text; do docker exec ollama ollama pull $m; done' > /tmp/ollama-pulls.log 2>&1 &"
> ```

---

## 📥 Inbox

| Estado | Detalle |
|---|---|
| ~100 archivos en inbox/ | ⚠️ SIN MIGRAR — fechas 23-24 jun |
| Script migración | ❌ NO existe todavía en scripts/ |
| Regla activa | máx 10 archivos, vida 24h — VIOLADA |

**Próximo paso**: vaciar inbox — clasificar y mover a diarios/, docs/, proyectos/, etc.

---

## 🔐 Red y acceso

| Servicio | Estado |
|---|---|
| Tailscale varopc | ✅ activo |
| Tailscale Madre | ⚠️ pendiente autoarranque |
| Tailscale Redmi A5 | ⚠️ pendiente instalar — Play Store |
| SSH varopc→Madre | ✅ funciona con alias `madre` |
| SSH Madre→GitHub | ✅ sin passphrase desde 25 jun 14:30 |
| UFW Madre | ⚠️ pendiente activar reglas definitivas |
| SSH hardening | ⚠️ documentado en fase1b-seguridad.md — NO aplicado |

---

## 🪟 Windows 11 ISO (UUP)

| Estado | Detalle |
|---|---|
| Descarga | ❌ fallida — checksum error |
| Solución | Generar nuevo set en uupdump.net → W11 24H2 · amd64 · es-ES · Pro |

---

## 📋 Próximas acciones (orden de prioridad)

1. **Vaciar inbox** — ~100 ficheros del 23-24 jun sin migrar
2. **Modelos Ollama** — lanzar pulls en background
3. **Fase 3 Docker** — n8n + Paperless + Vaultwarden
4. **Tailscale Redmi A5** — instalar desde Play Store
5. **UFW + SSH hardening** en Madre
6. **Script `scripts/migrar-inbox.sh`** — crear y documentar

---
_Actualizado: 25 jun 2026 14:33 CEST — Perplexity vía MCP_
_Ver: [[MASTER-PENDIENTES]] · [[diarios/2026-06-25-DIARIO-MAESTRO]] · [[inbox/README]]_
