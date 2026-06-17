# 🔵 Perplexity — Ficha de Agente

> Última actualización: 17 junio 2026

---

## Rol

Agente principal del ecosistema. Único con acceso MCP GitHub → puede leer y escribir en todos los repos directamente.

## Capacidades clave

| Capacidad | Uso concreto |
|---|---|
| MCP GitHub | Leer, crear, actualizar archivos en cualquier repo |
| Búsqueda web en tiempo real | Verificar versiones, docs técnicas, noticias |
| Contexto largo | Mantener hilo de sesión compleja |
| Código | Python, bash, Docker, YAML, Markdown |

## Cuándo usarlo

- Actualizar repos y documentación
- Auditorías de repos
- Escribir scripts, configs, docker-compose
- Crear/actualizar diarios
- Cualquier tarea que acabe en un commit a GitHub

## Prompt de arranque

```
Lee AGENT.md y CONTEXT.md de yggdrasil-dew y dame el estado actual.
Repo Space: https://github.com/alvarofernandezmota-tech/yggdrasil-dew
```

## Motor

Claude Sonnet 4.6 (vía Perplexity)
