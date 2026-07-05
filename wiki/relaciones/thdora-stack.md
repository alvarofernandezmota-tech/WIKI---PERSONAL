---
tipo: relacion
nombre: THDORA Stack
islas: [thdora, infra, ia-local]
obsidian_link: "[[thdora-stack]]"
estado: activo
---

# 🔗 Relación: Stack completo de THDORA

THDORA es el producto más complejo del ecosistema porque **depende de infraestructura Y de IA local** a la vez.

## Arquitectura completa

```
iPhone / Telegram
    ↓
Telegram API (cloud)
    ↓
THDORA Bot (Madre Docker :8000)
    ├──► Ollama local (Madre :11434) ← modelos 7B
    ├──► GitHub API (issues, commits)
    └──► Filesystem Madre (logs, sesiones)
```

## Dependencias en cadena

```
THDORA
  └── depende de → Madre (Docker activo)
        └── depende de → Red (Tailscale activo)
              └── depende de → Internet (4G Xiaomi)
  └── depende de → Ollama
        └── depende de → GPU GTX 1060
              └── depende de → Driver NVIDIA
```

## Si THDORA no responde

```bash
# En Madre
docker ps | grep thdora
docker logs thdora --tail 50

# Si el contenedor está unhealthy
docker restart thdora

# Verificar Ollama
curl http://localhost:11434/api/tags
```

## Repos relacionados

- `THDORA-PERSONAL` → https://github.com/alvarofernandezmota-tech/THDORA-PERSONAL
- `ollama-stack` → https://github.com/alvarofernandezmota-tech/ollama-stack
- `madre-config` → https://github.com/alvarofernandezmota-tech/madre-config

---
_Actualizado: 2026-07-05 · Perplexity-MCP_
