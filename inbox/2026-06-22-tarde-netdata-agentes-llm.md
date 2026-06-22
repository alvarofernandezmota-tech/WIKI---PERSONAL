---
tags: [inbox, sesion, netdata, llm, agentes, ia, pendiente]
fecha: 2026-06-22
hora: tarde
estado: cerrado-paseo
---

# 📥 Sesión 22 Jun 2026 — Tarde

## ✅ Completado — Netdata Multi-nodo

Configurado streaming de métricas Acer → Madre via Netdata.

### Arquitectura
- **Madre (varpc)** `100.91.112.32` → receiver + dashboard central
- **Acer (theodora/varo12f)** `100.86.119.102` → sender

### Configuración Madre `/etc/netdata/stream.conf`
```ini
[5e5bbc39-0cc2-4650-a691-b273e8a131f2]
    enabled = yes
    default history = 3600
    default memory mode = ram
    health enabled by default = auto

[stream]
    enabled = yes
    destination = 100.91.112.32:19999
    api key = 5e5bbc39-0cc2-4650-a691-b273e8a131f2
```

### Configuración Acer `/etc/netdata/stream.conf`
```ini
[stream]
    enabled = yes
    destination = 100.91.112.32:19999
    api key = 5e5bbc39-0cc2-4650-a691-b273e8a131f2
```

### Dashboard
- URL: `http://100.91.112.32:19999`
- Nodos activos: 2 (varpc + varo12f)
- Receiving: 1 ✅

### Bug resuelto
El `cat >>` se ejecutó 3 veces seguidas → config duplicada 3x.
Fix: usar `cat >` (sobreescribir) en vez de `cat >>` (append).

---

## ⏳ Pendiente — próxima sesión

- [ ] SSH sin contraseña Madre → Acer
  ```bash
  ssh-keygen -t ed25519 -C "varopc"
  ssh-copy-id varo@100.86.119.102
  ```
- [ ] Sudo sin contraseña en Acer (opcional para scripts remotos)
- [ ] Conexión persistente Acer-Madre con autossh
- [ ] Instalar Obsidian en Acer vía SSH remoto
  ```bash
  ssh varo@100.86.119.102
  yay -S obsidian
  ```
- [ ] Dashboard HTML personalizado del ecosistema

---

## 📋 Plan fichas LLM — `agentes/`

### Contexto
Decidido actualizar y completar todas las fichas de `agentes/` a nivel profesional.
Cada ficha documenta: modelo, herramientas, skills, para qué usarlo, para qué no, coste, privacidad.

### Estado actual fichas
| Ficha | Estado |
|---|---|
| `perplexity.md` | ✅ Completo (20 Jun) |
| `grok.md` | ⚠️ Existe, revisar |
| `gemini.md` | ⚠️ Existe, revisar |
| `opencode.md` | ⚠️ Existe, revisar |
| `chatgpt.md` | ❌ No existe — crear |
| `ollama-local.md` | ❌ No existe — crear |
| `mistral.md` | ❌ No existe — crear |

### Fichas a crear
- ChatGPT (GPT-4o + o3) — skills únicas: OCR/visión, voz RT, code interpreter, Custom GPTs
- Modelos Ollama locales: Llama 3.3, Qwen 2.5, Deepseek, Phi-4, Gemma 3
- Modelos especializados: Whisper (audio), embeddings (nomic-embed), OCR (PaddleOCR)

### Workflow acordado
1. Gemini Deep Research investiga cada modelo en profundidad
2. Output pegado aquí → Perplexity sube al repo formateado
3. README de agentes actualizado con tabla completa

### Prompt maestro para Gemini (guardado)
Ver prompt completo en esta sesión de chat.
Incluye: contexto ecosistema, raw de repo de referencia, estructura exacta por ficha,
lista completa de modelos cloud + open source + especializados,
requisitos hardware Ollama por modelo.

### Modelos a documentar
**Cloud:**
- Claude Sonnet 4.6 (Anthropic) — via Perplexity
- GPT-4o + o3 (OpenAI)
- Gemini 2.5 Pro (Google)
- Grok 3 (xAI)
- Mistral Large 2 (Mistral AI)

**Open source / local Ollama:**
- Llama 3.3 70B (Meta)
- Qwen 2.5 72B (Alibaba)
- Deepseek R2 / Coder
- Mistral 7B / Mixtral
- Phi-4 (Microsoft)
- Gemma 3 (Google open)
- CodeGemma / StarCoder2

**Especializados:**
- OCR: PaddleOCR, TrOCR, Tesseract 5
- Embeddings: nomic-embed, mxbai-embed
- Audio/voz: Whisper, Kokoro TTS

---

## 📁 Archivos tocados hoy
- `/etc/netdata/stream.conf` — Madre y Acer
- `/etc/netdata/stream.conf.bak` — backup Acer
- `agentes/README.md` — revisado (pendiente actualizar)
- `agentes/perplexity.md` — revisado

---

_Sesión pausada para paseo con Threa 🐕 — continuar aquí_
