---
id: 202406242250
fecha: 2026-06-24
tipo: pending
status: activo
repo: yggdrasil-dew
diario: "[[diarios/2026-06-24]]"
destino: docs/arquitectura/
tags: [inbox, ecosistema, migracion, repos, mapa-completo, ssot]
sync: true
---

# Mapa ecosistema completo — preparación migración

> Este archivo documenta TODOS los repos, cómo se conectan con yggdrasil-dew
> y qué necesita cada uno para estar completo.
> yggdrasil-dew/inbox es la INBOX MAESTRA de todo el ecosistema.

---

## 📜 Regla: yggdrasil-dew como SSOT maestro

Segundo la investigación Gemini Deep Research [[inbox/2026-06-24-DEEP-RESEARCH-ALINEACION-SSOT]]:
- **Un vault maestro** con referencias a repos externos = práctica correcta
- **NO submódulos Git** — fragiles en Obsidian
- **Tags con prefijo repo**: `#repo/thdora`, `#repo/osint-stack`, etc.
- **Wikilinks** desde ygg hacia fichas de cada proyecto en `proyectos/`
- **inbox/ygg = inbox maestra** — todo entra aquí, luego se distribuye

---

## 📦 Repos existentes — qué necesita cada uno

### 🧠 yggdrasil-dew — MAESTRO
- URL: https://github.com/alvarofernandezmota-tech/yggdrasil-dew
- Estado: ✅ activo, bien documentado
- inbox: **INBOX MAESTRA** — todo entra aquí
- Pendiente:
  - [ ] HOME.md → convertir a Dataview dashboard
  - [ ] ESTADO-SISTEMA.md → fusionar en CONTEXT.md
  - [ ] Instalar plugins Obsidian (ADR-005)

### 🤖 ollama-stack — NUEVO ✅
- URL: https://github.com/alvarofernandezmota-tech/ollama-stack
- Estado: ✅ creado 24 jun — README + docker-compose + litellm-config
- Enlace ygg: [[proyectos/ollama-stack/README]]
- Pendiente: [ ] ficha en proyectos/ de ygg

### 🕷️ osint-stack — DOCUMENTAR
- URL: https://github.com/alvarofernandezmota-tech/osint-stack
- Estado: ⚠️ creado 24 jun, README mínimo
- Stack Docker: SpiderFoot · SearXNG · Perplexica · Pi-hole
- Enlace ygg: [[proyectos/osint-stack/README]]
- Pendiente:
  - [ ] README completo con Docker map
  - [ ] docker-compose.yml
  - [ ] ficha en proyectos/ de ygg

### 🧠 local-brain — DOCUMENTAR
- URL: https://github.com/alvarofernandezmota-tech/local-brain
- Estado: ⚠️ creado 24 jun, README mínimo
- Stack Docker: Ollama (referencia) · pgvector · RAG pipeline · embeddings
- Enlace ygg: [[proyectos/local-brain/README]]
- Pendiente:
  - [ ] README completo
  - [ ] docker-compose.yml
  - [ ] ficha en proyectos/ de ygg

### 🤖 thdora — ACTIVO
- URL: https://github.com/alvarofernandezmota-tech/thdora
- Estado: 🔧 activo, 12 issues abiertos, handlers pendientes
- Stack Docker: thdora-bot (531MB) · FastAPI · Redis
- Enlace ygg: [[proyectos/thdora/README]]
- Pendiente:
  - [ ] Handlers: /estado, /cierre, /inbox, /pendientes
  - [ ] Integrar Ollama local
  - [ ] Handler /cierre para sync automático ygg

### 📂 personal — ACTIVO
- URL: https://github.com/alvarofernandezmota-tech/personal
- Estado: ✅ activo — finanzas, gym, salud, diario personal
- Enlace ygg: [[yo/personal-repo]]
- Privacidad: ⚠️ público — revisar si debe ser privado

