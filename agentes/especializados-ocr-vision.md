---
tags: [agente, ia, llm, ocr, vision, local, especializado]
fecha-actualizacion: 2026-06-22
---

# 👁️ Especializados: Visión y OCR Open Source — Extracción Estructurada de Texto Local

## Modelos y versiones
- **PaddleOCR v4+** (Baidu)
- **TrOCR** — Transformer-based OCR (Microsoft Research)
- **Tesseract 5** (Google / Open Source Community)

## Arquitecturas

### PaddleOCR
- Combinación CNN (detección) + Transformer compacto (reconocimiento)
- Pipeline: Detección de región → Corrección de perspectiva → Reconocimiento

### TrOCR
- Arquitectura end-to-end puramente Transformer
- Vision Transformer (ViT) codifica la imagen → Language Transformer decodifica el texto

### Tesseract 5
- Motor LSTM entrenado sobre múltiples datasets multilingüe
- Más veterano, excelente para texto limpio y tipografías estándar

## Modalidades
- **Entrada:** Imágenes fijas, PDFs escaneados, capturas de pantalla de terminal, esquemas gráficos de red
- **Salida:** Texto plano estructurado, coordenadas espaciales de cajas de texto, JSON con jerarquía visual

## Capacidades especiales
- **Layout Analysis (PaddleOCR):** Identifica estructura de página — separa texto de imágenes, tablas y diagramas
- **Detección automática de idioma**
- **Corrección de perspectiva geométrica**
- **Reconstrucción formal de tablas complejas**
- **Rotación automática de imagen**

## Mejor para
- Extracción de texto de capturas de pantalla de redes y logs de terminal
- Auditoría visual y documentación OSINT privada local
- Esquemas técnicos de infraestructura informática
- Procesamiento offline de documentos confidenciales escaneados
- OCR en esquemas de red complejos (caso de uso mencionado por Álvaro)

## Peor para (usar otra IA)
- Mantener hilos de conversación lógicos — estos modelos solo transcriben
- Tareas deductivas conceptuales abstractas
- Razonamiento sobre el contenido extraído → pasar output a Claude o Gemini

## Coste
- **Licencia:** Apache 2.0 / MIT / Apache 2.0 — totalmente gratuitos

## Privacidad y datos
- **Privacidad absoluta:** Ejecución local sin envío de imágenes a servidores externos

## Instalación

```bash
# PaddleOCR (Python)
pip install paddlepaddle paddleocr

# TrOCR (via Hugging Face)
pip install transformers

# Tesseract 5 (Arch Linux)
pacman -S tesseract tesseract-data-spa tesseract-data-eng

# Uso básico PaddleOCR
python -c "from paddleocr import PaddleOCR; ocr = PaddleOCR(lang='es'); print(ocr.ocr('imagen.png'))"

# Uso básico Tesseract
tesseract imagen.png output -l spa+eng
```

## Workflow recomendado en el ecosistema
```
Captura de pantalla / imagen → PaddleOCR (extrae texto) → Claude/Gemini (razona sobre el contenido)
```

---
_Ver también: [[agentes/chatgpt-o3]] · [[agentes/especializados-embeddings]] · [[agentes/especializados-audio]]_
