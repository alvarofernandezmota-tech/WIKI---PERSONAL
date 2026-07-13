---
tipo: isla
repo: osint-stack
creado: 2026-07-13
actualizado: 2026-07-13
tags: [osint, seguridad, spiderfoot, investigacion]
status: auditado-parcial
---

# Isla: OSINT Stack

> Herramientas de inteligencia de fuentes abiertas del ecosistema. Rama ofensiva-investigativa de yggdrasil-secops.

---

## Qué es

Repo [`osint-stack`](https://github.com/alvarofernandezmota-tech/osint-stack) — stack Docker para OSINT:
- **Spiderfoot** — framework de reconocimiento automatizado
- Pipelines de investigación (self-OSINT, targets externos)
- Herramientas CLI de análisis

---

## Estado actual

| Componente | Estado |
|-----------|--------|
| Spiderfoot | 🟡 Sin verificar |
| Pipelines | 🟡 Sin documentar |
| Integración secops | 🟡 Sin verificar |

> ⚠️ Pendiente: auditoría completa. El repo existe desde 2026-06-24 pero no tiene issues ni documentación interna.

---

## Conexiones en el ecosistema

- **yggdrasil-secops** → integración directa con blue team
- **Madre** → corre los contenedores
- **investigacion-ia** → puede cruzar datos OSINT con análisis IA

---

## Seguridad

- [ ] Verificar que Spiderfoot NO está expuesto a internet sin auth
- [ ] Verificar que los resultados de OSINT no están en el repo (datos sensibles)
- [ ] Revisar `.gitignore` — excluir resultados de escaneos

---

## Pendientes

- Crear issue de auditoría en DEW
- Documentar qué pipelines existen
- Conectar con isla `seguridad.md`

---

_Creado: 2026-07-13 · Perplexity-MCP · Pendiente auditoría terminal_
