---
tags: [inbox, decisiones, sesion, migracion, habitos, tracking, contexto]
fecha: 2026-06-20
hora: 10:26 CEST
destino: yo/habitos.md · inbox/auditoria-personal-repo.md · CONTEXT.md
estado: decisiones-tomadas
---

# 📌 Decisiones y contexto — Sesión 20 jun 2026

> Todo lo que se decidió y comentó en esta sesión.
> Para no perder ningún hilo de contexto.
> Actualizar destinos cuando se procese.

---

## ✅ Decisiones tomadas hoy

### 1. Filosofía del inbox — REGLA SAGRADA
- Todo entra por `inbox/` primero. Sin excepciones.
- Nunca sobreescribir un archivo directamente.
- Flujo: inbox → destino → CONTEXT.md
- Aplica a Perplexity, Grok, Claude, TOKI, ideas propias, resultados de investigación.

### 2. Cada proyecto tiene su propio inbox + diario
- `proyectos/thdora/inbox/` — ✅ creado
- `proyectos/thdora/diario/` — ✅ creado
- `proyectos/thdora/docs/` — ✅ creado
- Patrón: cuando un proyecto tiene suficiente volumen → se le crea inbox + diario propio
- Impresion-3D y ai-toolkit: cuando tengan volumen suficiente

### 3. Corte limpio personal → yggdrasil-dew
- **2025** → se queda en `personal` como histórico intacto
- **2026** → todo nuevo va a `yggdrasil-dew` desde hoy 20 jun
- `personal` no se archiva hasta terminar curso Python (M05→M07)

### 4. ⭐ Migración hábitos y tracking — DECIDIDO
- Tracking diario 2025 → se queda en `personal/01_traking_diario/` (histórico)
- Tracking diario 2026 → `diarios/YYYY-MM-DD.md` en ygg (ya empezó hoy)
- Hábitos semanales → `yo/habitos.md` en ygg ✅ (tabla semanal activa)
- **Cuando haya tiempo:** migrar diarios 2025 a `diarios/2025/` en ygg

### 5. Script RAW para Grok/Claude/Gemini
- Vive en `agentes/AGENT-SCRIPT.md`
- Pegar como primer mensaje en cualquier chat externo
- Perplexity no necesita — tiene MCP GitHub directo
- Grok lo usó hoy → resultados fueron al inbox → flujo validado ✅

### 6. IA en Obsidian — solución definitiva
- No existe plugin oficial Microsoft Copilot open-source
- Solución: **Obsidian-Copilot** (open-source 7k⭐) + Ollama en Madre
- URL: `http://100.91.112.32:11434` · Modelo: `qwen2.5:7b`
- Coste: 0€ · Sin nube · En castellano
- Documentado en [[setup/obsidian]]

### 7. Modelos Ollama con GTX 1060 (6GB VRAM)
- Van bien ahora mismo: `qwen2.5:7b`, `llama3.1:8b`, `mistral:7b`, `deepseek-r1:7b`
- Upgrade RAM 32GB (~45€) → máximo ROI, primero
- Upgrade RTX 3060 12GB (~225€) → desbloquea modelos 14B, segundo
- Diagnóstico pendiente: `nvidia-smi` + `dmidecode` en Madre antes de comprar

### 8. Curso Python — sigue en `personal`
- M05 → siguiente (martes)
- Conceptos aprendidos se documentan en [[formacion/python]]
- El repo `personal` no se toca — solo se lee

### 9. PARA method (propuesta Grok) — NO aplicar ahora
- La numeración de carpetas rompería 40+ wikilinks actuales
- Mantener estructura plana actual (funciona perfectamente)
- Sí adoptar: DASHBOARD.md con Dataview · plugin Tasks · Advanced URI
- Documentado en [[inbox/grok-2026-06-20-segundo-cerebro-pro]]

### 10. Flujo diario del segundo cerebro
```
Durante el día:
  TOKI /inbox (móvil) o inbox/ en Obsidian
        ↓
Al final del día:
  diarios/YYYY-MM-DD.md ← todo confluye aquí
  - tareas completadas (proyectos + formación + vida)
  - inbox procesado
  - qué aprendí
  - hábitos del día
        ↓
Domingo:
  yo/habitos.md ← resumen semanal
  inbox/ ← limpiar + reordenar
  MASTER-PENDIENTES ← revisar prioridades
```

---

## 📥 Notas de inbox creadas hoy

| Nota | Fuente | Destino |
|---|---|---|
| [[inbox/MASTER-PENDIENTES]] | Perplexity | Permanente |
| [[inbox/PENDIENTE-git-pull-y-obsidian]] | Perplexity | Ejecutar hoy |
| [[inbox/modelos-ollama-hardware-madre]] | Perplexity | [[setup/madre]] |
| [[inbox/grok-2026-06-20-investigacion-completa]] | Grok | [[proyectos/thdora]] |
| [[inbox/grok-2026-06-20-segundo-cerebro-pro]] | Grok | [[setup/obsidian]] |
| [[inbox/auditoria-personal-repo]] | Perplexity | Plan migración |
| [[inbox/decisiones-sesion-2026-06-20]] | Perplexity | Esta nota |

---

## 🗂️ Archivos creados / actualizados hoy

### Raíz
- [[HOME]] — índice completo + todos los hipervínculos
- [[CONTEXT]] — estado real 10:12 CEST
- [[AGENT]] — reglas + ecosistema

### agentes/
- [[agentes/AGENT-SCRIPT]] — script RAW Grok/Claude/Gemini

### setup/
- [[setup/madre]] — hardware real + upgrades
- [[setup/obsidian]] — plugins + IA gratuita

### proyectos/
- [[proyectos/thdora]] — estado producción
- [[proyectos/thdora-docs]] — plan milimétrico
- [[proyectos/thdora/inbox/fix-restart-loop]] — bug activo
- [[proyectos/thdora/diario/2026-06-20]] — primera entrada
- [[proyectos/impresion-3d]] — ficha creada
- [[proyectos/ai-toolkit]] — ficha + análisis VRAM

### formacion/
- [[formacion/python]] — procedimiento + M05 siguiente

### diarios/
- [[diarios/2026-06-20]] — diario completo de hoy

### yo/
- [[yo/perfil]] — stack + objetivos 2026
- [[yo/habitos]] — tracking 2026 activo desde hoy

### templates/
- [[templates/diario]] — plantilla Templater completa

---

## ⏳ Pendiente de esta sesión (aún sin hacer)

- [ ] `git pull` en varopc → ver todo en Obsidian
- [ ] Instalar 5 plugins Obsidian → [[setup/obsidian]]
- [ ] SSH Madre → fix bot TOKI → [[proyectos/thdora/inbox/fix-restart-loop]]
- [ ] `ollama pull qwen2.5:7b` en Madre
- [ ] Diagnóstico hardware Madre → [[inbox/modelos-ollama-hardware-madre]]
- [ ] Crear DASHBOARD.md con Dataview
- [ ] M05 Python → martes

---

_Sesión: 20 jun 2026 · 09:00–10:26 CEST · Perplexity vía MCP GitHub_
_Ver: [[diarios/2026-06-20]] · [[CONTEXT]] · [[inbox/MASTER-PENDIENTES]] · [[HOME]]_
