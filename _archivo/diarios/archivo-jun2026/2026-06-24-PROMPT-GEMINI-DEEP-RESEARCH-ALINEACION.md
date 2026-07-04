---
fecha: 2026-06-24
hora: 22:28
diario: "[[diarios/2026-06-24]]"
destino: agentes/prompts/
tags: [inbox, prompt, gemini, deep-research, obsidian, alineacion, workflow]
---

# PROMPT — Gemini Deep Research: alineación inbox-repo-Obsidian

> Pegar esto en Gemini Advanced con Deep Research activado.
> Objetivo: encontrar las mejores prácticas reales de sistemas similares al nuestro.

---

## PROMPT PARA GEMINI

```
Haz una investigación profunda (Deep Research) sobre las mejores prácticas para mantener 
alineados automáticamente un sistema de notas tipo Zettelkasten/Second Brain en Obsidian 
con un repositorio GitHub que actúa como fuente de verdad del sistema.

Contexto de mi sistema:
- Repo GitHub principal: yggdrasil-dew (second brain + diarios + documentación técnica)
- Carpeta inbox/ en el repo = zona de paso (máx 10 archivos, se vacía cada sesión)
- Archivos maestros que deben estar siempre sincronizados: CONTEXT.md, ECOSISTEMA.md, 
  ESTADO-SISTEMA.md, HOME.md, inbox/MASTER-PENDIENTES.md
- Herramientas disponibles: Obsidian (con plugins), GitHub MCP, n8n (pendiente levantar), 
  thdora (bot Telegram propio en Python), Ollama local
- El problema: los archivos maestros se dessincronizan porque se actualizan a mano

Investiga y responde:

1. ¿Qué workflows reales usan desarrolladores/PKM experts para mantener inbox y repo alineados?
   - Plugins Obsidian que automatizan esto (Dataview, Templater, Git, MetaEdit)
   - Patrones Git para repos tipo second brain (conventional commits, hooks pre-commit)
   - Cómo usan frontmatter YAML como fuente de verdad para generar vistas automáticas

2. ¿Cómo simplificar archivos maestros sin perder información?
   - Sistemas que usan UN solo archivo de estado vs mútiples
   - Cómo Dataview puede reemplazar archivos estáticos con vistas dinámicas
   - Ejemplos de repos públicos bien organizados (Obsidian vaults en GitHub)

3. ¿Qué automatizaciones con n8n o bots Telegram hacen otros para sync?
   - Workflows n8n para sync Obsidian ↔ GitHub
   - Bots Telegram que hacen git push / actualizan notas
   - Integraciones con Ollama local para procesar inbox automáticamente

4. Mejor práctica para conectar repos entre sí en Obsidian:
   - Cómo referenciar repos externos (thdora, local-brain, osint-stack) desde yggdrasil-dew
   - Etiquetas y wikilinks entre repos
   - Estructura de carpetas que escale bien

Dame recomendaciones concretas y accionables, con ejemplos de configuración real 
(frontmatter, queries Dataview, scripts, hooks). Prioriza soluciones que funcionen 
con Obsidian + GitHub sin depender de servicios cloud de pago.
```

---

## Resultado esperado

Gemini debe devolver:
- [ ] Plugins Obsidian recomendados con configuración concreta
- [ ] Estructura frontmatter estándar para nuestro sistema
- [ ] Queries Dataview para inbox y estado del sistema
- [ ] Workflow n8n o script para sync automático
- [ ] Ejemplos de repos públicos de referencia

## Qué hacer con el resultado
- Volcar en `inbox/` con tag `deep-research`
- Extraer decisiones → nuevos ADRs en `docs/adr/`
- Implementar plugins en Obsidian varopc
- Documentar workflow final en `CONVENCIONES.md`

---
_Creado: 24 jun 2026 22:28 CEST — Perplexity vía MCP_
_Ver: [[diarios/2026-06-24]] · [[CONTEXT]] · [[inbox/README]]_
