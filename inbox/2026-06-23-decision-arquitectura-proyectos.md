---
tags: [inbox, arquitectura, decision, proyectos, thdora, local-brain, pendiente-migrar]
fecha: 2026-06-23
estado: pendiente-migrar
destino: proyectos/
ruta-obsidian: inbox/2026-06-23-decision-arquitectura-proyectos.md
relacionado-anterior: [[inbox/2026-06-23-v4-pendiente-ollama]]
relacionado-siguiente:
---

# Decisión de Arquitectura — Proyectos Separados

> Decisión tomada el 2026-06-23.
> No mezclar proyectos. Cada uno tiene una única responsabilidad.

## Regla fundamental

```
Cada proyecto = una responsabilidad = un repositorio / carpeta
Los proyectos se comunican via HTTP, nunca compartiendo código interno
```

## Mapa de proyectos del ecosistema

```
THDORA (bot Telegram)
  └── Responsabilidad: interfaz conversacional va Telegram
  └── Si necesita RAG → HTTP GET :8001
  └── Si necesita ejecutar comandos → su propio handler
  └── NO contiene lógica de RAG ni de vectores

LOCAL BRAIN (:8001)
  └── Responsabilidad: API de consulta al vault Obsidian
  └── No sabe nada de Telegram ni de ningún cliente
  └── Cualquier cliente puede consultarla

CHATBOT DE CONTROL (futuro)
  └── Responsabilidad: interfaz web para controlar el ecosistema
  └── Alternativas: Open WebUI, panel propio FastAPI+htmx
  └── Consume: LOCAL BRAIN + GitHub API + comandos
  └── NO es THDORA, es un proyecto distinto

TERMINAL IA (futuro)
  └── Responsabilidad: editar repo desde terminal con IA
  └── Candidatos: Aider, opencode (ya existe en cli-tools/)
  └── Backend: Ollama local o Groq API
```

## Cómo conectar THDORA con RAG (cuando toque)

No reestructurar THDORA. Añadir un comando especial:
```python
# En THDORA — handler nuevo, no tocar lo existente
@router.message(Command("vault"))
async def vault_query(message: Message):
    query = message.text.replace("/vault", "").strip()
    r = requests.post("http://localhost:8001/query",
                      json={"prompt": query})
    await message.answer(r.json()["response"])
```

## Pendiente crear en proyectos/

- [ ] `proyectos/thdora.md` — ficha del proyecto bot Telegram
- [ ] `proyectos/local-brain.md` — ficha del proyecto RAG
- [ ] `proyectos/chatbot-control.md` — idea pendiente de definir
- [ ] `proyectos/terminal-ia.md` — idea pendiente de definir
