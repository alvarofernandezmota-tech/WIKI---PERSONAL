---
tags: [agente, ia, llm, audio, voz, whisper, tts, local, especializado]
fecha-actualizacion: 2026-06-22
---

# 🎙️ Especializados: Audio y Voz — Transcripción y Síntesis Local

## Modelos
- **Whisper large-v3** (OpenAI — open source)
- **Kokoro TTS** (Open Source)

## Whisper large-v3 — Transcripción (STT)

### Qué hace
Transcripción de audio a texto con altísima precisión en +99 idiomas incluyendo español.

### Arquitectura
- Transformer encoder-decoder entrenado sobre 680.000 horas de audio multilingüe
- Detección automática de idioma
- Timestamps por palabra / segmento

### Mejor para
- Transcribir notas de voz para el diario de Obsidian
- Extraer texto de grabaciones de reuniones o tutoriales técnicos
- Pipeline: audio → texto → Claude para procesar

### Hardware
- **RAM mínima (large-v3):** 6-8 GB — funciona en Acer con modelos medium/small
- **Variante para Acer:** whisper:medium o whisper:small (~2-3 GB RAM)
- **Velocidad:** Depende del tamaño — small es ~10x tiempo real en CPU

```bash
# Via faster-whisper (recomendado en Arch)
pip install faster-whisper

# Via Ollama (si disponible)
ollama pull whisper

# Uso directo
wisper audio.mp3 --model medium --language es
```

## Kokoro TTS — Síntesis de Voz (TTS)

### Qué hace
Genera voz sintética natural a partir de texto — text-to-speech de calidad.

### Mejor para
- Convertir notas del vault en audio para escuchar en el paseo
- Interfaz de voz para el ecosistema
- Narración de documentación técnica

### Hardware
- **RAM mínima:** 2-4 GB — muy ligero, funciona en Acer

```bash
# Instalación
pip install kokoro-onnx
```

## Coste
- **Whisper:** Open source — gratuito (MIT)
- **Kokoro:** Open source — gratuito

## Privacidad
- **Absoluta:** Todo procesado en local — audio no sale de tu máquina

## Workflow en el ecosistema
```
Nota de voz → Whisper (transcribe) → Claude/inbox (procesa y documenta)
Texto vault → Kokoro TTS (sintetiza) → Audio para escuchar en paseo
```

---
_Ver también: [[agentes/especializados-ocr-vision]] · [[agentes/especializados-embeddings]]_
