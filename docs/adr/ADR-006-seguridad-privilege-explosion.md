---
titulo: ADR-006 — Seguridad: contención de privilege explosion en agentes
tipo: adr
author: Alvaro Fernandez Mota
creado: 2026-06-23
actualizado: 2026-07-06
status: aceptado
tags: [adr, seguridad, agentes, permisos]
---

# ADR-006 — Seguridad: contención de privilege explosion en agentes

> Renumerado desde ADR-004 para resolver colisión. Contenido original preservado íntegramente.

## Contexto

Los agentes de IA con acceso MCP pueden escalar permisos si no están correctamente delimitados. Un agente con acceso a GitHub + filesystem + red puede hacer daño no intencionado.

## Decisión

Cada agente tiene un scope explícito y mínimo. Ningún agente tiene acceso simultáneo a: escribir en repo + ejecutar comandos de sistema + acceder a datos personales.

## Consecuencias

- ✅ Blast radius controlado por agente
- ✅ Auditable: cada acción tiene agente asignado
- ⚠️ Requiere disciplina en la configuración de cada agente MCP
- Ver ADR-004 (Agentes/MCP) en yggdrasil-dew para el modelo completo

## Alternativas descartadas

- Agente único con todos los permisos: rápido pero inauditable
- Sandbox completo por contenedor: seguro pero demasiado overhead operativo
