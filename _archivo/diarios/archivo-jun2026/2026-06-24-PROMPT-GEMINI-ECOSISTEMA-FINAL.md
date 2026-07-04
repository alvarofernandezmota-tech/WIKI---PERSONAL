---
tags: [gemini, prompt, ecosistema, investigacion, docker, seguridad, agentes]
fecha: 2026-06-24
hora: 06:12
---

# Prompt Gemini — Investigación ecosistema completo

---

## Contexto para dar a Gemini

```
Soy un dev/pentest junior con un homelab propio llamado "Madre" (Arch Linux, i5-8400, 16GB RAM, sin GPU).
Tengo un sistema de conocimiento personal llamado Yggdrasil-Dew en GitHub.

ESTADO ACTUAL DEL SERVIDOR:

Docker imágenes YA descargadas (stack completo):
- IA: ollama, open-webui, qdrant, litellm
- Automatización: n8n, flowise
- Infra: gitea, code-server, nginx-proxy-manager, vaultwarden
- Monitor: portainer, uptime-kuma, grafana, prometheus, heimdall, homarr
- Seguridad: fail2ban, crowdsec, openvas, trivy, authentik, traefik, wireguard, vault
- Agentes web: searxng, perplexica
- Red: pihole

Ollama modelos descargando (secuencial, toda la noche):
- qwen2.5:3b ✅ listo
- qwen2.5:14b ⏳ en curso (~9GB)
- qwen2.5:7b, llama3.1:8b, mistral:7b, bge-m3, nomic-embed-text ⏳ en cola

Contenedores ya corriendo:
- ollama, open-webui, qdrant (stack IA)
- portainer, uptime-kuma, grafana, prometheus
- thdora-bot (mi bot Telegram personal)

Red: Tailscale activo, IP fija 100.91.112.32
```

---

## PROMPT COMPLETO PARA GEMINI

```
Tengo el contexto de arriba. Quiero que me ayudes a investigar y planificar:

1. ARQUITECTURA DEL ECOSISTEMA
   - ¿Cuál es el orden óptimo para configurar todos estos servicios?
   - ¿Cómo conectar: Traefik → Authentik → todos los servicios (SSO)?
   - ¿Vault para gestionar secretos en docker-compose.yml?

2. STACK IA LOCAL
   - ¿Arquitectura óptima: LiteLLM + Ollama + Open WebUI + Qdrant?
   - ¿Cómo crear Modelfiles para personalidades: asistente personal + agente OSINT?
   - ¿Flowise o n8n para orquestar agentes locales con búsqueda web (SearXNG)?
   - ¿Cómo montar Perplexica con SearXNG + qwen2.5:14b?

3. SEGURIDAD DEL SERVIDOR
   - ¿Orden de configuración: UFW → fail2ban → CrowdSec → Traefik → Authentik?
   - ¿Cómo usar Trivy para escanear todas mis imágenes Docker automáticamente?
   - ¿Wireguard o Tailscale/Headscale para acceso remoto seguro?

4. MONITORIZACIÓN
   - ¿Cómo conectar Prometheus + Grafana + Alertmanager para alertas por Telegram?
   - ¿Netdata o Glances para monitor de sistema en tiempo real?
   - ¿Cómo usar Uptime Kuma para vigilar todos los servicios con notificaciones?

5. WORKFLOWS N8N
   - ¿Workflows más valiosos para PKM: Telegram → inbox → Obsidian → Git?
   - ¿Cómo conectar n8n con Ollama para procesamiento IA de notas?

Para cada punto: dame arquitectura concreta + ejemplos de config/código + orden de implementación.
No teoría, quiero poder ejecutarlo mañana.
```

---

_Generado: 24 jun 2026 06:12 CEST por Perplexity vía MCP_
_Ver: [DESCARGAS-COMPLETAS-06h10.md](2026-06-24-DESCARGAS-COMPLETAS-06h10.md) · [contexto-manana.md](2026-06-24-contexto-manana.md)_
