---
tags: [inbox, ollama, hardware, modelos, ia-local, upgrade]
fecha: 2026-06-20
destino: setup/madre.md + agentes/ollama.md
prioridad: media
---

# 🧠 Modelos Ollama vs Hardware Madre — Análisis completo

> Antes de sobreescribir [[setup/madre]] con esto — entra aquí primero.
> Cuando se valide: mover el análisis a `setup/madre.md` sección Ollama.

---

## 💻 Hardware actual de Madre

| Componente | Detalle | Limitación para IA |
|---|---|---|
| CPU | Intel i5-8400 · 6 núcleos · 2.80GHz | Sin AVX-512 — ok para inferencia |
| RAM | 16 GB DDR4 | **Cuello de botella principal** — Docker + LLM compiten |
| GPU | NVIDIA GTX 1060 · **6 GB VRAM** | Suficiente para modelos 7B en GPU |
| Almacenamiento | HDD/SSD (verificar) | Si HDD → carga lenta de modelos |

---

## 🤖 Modelos que puedes correr AHORA (sin upgrade)

### En GPU (GTX 1060 — 6GB VRAM) → rápido

| Modelo | Tamaño VRAM | Velocidad | Para qué |
|---|---|---|---|
| `llama3.2:3b` | ~2.5 GB | ⚡ muy rápido | Respuestas rápidas TOKI |
| `llama3.1:8b` (Q4) | ~4.5 GB | ✅ fluido | Asistente general bueno |
| `mistral:7b` (Q4) | ~4.5 GB | ✅ fluido | Mejor para código |
| `qwen2.5:7b` (Q4) | ~4.5 GB | ✅ fluido | Muy bueno en castellano |
| `phi4-mini:3.8b` | ~3 GB | ⚡ rápido | Razonamiento eficiente |
| `deepseek-r1:7b` (Q4) | ~5 GB | ✅ fluido | Razonamiento + código |

> **Recomendación hoy:** `qwen2.5:7b` (castellano nativo) o `llama3.1:8b` (general).
> ```bash
> ollama pull qwen2.5:7b
> ollama pull llama3.1:8b
> ```

### En CPU + RAM (cuando VRAM no alcanza) → lento pero funciona

| Modelo | RAM necesaria | Velocidad | Nota |
|---|---|---|---|
| `llama3.1:8b` (Q4) | ~6 GB RAM | 🐢 lento | Solo si GPU ocupada |
| `llama3.1:14b` (Q4) | ~10 GB RAM | 🐢 muy lento | Con 16GB RAM va justo con Docker |
| `llama3.3:70b` (Q2) | ~24 GB | ❌ No arranca | RAM insuficiente |

---

## 🚀 Modelos con upgrades

### Upgrade A — RAM 32GB DDR4 (~40-50€)

Impacto en modelos:

| Modelo | Ahora (16GB) | Con 32GB |
|---|---|---|
| Docker + Ollama simultáneo | ⚠️ tenso | ✅ cómodo |
| `llama3.1:14b` CPU | ❌ no va bien | ✅ va fluido |
| `llama3.1:8b` GPU + Docker | ⚠️ márgenes justos | ✅ cómodo |

**Precio:** ~40-50€ — máximo impacto por euro gastado.

**Verificar compatibilidad antes de comprar:**
```bash
ssh alvaro@100.91.112.32
sudo dmidecode --type 17 | grep -E "Speed|Size|Type|Manufacturer"
# Ver: velocidad actual, tipo DDR4, slots libres
```

### Upgrade B — RTX 3060 12GB VRAM (~200-250€ segunda mano)

Impacto en modelos:

| Modelo | GTX 1060 (6GB) | RTX 3060 (12GB) |
|---|---|---|
| `llama3.1:8b` | ✅ cabe en GPU | ✅ sobra espacio |
| `llama3.1:14b` | ❌ no cabe GPU | ✅ cabe en GPU — rápido |
| `llama3.3:70b` Q4 | ❌ imposible | ⚠️ parcial GPU+CPU |
| `deepseek-r1:14b` | ❌ no cabe | ✅ fluido |
| `qwen2.5:14b` | ❌ no cabe | ✅ fluido |
| Stable Diffusion XL | ❌ lento | ✅ funciona |

**Conclusión:** RTX 3060 12GB desbloquea los modelos 14B en GPU — diferencia cualitativa enorme.

### Upgrade C — SSD NVMe (~40€)

```bash
# Verificar si tienes HDD o SSD
ssh alvaro@100.91.112.32
lsblk -d -o NAME,ROTA,SIZE,MODEL
# ROTA=1 → HDD | ROTA=0 → SSD
```

Si ROTA=1 (HDD): los modelos Ollama tardan 30-60s en cargar en vez de 2-5s.
Con SSD NVMe: carga instantánea. Gran impacto práctico.

---

## 📊 Tabla de decisión upgrades

| Upgrade | Coste | Impacto IA | Impacto general | ¿Cuándo? |
|---|---|---|---|---|
| RAM 32GB | ~45€ | ⭐⭐⭐⭐ | ⭐⭐⭐ | **Primero** — máximo ROI |
| SSD NVMe | ~40€ | ⭐⭐⭐ | ⭐⭐⭐⭐ | **Segundo** si aún HDD |
| RTX 3060 12GB | ~225€ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | **Tercero** cuando haya presupuesto |

**Orden óptimo:** RAM → SSD → GPU. ~85€ los dos primeros desbloquean mucho.

---

## 🛠️ Comandos para diagnosticar Madre ANTES de comprar

```bash
ssh alvaro@100.91.112.32

# RAM: tipo, velocidad, slots libres
sudo dmidecode --type 17 | grep -E "Size|Speed|Type|Bank"

# GPU: VRAM disponible ahora mismo
nvidia-smi

# Disco: SSD o HDD?
lsblk -d -o NAME,ROTA,SIZE,MODEL

# Espacio libre
df -h

# Modelos Ollama instalados
ollama list

# RAM usada con Docker corriendo
free -h
```

> ⚠️ Ejecutar estos comandos ANTES de comprar nada — pueden cambiar la decisión.
> Resultados → pegar en [[setup/madre]] y actualizar upgrades.

---

## ✅ Acciones de esta nota

- [ ] SSH a Madre → ejecutar comandos de diagnóstico
- [ ] Confirmar tipo RAM (DDR4 · velocidad · slots libres)
- [ ] Confirmar SSD o HDD
- [ ] Ver VRAM disponible con `nvidia-smi`
- [ ] `ollama list` → qué modelos ya están instalados
- [ ] Decidir upgrade con datos reales
- [ ] Mover resultados a [[setup/madre]] + archivar esta nota

---

_Creado: 20 jun 2026 · Destino: [[setup/madre]] + [[agentes/toki-bot]]_
_Ver también: [[setup/varopc]] · [[inbox/MASTER-PENDIENTES]] · [[HOME]]_
