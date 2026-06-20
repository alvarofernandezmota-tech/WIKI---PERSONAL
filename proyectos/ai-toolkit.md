---
tags: [proyecto, ai-toolkit, ia, entrenamiento, pendiente]
fecha-actualizacion: 2026-06-20
estado: pendiente-arrancar
---

# 🧠 ai-toolkit

> Toolkit para entrenar y ajustar modelos de IA localmente.
> Corre en Madre (GTX 1060 · pendiente upgrade RTX 3060).

---

## Estado actual

- ⏳ **Instalado pero sin arrancar** en Madre
- Bloqueado por: GPU insuficiente para modelos grandes
- Desbloqueado con: RTX 3060 12GB (~225€)

---

## Qué permite hacer

- Fine-tuning de modelos LLM con datos propios
- LoRA / QLoRA — adaptar modelos a casos de uso específicos
- Entrenar un modelo con tus propias notas de Obsidian
- Generar imágenes (Stable Diffusion) con GPU

---

## Requisitos hardware

| Tarea | VRAM mínima | Con GTX 1060 (6GB) | Con RTX 3060 (12GB) |
|---|---|---|---|
| LoRA 7B | 8 GB | ❌ no llega | ✅ |
| LoRA 14B | 16 GB | ❌ | ❌ (necesita 3090) |
| Stable Diffusion XL | 8 GB | ❌ lento | ✅ fluido |
| Stable Diffusion 1.5 | 4 GB | ✅ va | ✅ |

> **Conclusión:** Con GTX 1060 puedes hacer Stable Diffusion 1.5.
> Para LoRA y modelos grandes → upgrade RTX 3060 primero.

---

## Roadmap

- [ ] Verificar instalación en Madre: `ls ~/ai-toolkit`
- [ ] Primer experimento con SD 1.5 (cabe en 6GB VRAM)
- [ ] Upgrade RTX 3060 12GB cuando haya presupuesto
- [ ] LoRA fine-tuning con notas de yggdrasil-dew
- [ ] Integrar con Open WebUI en Madre

---

_Ver también: [[inbox/modelos-ollama-hardware-madre]] · [[setup/madre]] · [[HOME]]_
