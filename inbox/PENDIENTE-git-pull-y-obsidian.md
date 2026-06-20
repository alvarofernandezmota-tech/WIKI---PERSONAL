---
tags: [pendiente, obsidian, git, sincronizacion, urgente]
fecha: 2026-06-20
destino: setup/obsidian.md
prioridad: URGENTE
---

# ⚠️ PENDIENTE — Sincronizar local con GitHub

> Esta nota existe porque el vault local de Obsidian NO está sincronizado.
> Todo lo de esta mañana solo está en GitHub. Hasta que hagas `git pull`, Obsidian está ciego.

---

## 📥 Paso 1 — Sincronizar ahora (2 minutos)

```bash
cd ~/Projects/yggdrasil-dew
git pull
```

Despues abrir Obsidian → `Ctrl+G` → ver el grafo completo.

---

## 🔌 Paso 2 — Instalar plugin Git (5 minutos)

Para que Obsidian se sincronice SOLO sin hacer `git pull` nunca más:

```
Obsidian → Settings → Community Plugins → Turn on community plugins
→ Browse → buscar "Obsidian Git" → Install → Enable
```

Config recomendada del plugin:
```
Auto pull interval: 5 minutos
Auto push interval: 10 minutos
Commit message: vault: auto-sync {{date}}
```

Resultado: cada vez que escribas una nota en Obsidian → se sube sola a GitHub → yo la leo en la siguiente sesión.

---

## 🤖 Paso 3 — Conectar IA a Obsidian (10 minutos)

### Opción A — Smart Connections (más fácil)
```
Obsidian → Community Plugins → Browse → "Smart Connections" → Install
```
- RAG sobre tus propias notas
- Pregunta en lenguaje natural, responde citando tus archivos
- Necesita API key de OpenAI (o local con Ollama)

### Opción B — Local GPT + Ollama en Madre (más potente, 100% gratis)
```
Obsidian → Community Plugins → Browse → "Local GPT" → Install
```
Config:
```
Ollama URL: http://100.91.112.32:11434
Modelo: llama3.2 (o el que tengas en Madre)
```
- IA 100% local usando Ollama en Madre vía Tailscale
- Sin API key, sin coste, sin enviar datos fuera
- Responde con contexto de tus notas

### Opción C — Copilot plugin (más sencillo con Claude/GPT)
```
Obsidian → Community Plugins → Browse → "Copilot" → Install
```
- Chat con Claude o GPT dentro de Obsidian
- Contexto del vault incluido
- Necesita API key

---

## 🗓️ Lo que entró en GitHub esta mañana (invisible hasta git pull)

### Archivos nuevos desde el último commit local
- `yo/perfil.md`
- `proyectos/thdora.md`
- `agentes/perplexity.md` · `agentes/grok.md` · `agentes/gemini.md` · `agentes/opencode.md` · `agentes/toki-bot.md`
- `formacion/python.md` · `formacion/linux.md` · `formacion/sql.md` · `formacion/osint.md`
- `setup/varopc.md` (hardware real) · `setup/madre.md` (hardware real) · `setup/hp-touchsmart.md`
- `filosofia.md`
- `diarios/2026-06-05.md` · `diarios/2026-06-12.md`
- `inbox/` — 7 notas etiquetadas
- `HOME.md` — actualizado completo, cero links rotos

**Total: ~25 archivos nuevos o actualizados esta mañana.**

---

## ✅ Cuando esté hecho

- [ ] `git pull` ejecutado
- [ ] Grafo Obsidian revisado (`Ctrl+G`)
- [ ] Plugin Git instalado y configurado
- [ ] IA conectada (opción elegida: ___)
- [ ] Esta nota → mover a `diarios/2026-06-20.md` y archivar

---
_Creado por [[agentes/perplexity]] · 20 jun 2026 09:55 CEST_
_Ver también: [[inbox/obsidian-configuracion]] · [[setup/madre]] · [[HOME]]_
