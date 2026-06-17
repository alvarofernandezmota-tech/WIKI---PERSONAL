# 🤖 Agentes IA — Roles y Protocolos

> Cómo trabajan las IAs en el ecosistema de Álvaro.
> Última actualización: 17 junio 2026

---

## Ecosistema IA dual

Álvaro trabaja con múltiples IAs en paralelo. Cada una tiene un rol fijo y complementario.

| IA | Acceso | Rol principal | Estado |
|---|---|---|---|
| **Perplexity** (Claude Sonnet 4.6) | Web + MCP GitHub | Código · repos · docs · arquitectura | ✅ Principal |
| **Grok** (xAI) | Web + X/Twitter | Investigación · mercado · datos frescos | ✅ Activo |
| **Gemini 2.0 Pro** | Web | Contexto 1M tokens · código largo | ✅ Activo |
| **OpenCode** | Terminal varopc | Agente código local · multi-repo | ✅ Configurado |
| **Mistral Le Chat** | Web | Investigación EU · privacidad | ⏳ Parcial |

---

## Protocolo de handoff

```
Grok (investiga brutal) → Perplexity (valida + sube al repo)
Gemini (diseña / código largo) → Perplexity (sube al repo)
Perplexity (audita repo) → prompt de contexto para el resto
OpenCode (terminal) → commits locales → Perplexity documenta
```

**Regla de oro:** output final en GitHub → siempre pasa por Perplexity (tiene MCP GitHub).

---

## Cómo arrancar una sesión nueva

### Con Perplexity
```
Lee AGENT.md y CONTEXT.md de yggdrasil-dew y díme el estado actual del ecosistema.
Repo: https://github.com/alvarofernandezmota-tech/yggdrasil-dew
```

### Con Grok
```
Soy Álvaro. Mi ecosistema técnico está documentado en:
https://github.com/alvarofernandezmota-tech/yggdrasil-dew
Investiga [TEMA] y dame opciones con pros/contras. Voy a implementar con Perplexity.
```

### Con Gemini
```
Soy Álvaro. Contexto completo en:
https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/ECOSISTEMA.md
Necesito que implementes [TAREA LARGA] completa.
```

### Con OpenCode
```bash
# Desde varopc, en el directorio del proyecto
opencode
# OpenCode lee opencode.json y el contexto del repo automáticamente
```

---

## Fichas individuales

- [perplexity.md](perplexity.md) — instrucciones detalladas para Perplexity
- [grok.md](grok.md) — instrucciones detalladas para Grok

---

_Ver roles completos: [../AGENT.md](../AGENT.md)_
