---
tags: [arquitectura, docker, btrfs, ollama, mcp, seguridad, gemini, fase1]
estado: activo
fecha: 2026-07-03
fuente: Gemini (revisado y corregido por Perplexity MCP)
---

# 📜 Investigación Gemini — Fase 1: Infraestructura Madre

> **Nota:** Este documento proviene de un análisis generado por Gemini y ha sido
> **revisado, corregido y validado** por Perplexity MCP antes de versionarse.
> El script original tenía bugs (ver sección de correcciones al final).
> El conocimiento técnico es correcto y aplicable.

---

## 1. BTRFS SOBRE HDD — Fragmentación por Docker CoW

### El problema
Docker con `overlay2` genera miles de escrituras fragmentadas por segundo (logs
de contenedores, capas superpuestas). En HDD mecánico, la arquitectura
Copy-on-Write (CoW) nativa de Btrfs dispersa los bloques magnéticos y destruye
el rendimiento de lectura secuencial en semanas.

**Aplica a:** `varpc` (Madre) — HDD WD 1TB, 28.409h, LUKS+btrfs

### Mitigación

**A) Desactivar CoW en `/var/lib/docker` (NoCoW)**

> ⚠️ Debe hacerse ANTES de que Docker escriba datos. Si ya hay datos, hay que
> parar Docker, mover los datos, aplicar el atributo y restaurar.

```bash
# Parar Docker
sudo systemctl stop docker

# Aplicar atributo NoCoW al directorio de Docker
# (el directorio debe existir y estar vacío o con datos movidos)
sudo chattr +C /var/lib/docker

# Verificar
lsattr -d /var/lib/docker
# Debe mostrar: ----C----------- /var/lib/docker

# Reiniciar Docker
sudo systemctl start docker
```

**B) Comprensión zstd en el mount de btrfs**

En `/etc/fstab`, asegurarse de que la raíz tiene `compress=zstd:3`:

```
# Ejemplo entrada fstab con compresión
UUID=xxxx / btrfs defaults,compress=zstd:3,noatime 0 0
```

Reduce tamaño físico de payloads de texto e imágenes Docker → menos sectores
físicos leídos → mayor velocidad efectiva en HDD.

---

## 2. DOCKER + UFW BYPASS — El problema del bypass silencioso

### El problema
Docker manipula directamente las cadenas de `iptables`. Cuando un contenedor
publica un puerto con `-p 3000:8080`, Docker añade una regla que **salta
silenciosamente las reglas UFW**. En Madre, esto expondría paneles de IA
directamente al exterior a través de la IP del tethering Xiaomi 4G.

### Mitigación: forzar Docker a escuchar solo en loopback

Crear o editar `/etc/docker/daemon.json`:

```json
{
  "ip": "127.0.0.1",
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  }
}
```

```bash
# Aplicar
sudo cp /ruta/al/fichero/daemon.json /etc/docker/daemon.json
sudo systemctl restart docker

# Verificar — ningún contenedor debe escuchar en 0.0.0.0
docker ps --format '{{.Ports}}'
```

> Tras esto, los contenedores solo son accesibles desde la IP de Tailscale
> si se hace bind explícito: `"100.91.112.32:3000:8080"`

---

## 3. RED MÓVIL 4G — Descargas grandes por tethering Xiaomi

### El problema
Descargas de imágenes Docker grandes (Open WebUI, CUDA) o modelos Ollama
(7B = ~4.7GB) sufren micro-cortes en redes 4G saturadas. Las descargas
concurrentes con `pacman` o `curl` se corrompen.

### Mitigación A: aria2c para descargas grandes

```bash
# Instalar
sudo pacman -S aria2

# Descargar con múltiples segmentos paralelos
aria2c -x 16 -s 16 -k 1M "URL_DE_DESCARGA"

# Para modelos Ollama (mejor usar ollama pull directamente)
ollama pull qwen2.5-coder:7b-instruct-q4_K_M
```

### Mitigación B: transferir desde Acer (fibra) via Tailscale

```bash
# Desde Acer (red fibra) → enviar fichero a Madre
tailscale file cp ./modelo-grande.bin varopc@100.91.112.32:

# En Madre — recibir
tailscale file get
```

---

## 4. VRAM GTX 1060 6GB — Modelos Ollama compatibles

### El problema
Hyprland + GTX 1060 6GB: el compositor consume 400-800MB de VRAM.
Si un modelo supera el límite, Ollama hace offload a RAM+CPU.
Con HDD mecánico, esto baja el rendimiento a <0.5 tokens/seg (inutilizable).

### Modelos recomendados para 6GB VRAM

