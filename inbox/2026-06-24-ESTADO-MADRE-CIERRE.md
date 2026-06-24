# Estado Madre al cierre — 2026-06-24 04:52 CEST

## Descargas Ollama

| Modelo | Estado |
|--------|--------|
| qwen2.5:3b | ✅ Descargado — 1.9GB |
| qwen2.5:7b | ⏳ Descargando — 2 procesos en paralelo (normal) |
| resto cola | ⏳ Pendientes en script |

## Procesos activos

```
root      153013  /bin/ollama serve                          ← daemon OK
varopc    214638  docker exec ollama ollama pull qwen2.5:7b  ← descarga manual previa
root      214661  ollama pull qwen2.5:7b                     ← idem
varopc    217737  /bin/bash run-descarga-ollama.sh           ← script con reintentos
varopc    217784  ollama pull qwen2.5:7b                     ← idem script
```

Dos procesos descargando el mismo modelo — no es problema, Ollama no duplica en disco.

## Disco

- Total: 930GB
- Usado: 100GB (11%)
- Libre: **829GB** — sin problema para toda la cola

## Nota bracket paste mode

La terminal en Madre interpretó mal el pegado masivo (`^[[200~`).
Solución: pegar comandos de uno en uno, o desactivar con:
```bash
printf '\e[?2004l'
```

## Cola de modelos pendientes

qwen2.5:7b → qwen2.5:14b → qwen2.5:32b → bge-m3 → nomic-embed-text → llama3.1:8b → mistral:7b → codestral:latest

**Verificar mañana con:** `ollama list`
