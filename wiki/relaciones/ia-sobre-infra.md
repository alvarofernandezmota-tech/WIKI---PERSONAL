---
tipo: relacion
author: Alvaro Fernandez Mota
creado: 2026-07-05
actualizado: 2026-07-05 21:18 CEST
ruta: wiki/relaciones/ia-sobre-infra.md
tags: [relacion, ia, infra, madre, agentes, mcp, ollama]
status: vigente
islas: [ia-local, infra]
---

# 🤖🖥️ IA sobre Infraestructura

> Cómo la capa de IA (agentes, workflows, MCP) interactúa con Madre.
> Esta relación es el corazón operativo del ecosistema.

---

## Diagrama

```
Cliente MCP (iPhone / Acer)
    ↓
Servidor MCP (objetivo: Madre :3000)
    ├──► Ollama API (:11434)    ← LLMs locales (llama3.1, mistral, codellama)
    ├──► Qdrant (:6333)        ← RAG, memoria vectorial
    ├──► Open WebUI (:3000)    ← UI de modelos
    └──► GitHub API           ← yggdrasil-dew, repos del ecosistema
```

---

## Qué partes de Madre son observables por IA

| Componente | Observable | Cómo |
|---|---|---|
| Estado Docker | ✅ Sí | `docker ps`, logs de contenedor |
| Ollama API | ✅ Sí | HTTP `:11434/api/` |
| Qdrant | ✅ Sí | HTTP `:6333` |
| Grafana metrics | ✅ Sí | HTTP Grafana + Prometheus |
| Pi-hole | ✅ Sí | API Pi-hole |
| Logs de sistema | ✅ Sí | `journalctl`, `/var/log/` |
| UFW / fail2ban | ⚠️ Parcial | Logs, no control directo |
| Disco LUKS | ❌ No | Solo estado de montaje |

---

## Qué partes son auditables

- ✅ Contenedores Docker (estado, uptime, health)
- ✅ Servicios unhealthy (log_guardian_bot, yggdrasil_watchdog)
- ✅ Puertos abiertos (nmap, ss)
- ✅ Logs de acceso SSH
- ✅ Logs de fail2ban
- ⚠️ Disco: salud SMART (28k horas — crítico)

---

## Qué partes son controlables (con MCP)

- ✅ Leer y escribir repos GitHub (ya funciona)
- ✅ Crear issues, commits, PRs (ya funciona)
- ⚠️ Ejecutar scripts en Madre (requiere SSH + MCP server propio)
- ⚠️ Reiniciar contenedores (requiere permisos Docker + MCP)
- ❌ Control de red / firewall (fuera de scope por seguridad)

---

## Qué partes son solo conceptuales (en esta wiki)

- El diseño arquitectural de cómo debería funcionar el MCP server propio
- Los modelos que se quieren probar en el futuro
- La visión de IA soberana sin APIs externas

> 📌 Procedimientos técnicos e implementación → [`ollama-stack`](https://github.com/alvarofernandezmota-tech/ollama-stack) y [`yggdrasil-dew/docs/`](https://github.com/alvarofernandezmota-tech/yggdrasil-dew)

---

## Conexiones

- → [[ia-local]] (los modelos y el stack)
- → [[infra]] (el hardware que lo ejecuta)
- → [[cerebro]] (donde se documentan las decisiones)
- → [[thdora]] (usa la IA local como backend)

---
_Actualizado: 2026-07-05 21:18 CEST · Perplexity-MCP_