| Modelo | VRAM necesaria | Velocidad estimada | Uso |
|---|---|---|---|
| `qwen2.5-coder:7b-instruct-q4_K_M` | ~4.7GB | 15-25 tok/s | Código |
| `mistral:7b-q4_K_M` | ~4.7GB | 15-25 tok/s | General |
| `llama3.1:8b-q4_K_M` | ~5.0GB | 12-20 tok/s | General |
| `deepseek-coder:6.7b-q4_K_M` | ~4.5GB | 18-28 tok/s | Código |
| `codellama:7b-q4_K_M` | ~4.7GB | 15-25 tok/s | Código |

> ⚠️ NO usar modelos `q8` o sin cuantizar en esta GPU → VRAM insuficiente.

### Configuración Ollama recomendada

```bash
# En /etc/systemd/system/ollama.service.d/override.conf
[Service]
Environment="OLLAMA_KEEP_ALIVE=30m"
Environment="OLLAMA_NUM_GPU=1"
Environment="CUDA_VISIBLE_DEVICES=0"
```

```bash
# Aplicar
sudo systemctl daemon-reload
sudo systemctl restart ollama
```

`KEEP_ALIVE=30m` evita ciclos de carga/descarga desde HDD entre peticiones.

---

## 5. MCP UNIFICADO — Arquitectura supergateway

### El problema
Mantener múltiples contenedores Node.js para cada servidor MCP (GitHub,
Filesystem, etc.) consume RAM innecesaria en Madre (16GB compartidos).

### Arquitectura propuesta

```
Cursor / Perplexity / Open WebUI
         │
    supergateway (HTTP/SSE proxy, único proceso)
         │
    ├─────────── @modelcontextprotocol/server-github
    ├─────────── @modelcontextprotocol/server-filesystem
    └─────────── (futuros servidores MCP)
```

### Docker Compose correcto (sin bugs, sin secretos hardcodeados)

```yaml
# docker/docker-compose.madre.yml
version: '3.8'

services:
  open-webui:
    image: ghcr.io/open-webui/open-webui:main
    container_name: open-webui
    restart: unless-stopped
    ports:
      # Bind SOLO a Tailscale IP — nunca 0.0.0.0
      - "100.91.112.32:3000:8080"
    volumes:
      - open-webui-data:/app/backend/data
    environment:
      - OLLAMA_BASE_URL=http://host.docker.internal:11434
      - WEBUI_SECRET_KEY=${WEBUI_SECRET_KEY}     # desde .env
      - ENABLE_SIGNUP=false
    extra_hosts:
      - "host.docker.internal:host-gateway"
    networks:
      - dew-network

  # supergateway: imagen real — ghcr.io/supercorp-ai/supergateway
  # PENDIENTE: validar imagen correcta antes de desplegar
  # Ver: https://github.com/supercorp-ai/supergateway

volumes:
  open-webui-data:

networks:
  dew-network:
    driver: bridge
```

```bash
# .env (NO versionar — en .gitignore)
WEBUI_SECRET_KEY=genera_uno_con_openssl_rand_hex_32
GITHUB_PERSONAL_ACCESS_TOKEN=tu_token_aqui
```

---

## 6. HEALTH CHECK — Script corregido

Ver: `scripts/maintenance/health-check.sh`

El script original de Gemini tenía la lógica correcta.
La versión corregida y funcional está en el repo.

---

## 🔧 CORRECCIONES AL SCRIPT ORIGINAL DE GEMINI

| Línea | Bug | Corrección |
|---|---|---|
| Paso 3/7 | `echo -p` — flag inválido en bash | `echo -e` |
| Colores | `${CYAN}` no definido | Añadir `CYAN='\033[0;36m'` |
| Docker image | `supergateway/mcp-proxy:latest` no existe | `ghcr.io/supercorp-ai/supergateway` (pendiente verificar) |
| Secreto en compose | Token hardcodeado en `docker-compose.yml` | Usar `.env` + `${VAR}` |
| IP hardcodeada | `100.91.112.32` fija en compose | Mejor en `.env` como `TAILSCALE_IP` |
| `WEBUI_SECRET_KEY` | Valor fijo en compose | Mover a `.env` |

---

## 📋 ESTADO DE IMPLEMENTACIóN

| Sección | Estado | Requiere |
|---|---|---|
| Btrfs NoCoW | ⏳ Pendiente | Terminal Madre |
| Docker daemon.json | ⏳ Pendiente | Terminal Madre |
| aria2c instalado | ⏳ Pendiente | Terminal Madre |
| Ollama + modelo 7B Q4 | ⏳ Pendiente | Issue #20 |
| Open WebUI Docker | ⏳ Pendiente | Issue #9 |
| supergateway MCP | ⏳ Pendiente | Validar imagen primero |

---

*Revisado y corregido: 2026-07-03 — Perplexity MCP*
*Fuente original: Gemini (investigación técnica válida, bugs de forma corregidos)*
