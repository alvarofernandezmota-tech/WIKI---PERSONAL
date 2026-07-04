---
tipo: debate-multi-ia
fecha: 2026-06-24
hora: "06:39"
fuente: grok-3
status: decision-pendiente
tags: [ollama, llama.cpp, arquitectura, ram, docker, thdora, decision]
priority: ALTA
---

# 🥊 DEBATE GROK — Ollama Domado vs llama.cpp Nativo

> **Contexto:** Grok matiza el escepticismo radical de la tesis anterior.  
> **Veredicto Grok:** Ecosistema híbrido = OOM Killer garantizado. Hay que elegir UN solo rey.

---

## El "secreto" de Ollama

Ollama **no es un motor diferente**. El 95% de su código de inferencia es llama.cpp envuelto en Go.
Lo que añade Ollama sobre llama.cpp:
- `ollama pull` / `ollama run` — descarga con un comando
- Gestión automática de archivos
- API REST lista sin compilar nada

### El problema con Ollama en hardware antiguo (por defecto)
- Intenta cargar **varios modelos a la vez** si recibe peticiones en paralelo
- Mantiene modelos en **caché** consumiendo RAM
- Asigna hilos dinámicamente → **thread contention** en 6 hilos puros

---

## ❌ Por qué el ecosistema híbrido NO funciona

Ollama + llama.cpp server simultáneos en 16GB = **OOM Killer activado**.

Ambos intentarán reservar GB independientes para el mismo modelo (Qwen2.5-7B ~6GB):
```
Ollama carga Qwen2.5-7B   → ~6 GB RAM
llama.cpp carga Qwen2.5-7B → ~6 GB RAM
Stack Docker (9 containers) → ~4 GB RAM
Total:                      → ~16 GB = TECHO
Resultado: THDORA se congela, kernel mata containers
```

**Regla:** En 16 GB hay **un solo rey de la inferencia**.

---

## Las dos únicas opciones reales

### 🟡 Opción 1 — Ollama "Domado" (camino pragmático)

Mantener Ollama pero **caparlo completamente** con variables de entorno Docker:

```yaml
# docker-compose.yml — Ollama domado
services:
  ollama:
    environment:
      - OLLAMA_NUM_PARALLEL=1        # Prohibido procesar 2 cosas a la vez
      - OLLAMA_MAX_LOADED_MODELS=1   # Solo 1 modelo en RAM; si entra otro, el anterior muere
    deploy:
      resources:
        limits:
          memory: 10g
```

```
# Modelfile — control estricto de hilos
PARAMETER num_thread 4
PARAMETER num_ctx 4096
PARAMETER temperature 0.0
```

**Ventajas:**
- `ollama pull` sigue funcionando → probar modelos nuevos es trivial
- API REST lista sin configuración extra
- Comportamiento predecible con los límites

**Inconvenientes:**
- ~100-200 MB RAM de overhead del gestor Go
- Menos control granular que llama.cpp nativo

---

### 🔵 Opción 2 — Full llama.cpp (camino purista Arch)

Borrar Ollama. Descargar `.gguf` de HuggingFace manualmente. Levantar `llama-server`.

```bash
# Ejemplo de arranque llama-server
./llama-server \
  --model /models/qwen2.5-7b-instruct-q5_k_m.gguf \
  --threads 4 \
  --ctx-size 4096 \
  --port 11434
```

**Ventajas:**
- ~100-200 MB RAM ahorrados
- Control absoluto de cada parámetro y cada byte
- Filosofía purista: cero capas innecesarias

**Inconvenientes:**
- Cada modelo nuevo = buscar repo en HF + elegir cuantización + configurar script
- Sin `ollama pull` → más fricción para experimentar
- Gestión manual de archivos .gguf

---

## Veredicto de Grok

> Para desarrollar proyectos reales antes de 2027:
> **Opción 1 (Ollama Domado)** es la más sensata.
>
> Da velocidad de desarrollo sin el dolor de gestionar GGUF rotos a mano.
> Con los límites de recursos aplicados, el i5-8400 no sufrirá.

---

## ❓ Decisión pendiente

- [ ] **Opción 1:** Domar Ollama en Docker actual
- [ ] **Opción 2:** Migrar a llama.cpp nativo estilo Arch

### Factores para decidir

| Factor | Ollama Domado | llama.cpp Nativo |
|--------|--------------|------------------|
| Velocidad de experimentación | ✅ Alta | ⚠️ Baja |
| Control de recursos | ⚠️ Medio | ✅ Total |
| Filosofía purista | ⚠️ Capa extra | ✅ Pura |
| Fricción para probar modelos | ✅ Baja | ⚠️ Alta |
| RAM overhead | ⚠️ +100-200 MB | ✅ Mínima |
| Estabilidad THDORA | ✅ Con límites | ✅ Con config |
| Curva de aprendizaje | ✅ Baja | ⚠️ Media |

### Próximos pasos según elección

**Si Opción 1:** Grok prepara `docker-compose.yml` con Ollama domado + Modelfiles
**Si Opción 2:** Grok prepara script de instalación llama-server + estructura carpetas GGUF

---

## Nota sobre la tesis anterior

La tesis del turno 1 (llama.cpp > Ollama siempre) era correcta en términos de overhead puro,
pero Grok la matiza: **Ollama domado es pragmáticamente equivalente** a llama.cpp
para el caso de uso de Álvaro, con la ventaja de la facilidad de experimentación.

Ambas posiciones son válidas. La elección depende de:
- ¿Cuánto tiempo quieres invertir en gestión de infraestructura?
- ¿Cuánto valoras probar modelos nuevos rápidamente?
