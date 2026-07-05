---
title: Isla Formación
tipo: isla
nombre: Formación
descripcion: Plan de aprendizaje personal conectado a lo que se construye en el ecosistema
repo_principal: https://github.com/alvarofernandezmota-tech/yggdrasil-dew
obsidian_link: "[[formacion]]"
depende_de: [cerebro]
sirve_a: [infra, seguridad, cerebro, thdora]
estado: activo
author: Alvaro Fernandez Mota
creado: 2026-07-05
actualizado: 2026-07-05
tags: [formacion, aprendizaje, plan, estudio]
---

# 📚 Isla: Formación

No hay grado. Hay práctica real con sistemas reales.
Esta isla documenta el plan de aprendizaje — cada concepto conectado a algo que ya existe en el ecosistema.

> Lo que se aprende aquí se aplica directamente en las otras islas.

---

## Principio

**Aprender haciendo, documentar entendiendo.**
Cada vez que se construye algo → entender el concepto detrás.
Cada concepto nuevo → encontrar dónde ya está en el ecosistema.

---

## Mapa de conceptos por isla

### 🖥️ Infraestructura

| Concepto | Dónde ya lo usas | Para aprender |
|---|---|---|
| Linux / terminal | Madre, Acer — Arch Linux diario | The Linux Command Line (gratis) |
| Docker | 18 contenedores en Madre | Docker Deep Dive — Nigel Poulton |
| Redes / TCP/IP | UFW, Tailscale, puertos | NetworkChuck (YouTube) |
| Tailscale / VPN | Acceso a Madre desde iPhone | Docs oficiales Tailscale |
| btrfs / LUKS | Discos de Madre y Acer | Arch Wiki |
| SMART / discos | HAL-005 — smartctl en Madre | man smartctl |

### 🛡️ Seguridad

| Concepto | Dónde ya lo usas | Para aprender |
|---|---|---|
| UFW / firewall | Madre — deny incoming | The Linux Command Line cap. redes |
| fail2ban | Madre — activo 3 días | fail2ban docs oficiales |
| SSH hardening | PermitRootLogin no | ssh_config man page |
| Secretos / rotación | HAL-001/003 — token THDORA | OWASP Secrets Management |
| Pentesting básico | kali-pentest en Madre | TryHackMe (gratis) |
| OSINT | spiderfoot en Madre | SpiderFoot docs + DEF CON YouTube |
| Healthchecks Docker | HAL-004, watchdog | Docker docs — HEALTHCHECK |

### 🧠 Cerebro / Automatización

| Concepto | Dónde ya lo usas | Para aprender |
|---|---|---|
| Python | THDORA bot, watchdog.py, scripts | Curso Python (casi acabado) |
| Git / GitHub | Todos los repos | Pro Git (gratis online) |
| GitHub Actions / CI | validate-canon.yml en Dew | GitHub Actions docs oficiales |
| YAML | Frontmatter, docker-compose, CI | YAML en 5 minutos (yaml.org) |
| Markdown | Toda la wiki y Dew | Markdown Guide (markdownguide.org) |
| n8n / automatización | n8n en Madre | n8n docs + YouTube |
| APIs / REST | THDORA bot Telegram API | Python requests docs |

### 📊 Observabilidad

| Concepto | Dónde ya lo usas | Para aprender |
|---|---|---|
| Prometheus | Corre en Madre | Prometheus docs oficiales |
| Grafana | Dashboards en Madre | Grafana getting started |
| Logs / journalctl | Diagnóstico de servicios | man journalctl |

### 📐 Arquitectura y documentación

| Concepto | Dónde ya lo usas | Para aprender |
|---|---|---|
| ADRs | ADR-001 en yggdrasil-dew | adr.github.io |
| Service Ownership | ARBOL-SERVICIOS.md | "The Phoenix Project" (libro) |
| SRE | watchdog, healthchecks, HAL | Google SRE Book (gratis online) |
| Inner Source | Toda la estructura de repos | innersourcecommons.org |

---

## Orden de aprendizaje recomendado

Empezar por lo que ya tocas cada día:

```
1. Python          ← casi acabado — terminar el curso
2. Git / GitHub    ← ya lo usas, profundizar (Pro Git)
3. Linux terminal  ← base de todo (The Linux Command Line)
4. Docker          ← ya tienes 18 contenedores (Docker Deep Dive)
5. Redes / SSH     ← entender lo que ya configuraste
6. Seguridad       ← TryHackMe + DEF CON
7. SRE / DevOps    ← Google SRE Book
```

---

## Recursos gratuitos clave

| Recurso | Tipo | URL |
|---|---|---|
| Pro Git | Libro online | git-scm.com/book |
| The Linux Command Line | Libro online | linuxcommand.org |
| Google SRE Book | Libro online | sre.google/books |
| TryHackMe | Plataforma práctica | tryhackme.com |
| NetworkChuck | YouTube | youtube.com/@NetworkChuck |
| TechWorld with Nana | YouTube | youtube.com/@TechWorldwithNana |
| LiveOverflow | YouTube | youtube.com/@LiveOverflow |
| DEF CON | YouTube | youtube.com/@DEFCONConference |
| FOSDEM | Conferencias | fosdem.org |

---

## Cómo documentar lo aprendido

Cada concepto nuevo que entiendas → una entrada en `yggdrasil-dew/docs/diarios/`:

```markdown
## Concepto aprendido: Docker HEALTHCHECK
- **Dónde lo vi:** HAL-004, watchdog Dockerfile
- **Qué hace:** comprueba si el contenedor funciona correctamente
- **Cómo lo uso yo:** todos los contenedores de yggdrasil-secops
- **Referencia:** https://docs.docker.com/engine/reference/builder/#healthcheck
```

Así el aprendizaje queda trazado y conectado al ecosistema real.

---

_Actualizado: 2026-07-05 23:52 CEST · Perplexity-MCP_
