---
tags: [prompt, gemini, auditoria, repo, 2027, inbox, investigacion]
fecha: 2026-06-25
author: alvarofernandezmota-tech
uso: Pegar en Gemini web tras hacer Import Code del repo
---

# Prompt Gemini — Auditoría Repo 2027 + Inbox + Investigación

> **Instrucciones:** Abre [gemini.google.com](https://gemini.google.com) → "+" → "Import code" → pega la URL del repo → luego pega este prompt completo.

---

```
# CONTEXTO CARGADO — Yggdrasil-DEW Ecosistema

Tienes acceso completo al repo: 
https://github.com/alvarofernandezmota-tech/yggdrasil-dew

Perfil del owner: dev-python · pentest-linux · ia-local · llm · homelab
Stack: Arch Linux "Madre" + Docker Batcueva + Ollama + n8n + THDORA (Telegram bot)

IMPORTANTE: Ignora completamente la carpeta inbox/ — está en proceso de vaciado.
Trabaja solo con los ficheros fuera del inbox.

---

## MISIÓN 1 — AUDITORÍA REPO A NIVEL 2027

Analiza todo el repo con mentalidad de arquitecto senior 2027.
Revisa: README, ECOSISTEMA, ESTADO-SISTEMA, MASTER-PENDIENTES, 
        ROADMAP, CONTEXT, AGENT, CONVENCIONES, todas las carpetas.

Para cada área respóndeme:
- ¿Qué falta que un repo serio de 2027 debería tener?
- ¿Qué está desactualizado o mal estructurado?
- ¿Qué documentación falta para que cualquier IA entienda el sistema en frío?

Áreas a auditar:
1. Documentación raíz (README, CONTEXT, AGENT)
2. Setup e infraestructura (setup/, scripts/)
3. Automatización (n8n, THDORA, cierre-sesion.sh)
4. IA local (ollama/, agentes/)
5. Seguridad (UFW, SSH, sysctl)
6. Observabilidad (Netdata, logs, alertas)
7. Convenciones y consistencia de naming

---

## MISIÓN 2 — INVESTIGACIÓN AUTÓNOMA

Basándote en todo el repo, investiga y propón:

1. **Arquitectura 2027** — ¿Qué añadirías al stack Batcueva 
   que en 2025 no existía pero en 2027 es estándar?
   (nuevos modelos Ollama, herramientas de observabilidad, 
   agentes autónomos, MCP servers locales, etc.)

2. **Gaps de seguridad** — ¿Qué vulnerabilidades tiene el setup 
   actual basándote en los ficheros de auditoría del repo?

3. **Automatización pendiente** — ¿Qué workflows de n8n 
   deberían existir según los pendientes del MASTER-PENDIENTES?

4. **Quick wins** — Dame 5 mejoras que puedo implementar 
   en menos de 30 minutos cada una

---

## FORMATO DE RESPUESTA

- Usa headers markdown claros
- Sé directo y técnico, no necesito introducción
- Si algo no lo puedes leer del repo, dímelo explícitamente
- Al final dame un resumen de próximos pasos ordenado por impacto

Empieza por la MISIÓN 1 y luego continúa con la MISIÓN 2.
```
