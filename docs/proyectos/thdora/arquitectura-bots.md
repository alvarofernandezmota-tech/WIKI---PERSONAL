# Arquitectura bots Telegram — TOKI
#thdora #telegram #bots #arquitectura #fase6

**Fecha:** 2026-07-02  
**Estado:** diseño completado, implementación pendiente (Fase 6)

---

## Los dos bots

### TOKI-DEW — Asistente
- **Función:** asistente personal, consultas, gestión del repo
- **Perfil:** conversacional, acceso a docs, búsqueda en repo
- **Comandos:** `/pregunta` `/busca` `/estado` `/inbox`
- **Integración:** Perplexity API + repo yggdrasil-dew

### TOKI-GUARDIAN — Infra
- **Función:** alertas de infraestructura, monitorización, SecOps
- **Perfil:** silencioso salvo alertas, no conversacional
- **Comandos:** `/estado` `/docker` `/alertas` `/logs`
- **Integración:** Madre via SSH/API, Grafana webhooks, Wazuh

---

## Separación de responsabilidades

| Aspecto | TOKI-DEW | TOKI-GUARDIAN |
|---|---|---|
| Iniciativa | Responde a comandos | Alerta proactivamente |
| Tono | Conversacional | Técnico/conciso |
| Datos | Repo, docs, IA | Métricas, logs, alertas |
| Acceso red | No necesita | SSH a Madre |
| Hosting | Acer (dev) → Madre (prod) | Madre |

---

## Stack técnico

```
TKOI-DEW:
  - python-telegram-bot
  - Integración Perplexity API
  - Lectura repo via GitHub API

TKOI-GUARDIAN:
  - python-telegram-bot
  - paramiko (SSH a Madre)
  - docker SDK
  - webhooks Grafana/Wazuh
```

---

## Roadmap implementación

- [ ] **6a** TOKI-GUARDIAN handler `/estado` — CPU, RAM, disco
- [ ] **6b** TOKI-GUARDIAN handler `/docker` — contenedores activos
- [ ] **6c** TOKI-GUARDIAN handler `/alertas` — últimas alertas
- [ ] **6d** Webhook Grafana → Telegram
- [ ] **6e** TOKI-DEW básico — consultas repo
- [ ] **6f** TOKI-DEW — integración Perplexity/Ollama

> Ver: `ROADMAP.md` y `docs/operativa/pendientes-sesion-2026-07-03.md`