### 🤖 ai-toolkit — PÚBLICO
- URL: https://github.com/alvarofernandezmota-tech/ai-toolkit
- Estado: ✅ estable — Claude Code + OpenRouter + herramientas
- Enlace ygg: [[proyectos/ai-toolkit/README]]

### 🖨️ impresion-3d — ACTIVO
- URL: https://github.com/alvarofernandezmota-tech/impresion-3d
- Estado: ✅ estable — Anycubic Photon V1
- Enlace ygg: [[proyectos/impresion-3d/README]]

### 🤖 thea-ia — LEGADO
- URL: https://github.com/alvarofernandezmota-tech/thea-ia
- Estado: 🟡 mantenimiento — proyecto anterior a thdora
- Enlace ygg: [[proyectos/thea-ia/README]]
- Pendiente: [ ] decidir si archivar o migrar a thdora

### 🖼️ image-calculator — ESTABLE
- URL: https://github.com/alvarofernandezmota-tech/image-calculator
- Estado: ✅ estable — OCR + calculadora Python

---

## 📌 Repos pendientes crear

### 📹 camaras (nombre a definir)
- **Descripción**: Sistema cámaras de seguridad home lab
- **Stack Docker sugerido**: Frigate NVR · RTSP · MotionEye o similar
- **Privado**: sí — obligatorio
- **Enlace ygg futuro**: [[proyectos/camaras/README]]
- Pendiente:
  - [ ] Decidir nombre del repo
  - [ ] Elegir stack (Frigate vs MotionEye vs Shinobi)
  - [ ] Crear repo privado
  - [ ] Documentar en ECOSISTEMA.md

### 🔒 nsiq (nombre a definir)
- **Descripción**: Confirmar qué es este proyecto exactamente
- **Estado**: ❓ pendiente confirmar con Álvaro qué es nsiq
- Pendiente:
  - [ ] Confirmar descripcion y stack
  - [ ] Crear repo privado
  - [ ] Documentar en ECOSISTEMA.md

### chatbot-control
- Ver: [[inbox/2026-06-24-REPOS-CREAR-CHATBOT-TERMINAL]]

### terminal-ia
- Ver: [[inbox/2026-06-24-REPOS-CREAR-CHATBOT-TERMINAL]]

---

## 🔗 Cómo conectar cada repo con yggdrasil-dew

### 1. Ficha en proyectos/ (ya hecho para algunos)
Cada repo tiene una ficha en `proyectos/NOMBRE/README.md` con:
- Descripcion, stack, estado, links, pendientes
- Tag `#repo/NOMBRE`
- Wikilink de vuelta a ECOSISTEMA.md

### 2. Tag en cada archivo que hace referencia
```yaml
tags: [#repo/thdora, docker, telegram]
```

### 3. Obsidian URI para saltar entre repos
```
obsidian://open?vault=yggdrasil-dew&file=proyectos/thdora/README
```

### 4. inbox maestra — regla de entrada
Todo lo nuevo de CUALQUIER repo entra primero en `yggdrasil-dew/inbox/`
con el tag del repo correspondiente:
```yaml
tags: [inbox, #repo/thdora, pendiente-migrar]
destino: proyectos/thdora/
```

---

## 🚀 Plan de migración — orden recomendado

1. **Instalar Obsidian Git** → auto-sync ygg con GitHub
2. **Documentar local-brain** → README + docker-compose
3. **Documentar osint-stack** → README + docker-compose
4. **Crear fichas proyectos/** en ygg para cada repo
5. **Confirmar nsiq** → crear repo
6. **Decidir stack cámaras** → crear repo
7. **Crear chatbot-control + terminal-ia**
8. **HOME.md** → Dataview dashboard

---
_Creado: 24 jun 2026 22:50 CEST — Perplexity vía MCP_
_Ver: [[diarios/2026-06-24]] · [[ECOSISTEMA]] · [[CONTEXT]] · [[inbox/MASTER-PENDIENTES]]_
