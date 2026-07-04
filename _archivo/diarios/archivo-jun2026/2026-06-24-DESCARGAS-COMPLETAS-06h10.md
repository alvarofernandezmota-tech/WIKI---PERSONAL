---
tags: [descargas, docker, ollama, seguridad, monitor, manana]
fecha: 2026-06-24
hora: 06:10
estado: leer-al-despertar
---

# Descargas completas — 24 jun 2026 06:10

> Todo corre en madre en background. Cerrar terminales no para nada.
> Si madre pierde internet → los scripts tienen retry, continúan solos.

---

## Scripts corriendo en madre

| Script | Log | Qué hace |
|---|---|---|
| ollama-nocturno | `/tmp/ollama-nocturno.log` | 6 modelos Ollama secuencial |
| docker-extras | `/tmp/docker-extras.log` | seguridad + monitorización + agentes |

---

## Estado descargas al cerrar (06:10)

### Ollama modelos — `/tmp/ollama-nocturno.log`

| # | Modelo | Tamaño | Estado |
|---|---|---|---|
| 1 | qwen2.5:3b | 1.9GB | ✅ listo |
| 2 | qwen2.5:14b | ~9.0GB | ⏳ EN CURSO (2% a las 06:00) |
| 3 | qwen2.5:7b | ~4.7GB | ⏳ en cola |
| 4 | llama3.1:8b | ~4.7GB | ⏳ en cola |
| 5 | mistral:7b | ~4.1GB | ⏳ en cola |
| 6 | bge-m3 | ~1.2GB | ⏳ en cola |
| 7 | nomic-embed-text | ~0.3GB | ⏳ en cola |

**Total: ~24GB — estimado ~10h — listo ~16:00h**

### Docker imágenes YA descargadas ✅

```
ghcr.io/open-webui/open-webui   6.7GB
ollama/ollama                   8.29GB
n8nio/n8n                       2.39GB
ghcr.io/paperless-ngx           2.01GB
ghcr.io/berriai/litellm         1.53GB
grafana/grafana                 1.46GB
ghcr.io/ajnart/homarr           1.5GB
jc21/nginx-proxy-manager        1.77GB
lscr.io/linuxserver/code-server 1.08GB
louislam/uptime-kuma            707MB
vaultwarden/server              347MB
portainer/portainer-ce          242MB
qdrant/qdrant                   269MB
gitea/gitea                     247MB
postgres:15-alpine              417MB
redis:7-alpine                  58.9MB
containrrr/watchtower           22.2MB
thdora-bot                      531MB
```

### Docker descargando ahora — `/tmp/docker-extras.log`

```
# SEGURIDAD
crazymax/fail2ban
crowdsecurity/crowdsec
immauss/openvas
aquasec/trivy
ghcr.io/goauthentik/server
traefik
linuxserver/wireguard
hashicorp/vault

# MONITORIZACIÓN
netdata/netdata
nicolargo/glances
prom/alertmanager

# AGENTES + OSINT
searxng/searxng
itzcrazykns/perplexica

# RED
pihole/pihole
```

---

## Monitor completo — 5 bloques

```bash
watch -n 20 'ssh madre "
echo \"╔══════════════════════════════════════╗\"
echo \"║  MONITOR MADRE — \$(date +\"%H:%M:%S\")       ║\"
echo \"╚══════════════════════════════════════╝\"

echo \"\"
echo \"━━━ BLOQUE 1 — OLLAMA LISTOS (\$(ollama list | tail -n +2 | wc -l) modelos) ━━━\"
ollama list

echo \"\"
echo \"━━━ BLOQUE 2 — OLLAMA PROGRESO ━━━\"
tail -2 /tmp/ollama-nocturno.log

echo \"\"
echo \"━━━ BLOQUE 3 — DOCKER EXTRAS PROGRESO ━━━\"
tail -3 /tmp/docker-extras.log

echo \"\"
echo \"━━━ BLOQUE 4 — CONTAINERS UP (\$(docker ps -q | wc -l) corriendo) ━━━\"
docker ps --format \"table {{.Names}}\t{{.Status}}\"

echo \"\"
echo \"━━━ BLOQUE 5 — IMÁGENES TOTAL: \$(docker images | tail -n +2 | wc -l) ━━━\"
"\''
```

---

## Relanzar descargas mañana (por si se cortaron)

```bash
# Verificar qué falta
ssh madre "ollama list && docker images | wc -l"

# Relanzar Ollama si faltan modelos
ssh madre "nohup bash -c '
for model in qwen2.5:14b qwen2.5:7b llama3.1:8b bge-m3 nomic-embed-text mistral:7b; do
  echo \"=== \$(date) - \$model ==="
  until ollama pull \$model; do sleep 10; done
  echo \"✅ \$model OK\"
done
' > /tmp/ollama-nocturno.log 2>&1 &"

# Relanzar Docker extras si faltan imágenes
ssh madre "nohup bash -c '
docker pull crazymax/fail2ban:latest
docker pull crowdsecurity/crowdsec:latest
docker pull immauss/openvas:latest
docker pull aquasec/trivy:latest
docker pull ghcr.io/goauthentik/server:latest
docker pull traefik:latest
docker pull linuxserver/wireguard:latest
docker pull hashicorp/vault:latest
docker pull netdata/netdata:latest
docker pull nicolargo/glances:latest
docker pull prom/alertmanager:latest
docker pull searxng/searxng:latest
docker pull itzcrazykns/perplexica:latest
docker pull pihole/pihole:latest
' > /tmp/docker-extras.log 2>&1 &"
```

---

## Mañana — orden de trabajo

1. **Verificar descargas** — ollama list + docker images
2. **Relanzar lo que falte** — scripts de arriba
3. **Levantar fase 3+4** — docker compose up -d
4. **Config seguridad** — UFW + fail2ban + CrowdSec
5. **Crear cuentas** — n8n, Gitea, Authentik
6. **LiteLLM config** — litellm-config.yaml
7. **Auditar inbox** con Perplexity

---

_Generado: 24 jun 2026 06:10 CEST por Perplexity vía MCP_
_Ver: [ESTADO-CIERRE-NOCHE.md](2026-06-24-ESTADO-CIERRE-NOCHE.md) · [contexto-manana.md](2026-06-24-contexto-manana.md) · [MASTER-PENDIENTES.md](../MASTER-PENDIENTES.md)_
