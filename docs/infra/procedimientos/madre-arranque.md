---
tags: [infra, procedimiento, madre, arranque, docker]
fecha-creacion: 2026-07-01
ultima-actualizacion: 2026-07-02
---

# 📋 Procedimiento — Arranque y verificación de madre

## Verificación rápida

```bash
ssh madre
docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'
docker ps | grep -c healthy
```

## Stack principal (13 contenedores)

```bash
cd ~ && docker compose up -d
docker compose ps
```

## Verificar modelos Ollama

```bash
docker exec ollama ollama list
# Esperados: qwen2.5-coder:7b, qwen2.5:3b, llama3.1:8b, bge-m3, nomic-embed-text
```

## Verificar red Tailscale

```bash
tailscale status
# Deben aparecer: madre, theodora, iphone, xiaomi
```

## Accesos web principales

| Servicio | URL |
|---|---|
| Open WebUI | `http://100.91.112.32:3001` |
| Portainer | `http://100.91.112.32:9000` |
| Grafana | `http://100.91.112.32:3000` |
| Uptime Kuma | `http://100.91.112.32:3002` |
| Code Server | `http://100.91.112.32:8443` |
| n8n | `http://100.91.112.32:5678` |
| Gitea | `http://100.91.112.32:3003` |
| SpiderFoot | `http://100.91.112.32:5001` |
| Kali Desktop | `https://100.91.112.32:6901` |

---
_Creado desde inbox 2026-07-01 — Perplexity vía MCP_
