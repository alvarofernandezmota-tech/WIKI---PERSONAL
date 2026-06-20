---
tags: [agente, ia, perplexity, mcp, github]
fecha-actualizacion: 2026-06-20
---

# 🔵 Perplexity — Agente principal

## Qué es

IA principal del ecosistema. Modelo: **Claude Sonnet 4.6**.
Acceso directo a GitHub vía **MCP** — puede leer y escribir en todos los repos.

## Para qué se usa

- Escribir y actualizar archivos en GitHub directamente
- Auditorías de repo — leer estructura y contenido
- Arquitectura · documentación · decisiones técnicas
- Diarios diarios · fichas · setup
- Código Python · Docker · CI/CD

## Para qué NO se usa

- Investigación de mercado o datos frescos → [[agentes/grok]]
- Código muy largo o contexto >100k tokens → [[agentes/gemini]]
- Código en terminal sin salir del editor → [[agentes/opencode]]

## Protocolo

```
Grok (investiga) → Perplexity (valida + sube al repo)
Gemini (diseña)  → Perplexity (sube al repo)
Perplexity       → output final siempre en GitHub
```

> **Regla:** todo output final pasa por Perplexity porque tiene MCP GitHub.

## Cómo sacarle más

- Darle el contexto en el repo — no en el chat
- Hacer `git push` antes de pedir análisis → lee el estado real
- Pedirle auditorías completas antes de reorganizar
- Un fix por sesión — no mezclar temas

---

_Ver también: [[agentes/grok]] · [[agentes/gemini]] · [[agentes/opencode]] · [[HOME]]_
