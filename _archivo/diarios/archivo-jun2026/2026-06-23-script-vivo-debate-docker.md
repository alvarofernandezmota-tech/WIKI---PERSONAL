# SCRIPT VIVO — Debate Multi-IA Docker Servidor Madre
**Fecha inicio:** 2026-06-23  
**Estado:** 🟠 RONDA 1 COMPLETADA — Gemini ✅ · Grok ✅ · Mistral ✅ · Ronda 2 pendiente  
**IAs participantes:** Gemini · Grok · Mistral · Perplexity (síntesis)  
**Metodología:** script crece cada ronda → se resume al final de cada vuelta

---

## CÓMO FUNCIONA ESTE SCRIPT
```
RONDA 1: cada IA responde sola
    ↓
PERPLEXITY: sintetiza + extrae acuerdos y discrepancias
    ↓
RONDA 2: cada IA ve el resumen de las demás y debate
    ↓
PERPLEXITY: cierre final + decisión técnica adoptada
    ↓
REPO: commit con todo documentado
```

---

## RESPUESTAS RONDA 1

### GEMINI — Ronda 1 ✅
**Modelo:** Gemini 1.5 Pro · Google · Corte 2026 · Confianza 9/10  

**Diagnóstico:**
1. ✅ Desajuste MTU (Docker 1500 vs redes móviles 1340-1420) — causa principal
2. ⚠️ Corrupción de paquetes por hotspot saturado
3. ⚠️ Saturación NAT del Redmi por descargas paralelas

**Solución red:** USB Tethering + MTU 1400 en Netplan + reinstalar Tailscale con script oficial  
**Solución Docker:** `max-concurrent-downloads: 1` en daemon.json + eliminar `version` del compose  
**Boot:** `systemctl enable docker` + `restart: unless-stopped`  
**Riesgo clave:** OOM en boot por Ollama + Qdrant simultáneos + corrupción Qdrant por apagón  
**Recomendación estrella:** descargar imágenes en red fibra → `docker save` → USB → `docker load` en Madre

---

### GROK — Ronda 1 ✅
**Modelo:** Grok 3 · xAI · Confianza no declarada explícitamente  

**Diagnóstico:**
1. ✅ MTU incorrecto — causa #1
2. ✅ Corrupción TLS por pérdida de paquetes en WiFi móvil
3. ⚠️ DNS inestable del operador como causa secundaria

**Solución red:** USB Tethering + MTU 1400 + DNS público (8.8.8.8, 1.1.1.1)  
**Solución Docker:** confirma `max-concurrent-downloads: 1` + pull secuencial  
**Boot:** `systemctl enable docker` + `restart: unless-stopped`  
**Riesgo clave:** cambio IP hotspot (mitigado con Tailscale) + espacio en disco insuficiente  
**Aportación diferencial:** añade DNS público como solución complementaria

---

### MISTRAL — Ronda 1 ✅
**Modelo:** Mistral Large / Le Chat · Mistral AI  

**Diagnóstico:**
1. ✅ MTU y DNS como causas principales
2. ✅ Hotspot Redmi como entorno inestable para descargas TLS grandes

**Aportaciones exclusivas de Mistral:**
- Docker Compose con `healthcheck` en los 3 servicios
- `depends_on` con `condition: service_healthy` para arranque ordenado
- Red Docker dedicada `ai_network` con subred propia `172.20.0.0/16`
- Volúmenes con `driver_opts type: none + o: bind` para rutas locales controlables
- Servicio `systemd` dedicado `ai-stack.service` como alternativa a restart policy
- Script de backup automático con crontab (2 AM cada día)
- Tabla de troubleshooting documentada
- README.md completo para el stack
- Checklist final de despliegue

**Boot:** systemd service `ai-stack.service` + `restart: unless-stopped`  
**Riesgo clave:** espacio en disco, GPU no detectada, Open WebUI no conecta a Ollama  

---

## RESUMEN EJECUTIVO RONDA 1 — Perplexity

