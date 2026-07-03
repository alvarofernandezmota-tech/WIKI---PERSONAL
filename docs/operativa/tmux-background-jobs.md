# Tmux — Jobs en background en Madre

> Estado: ✅ OPERATIVO — 03-jul-2026

## Por qué tmux

Cuando operas desde iPhone (Blink Shell), la terminal se bloquea con procesos largos.
Tmux permite lanzar procesos que sobreviven aunque:
- Cierres Blink
- Se vaya la pantalla del iPhone
- Se corte la conexión SSH

## Sesión activa

```
trabajo: 1 windows (created Fri Jul 3 04:23:32 2026)
```

## Comandos básicos

```bash
# Ver sesiones activas
tmux ls

# Entrar a una sesión
tmux attach -t trabajo

# Salir sin matar (detach)
Ctrl+B luego D
# En iPhone: barra Blink → ctrl → B → D

# Nueva sesión
tmux new-session -d -s nombre

# Mandar comando a sesión en background
tmux send-keys -t trabajo 'comando' Enter

# Matar sesión
tmux kill-session -t trabajo
```

## Script de descargas Ollama

Ubicación: `~/pull-modelos.sh`

```bash
#!/bin/bash
for modelo in llama3.1:8b mistral:7b codellama:7b; do
  echo "$(date) — Descargando $modelo..."
  until ollama pull $modelo; do
    echo "$(date) — Reintentando en 30s..."
    sleep 30
  done
  echo "$(date) — $modelo LISTO"
done
echo "TODOS LOS MODELOS LISTOS"
```

Lanzado en sesión tmux `trabajo` el 03-jul-2026 04:23.
Modelos: `llama3.1:8b`, `mistral:7b`, `codellama:7b`

## Ver progreso

```bash
tmux attach -t trabajo
```

## Relanzar si se pierde la sesión

```bash
tmux new-session -d -s trabajo
tmux send-keys -t trabajo '~/pull-modelos.sh' Enter
```

## Issues relacionados

- #20 — Ollama en Madre
- #23 — iPhone SSH via Blink

---

_Documentado por Perplexity MCP — 03-jul-2026_
