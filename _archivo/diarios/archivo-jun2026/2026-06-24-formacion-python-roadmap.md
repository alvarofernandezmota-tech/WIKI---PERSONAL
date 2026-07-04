---
tags: [inbox, formacion, python, roadmap, pendiente-mover]
fecha: 2026-06-24
destino: formacion/python/roadmap.md
estado: borrador
---

# Python Roadmap — Formacion Practica

> Orientado al ecosistema real: Ollama API, scripts red, bots Telegram.
> Mover a formacion/python/roadmap.md cuando toque.

---

## Nivel actual
- Modulo 04 completado
- Modulo 05 en progreso
- Conocimiento: basico-intermedio

## Roadmap practico (por orden)

### Semana 1-2 — Fundamentos solidos
- [ ] Terminar modulo 05 curso
- [ ] Practica: leer/escribir archivos .md con Python
- [ ] Practica: requests basico — GET a Ollama API

### Semana 3-4 — Ollama API
- [ ] Script: query a Ollama API local
```python
import requests

def ask_ollama(prompt, model="qwen2.5:3b-cpu"):
    r = requests.post("http://localhost:11434/api/generate",
        json={"model": model, "prompt": prompt, "stream": False})
    return r.json()["response"]

print(ask_ollama("hola, quien eres?"))
```
- [ ] Script: listar modelos instalados
- [ ] Script: chat con historial

### Semana 5-6 — Scripts red y sistema
- [ ] Script: ping sweep red local
- [ ] Script: port scanner basico (aprendizaje, no uso en redes ajenas)
- [ ] Script: leer docker ps via subprocess

### Semana 7-8 — Bot Telegram
- [ ] python-telegram-bot: handler /start
- [ ] Handler /inbox <texto> -> escribe nota en repo
- [ ] Handler /estado -> docker ps en Madre
- [ ] Conectar con Ollama -> handler /pregunta <texto>

---

## Recursos
- Curso actual: modulo 05
- Docs Ollama API: http://localhost:11434/docs
- python-telegram-bot: https://python-telegram-bot.org

---
_Mover a: formacion/python/roadmap.md_