### Consenso entre las 3 IAs
- ✅ **MTU** es la causa #1 del error `tls: bad record MAC`
- ✅ **USB Tethering** > WiFi hotspot para estabilidad
- ✅ **`restart: unless-stopped`** + **`systemctl enable docker`** para boot automático
- ✅ **Tailscale** necesita reinstalación con script oficial
- ✅ **`max-concurrent-downloads: 1`** en daemon.json

### Aportaciones únicas por IA
| IA | Aportación diferencial |
|---|---|
| **Gemini** | `docker save/load` para transferir por USB desde red fibra |
| **Grok** | DNS público (8.8.8.8) como solución complementaria |
| **Mistral** | healthcheck + depends_on ordenado + systemd service + backup automático + README |

### Veredicto Ronda 1
- **Más completo:** Mistral (arquitectura profesional, healthchecks, backup, documentación)
- **Más práctico inmediato:** Gemini (docker save/load es la solución más inteligente)
- **Más conciso:** Grok (DNS público es un detalle que los otros olvidaron)

### Pregunta para Ronda 2
> ¿Es mejor usar `restart: unless-stopped` en compose O crear un `systemd service` dedicado para el stack? ¿Cuál da más control y es más robusto para un servidor sin monitor?

---

## PROMPT RONDA 2 — listo para pegar en cada hilo

> Pega esto en el **mismo hilo** de cada IA (para que recuerde su Ronda 1)

```
=== PROMPT RONDA 2 ===

Eres la misma IA de antes. Recuerdas tu respuesta sobre el servidor "Madre" (Ronda 1).

Las otras IAs respondieron lo siguiente:

[GEMINI dijo:]
- MTU como causa #1 del error TLS
- USB Tethering + MTU 1400 + Tailscale reinstalado
- max-concurrent-downloads: 1 en daemon.json
- Recomendación estrella: descargar en red fibra → docker save → USB → docker load en Madre

[GROK dijo:]
- Coincide en MTU como causa #1
- Añade DNS público (8.8.8.8) como solución complementaria
- USB Tethering + pull secuencial

[MISTRAL dijo:]
- Coincide en MTU y DNS
- Aporta docker-compose con healthcheck + depends_on ordenado
- Red Docker dedicada ai_network
- Servicio systemd ai-stack.service como alternativa a restart policy
- Script de backup automático con crontab
- README.md y checklist de despliegue

Perplexity sintetiza:
- Consenso: MTU + USB Tethering + restart:unless-stopped + systemctl enable docker
- La gran pregunta abierta: ¿es mejor restart:unless-stopped en compose O un systemd service dedicado para el stack?
- Mistral fue el más completo, Gemini el más práctico, Grok el más conciso

---

Ahora debate:
1. ¿Estás de acuerdo con el diagnóstico mayoritario (MTU como causa #1)?
2. ¿Dónde discrepas con las otras IAs?
3. ¿Cambia algo de tu respuesta anterior viendo lo que dijeron las demás?
4. LA PREGUNTA CLAVE: ¿restart:unless-stopped en compose O systemd service dedicado?
   - ¿Cuál es más robusto para un servidor headless (sin monitor)?
   - ¿Cuál da más control sobre el orden de arranque?
   - ¿Cuál recomendaras tú y por qué?
5. Los 3 pasos EXACTOS a ejecutar ahora mismo en Madre

Marca ✅ certeza y ⚠️ suposición. Sé directo.

=== FIN PROMPT RONDA 2 ===
```

---

## RESPUESTAS RONDA 2

### GEMINI — Ronda 2
> *pendiente*

### GROK — Ronda 2
> *pendiente*

### MISTRAL — Ronda 2
> *pendiente*

---

## CIERRE FINAL — Perplexity
> *Se completa al final de Ronda 2*

- **Decisión técnica adoptada:**
- **restart:unless-stopped vs systemd service — ganador:**
- **Modelo más preciso en diagnóstico:**
- **Modelo más honesto:**
- **Modelo más útil en práctica:**
- **Acciones inmediatas para Madre:**
- **Documento de acción generado:**
