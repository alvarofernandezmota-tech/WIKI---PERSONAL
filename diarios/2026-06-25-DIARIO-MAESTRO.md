---
tags: [diario, 2026-06-25, homelab, docker, uup, tailscale, ssh, ollama]
fecha: 2026-06-25
owner: alvarofernandezmota-tech
---

# 📓 Diario 2026-06-25 — Sesión tarde

> Ver también: [[MASTER-PENDIENTES]] · [[ESTADO-SISTEMA]] · [[setup/servidor/docker-compose.yml]]

---

## ✅ Completado hoy

### Stack Docker Madre — Fase 1+2 levantado y healthy
- Problema inicial: puerto 11434 ocupado por proceso ollama nativo → `pkill ollama` + `docker compose down` + relanzar limpio
- Problema secundario: healthcheck qdrant fallaba en `/healthz` → resuelto con `docker compose down` completo + reorden de arranque
- Solución final: `docker compose up -d ollama qdrant` → esperar healthy → `docker compose up -d open-webui`
- Estado final:
  - `ollama` → **healthy** ✅ puerto 11434
  - `open-webui` → **healthy** ✅ puerto 3001
  - `qdrant` → **healthy** ✅ puerto 6333

### SSH madre sin contraseña
- `ssh-copy-id varopc@100.91.112.32` ejecutado correctamente — 1 clave añadida
- Clave instalada: `~/.ssh/id_ed25519_github.pub`
- Pendiente: añadir entrada en `~/.ssh/config` para alias `ssh madre` sin password:
  ```
  Host madre
    HostName 100.91.112.32
    User varopc
    IdentityFile ~/.ssh/id_ed25519_github
  ```

### Ollama — modelos verificados
- `qwen2.5:3b` (1.9 GB) — único modelo presente, descargado hace 32h
- Modelos objetivo pendientes: `qwen2.5:7b`, `llama3.1:8b`, `mistral:7b`, `bge-m3`, `nomic-embed-text`

---

## ❌ Bloqueado / Pendiente resolver

### UUP — checksum loop en 4 archivos
- **Problema**: Los 4 archivos grandes fallan checksum repetidamente aunque se descargan al 100%
  - `UUPs/professional_es-es.esd`
  - `UUPs/Microsoft-Windows-Client-Desktop-Required-Package.ESD`
  - `UUPs/Windows11.0-KB5043080-x64.msu`
  - `UUPs/Windows11.0-KB5095093-x64.msu` (4.7 GB, 100%, ERR checksum)
- **Causa**: Set UUP generado en uupdump.net ha expirado — los links de Microsoft cambian
- **Solución**: Generar nuevo set en https://uupdump.net → Windows 11 24H2 → amd64 → es-ES → Professional → aria2
- **Script correcto en Linux**: `~/Downloads/uup/files/convert.sh` (UUP Converter v0.7.3)
- `convert.sh` falló con `Failed to create ISO structure` porque faltaba `professional_es-es.esd`

### Tailscale APK — split APK no instalable por ADB
- APK en `~/Downloads/uup/tailscale.apk` (3.8 MB) es un split APK incompleto
- Todos los métodos ADB probados fallan: `INSTALL_FAILED_MISSING_SPLIT`
  - `adb install` → ERR
  - `adb install --no-streaming` → ERR
  - F-Droid URL → 404
- **Solución pendiente**: Instalar Tailscale directamente desde Play Store en el móvil

---

## 🗂️ Estructura carpeta UUP

```
~/Downloads/uup/
├── files/
│   ├── convert.sh          ← script conversión ISO (UUP Converter v0.7.3)
│   ├── convert_config_linux
│   ├── convert_config_macos
│   ├── convert_ve_plugin
│   ├── converter_multi
│   └── converter_windows
├── UUPs/                   ← ~80 archivos .cab/.esd/.msu descargados
├── aria2_download.log      (25 MB)
├── ConvertConfig.ini
├── uup_download_linux.sh   ← script descarga
└── tailscale.apk           (3.8 MB — split APK, no usable por ADB)
```

---

## 📋 Próximos pasos inmediatos

1. **SSH config** — añadir entrada `Host madre` en `~/.ssh/config`
2. **Tailscale** — instalar desde Play Store directamente en el móvil
3. **UUP** — generar nuevo set en uupdump.net y relanzar descarga
4. **Ollama modelos** — `ssh madre "docker exec ollama ollama pull qwen2.5:7b"`
5. **Open WebUI** — verificar acceso en `http://madre:3001` y configurar RAG con Qdrant
6. **Fase 3 Docker** — levantar n8n + Paperless + Vaultwarden

---

_Actualizado: 2026-06-25 12:29 CEST — Perplexity vía MCP_
