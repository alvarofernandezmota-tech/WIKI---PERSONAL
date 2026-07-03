---
tags: [tipo/sesion, estado/draft, #infra/docker, #osint/tools, #ia/llm]
---

# Investigación Gemini — Bots SecOps y Pentest Defensivo

> 📥 inbox — pendiente de procesar
> **Destino final:** `proyectos/bots-secops/` + `docs/herramientas/hydra.md` + `agentes/`

**Fecha:** 2026-07-01

---

## 1. Pentest Defensivo — Fuerza Bruta y Logs

### Hydra — Auditoría de credenciales

```bash
# Solo en entorno controlado propio
hydra -l usuario_prueba -P /usr/share/wordlists/fasttrack.txt ssh://192.168.72.X -t 4 -V
```

### Huella en logs — SSH (Arch Linux)

```bash
# Monitorizar intentos SSH en tiempo real:
sudo journalctl -u sshd -f
```

Patón de ataque:
```
Failed password for invalid user X from 192.168.72.Y port XXXXX ssh2
Connection closed by authenticating user X 192.168.72.Y [preauth]
```

### Huella en logs — Contenedores Docker

```bash
docker logs --tail 50 -f nombre_contenedor
```

Patón:
```
192.168.72.Y "POST /login HTTP/1.1" 401 2426
```

### Remediación — Fail2ban
Lee logs continuamente → detecta patrón (+5 fallos en 10s) → bloquea IP en iptables/nftables.

---

## 2. Arquitectura Bots SecOps — Visión Objetivo

```
[Logs Docker/Auth] ──> [Bot 1: Rastreador] ──> extrae IPs sospechosas
                              │
                              ▼
[Telegram Alert] <── [Bot 3: Alertas] <── [Bot 2: Analista IA] ──> Ollama local
```

### Bot 1 — Rastreador de Logs
- Vigila logs de Docker y auth del sistema
- Detecta patrones: fallos repetidos, IPs nuevas, puertos extraños
- Herramientas: Python + Scapy + watchdog

### Bot 2 — Analista IA
- Recibe IP/evento sospechoso del Bot 1
- Consulta Ollama local (llama3.2 / mistral)
- Consulta SpiderFoot API para reputación de IP
- Genera veredicto: amenaza real o falso positivo

### Bot 3 — Alertas
- Recibe veredicto del Bot 2
- Envía notificación Telegram con contexto
- Opcional: ejecuta bloqueo automático via UFW/fail2ban

### Principios de diseño
- **Un bot = un contenedor Docker** — aislamiento total
- **IA local únicamente** — los logs no salen de madre
- **Sin dependencias externas** para el análisis — solo Ollama + SpiderFoot interno

---

## 3. Stack disponible en madre para esto

| Herramienta | Uso en bots | Estado |
|-------------|-------------|--------|
| `ollama` | Analista IA — triaje de logs | ✅ corriendo |
| `spiderfoot` | Reputación de IPs externas | ✅ corriendo |
| `n8n` | Orquestador de flujos entre bots | ✅ corriendo |
| `prometheus` | Métricas y alertas | ✅ corriendo |
| `grafana` | Dashboard de eventos | ✅ corriendo |
| `fail2ban` | Bloqueo automático (imagen lista) | ⏳ no levantado |
| `crowdsec` | Detección colectiva de amenazas | ⏳ no levantado |
| `wazuh` | SIEM completo | ⏳ descargado, no levantado |

---

## 4. Orden de implementación recomendado

1. **Hardening primero** — mover servicios de `0.0.0.0` a `127.0.0.1`/tailscale0
2. **Levantar fail2ban + crowdsec** — protección automática inmediata
3. **Levantar Wazuh** — SIEM como base de telemetría
4. **Bot 1 esqueleto** — rastreador de logs en Python + Dockerfile
5. **Bot 2** — integrar con Ollama API
6. **Bot 3** — Telegram webhook
7. **n8n como orquestador** — conectar los 3 bots

---

*🔧 WIP — procesar al cierre de sesión*
