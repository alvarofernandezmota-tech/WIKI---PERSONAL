---
tipo: arquitectura-propuesta
author: Perplexity-MCP <alvarofernandezmota@gmail.com>
creado: 2026-07-03 01:12 CEST
actualizado: 2026-07-03 01:12 CEST
ruta: inbox/2026-07-03-sistema-logs-guardian.md
tags: [guardian, telegram, logs, auditoria, persistencia]
status: pendiente-procesar
destino: docs/agentes/ + docs/arquitectura/
---

# Sistema de Logs Persistentes — Guardian + Auditorías

> Problema identificado: los logs de Telegram del bot guardián se pierden
> y las auditorías no tienen un lugar canónico donde vivir.
> Esta propuesta resuelve ambos problemas.

---

## El problema actual

1. **Alertas Telegram de TOKI-GUARDIAN** → llegan al chat → nadie las revisa → se pierden
2. **Auditorías de repo** → se hacen a mano → no quedan documentadas → no hay histórico
3. **No hay sistema de seguimiento** → no sabes si un problema se resolvió o sigue activo

---

## Propuesta: docs/logs/ como directorio canónico

```
docs/
  logs/
    guardian/
      2026-07-03.md    ← alertas del día de TOKI-GUARDIAN
      2026-07-02.md
    auditoria-repo/
      2026-07-03.md    ← resultado de repo-audit.py del día
      2026-07-02.md
    README.md          ← explica el sistema de logs
```

---

## Flujo de logs automático

```
TOKI-GUARDIAN detecta alerta
        ↓
Envía a Telegram (como ahora)
        ↓                          ← NUEVO
También hace commit en             ←
docs/logs/guardian/YYYY-MM-DD.md  ←
        ↓
Perplexity/repo-audit puede leer
los logs históricos para detectar
patrones repetidos
```

---

## Formato de log diario

```markdown
# Guardian Log — 2026-07-03

## Alertas del día

| Hora | Servicio | Nivel | Mensaje | Resuelto |
|---|---|---|---|---|
| 09:14 | Docker/ollama | ⚠️ WARN | Container reiniciado | ✅ auto |
| 14:32 | Disco /data | 🔴 CRIT | 95% uso disco | ⏳ pendiente |
| 23:00 | repo-audit | ⚠️ WARN | .obsidian/ en git | ⏳ pendiente |

## Resumen
- Total alertas: 3
- Resueltas: 1
- Pendientes: 2
- Issues creados: #21, #22
```

---

## Implementación por fases

| Fase | Qué | Cómo | Cuándo |
|---|---|---|---|
| **A — ahora** | Logs manuales de auditoría | Yo (Perplexity-MCP) creo fichero tras cada auditoría | Inmediato |
| **B — Fase 5** | repo-audit.py genera log automático | Script Python escribe en docs/logs/ | Fase 5 |
| **C — Fase 7** | TOKI-GUARDIAN commit logs al repo | Bot Python con MCP GitHub | Fase 7 |
| **D — Fase 7** | Análisis de patrones en logs | LLM lee histórico + detecta tendencias | Fase 7 |

---

## Skill LLM externo — Análisis de repos de referencia

> Preguntas: ¿Es posible que el bot analice repos externos para mejorar el nuestro?

**Respuesta: SÍ, totalmente posible.** Arquitectura:

```
Perplexity-MCP busca:
  "homelab knowledge base repo structure GitHub 2026"
  "PKM second brain GitHub best practices"
  "devops monorepo structure conventions"
        ↓
Extrae patrones:
  - Estructura de carpetas más común
  - Convenciones de naming
  - Ficheros de raíz estándar
  - Sistemas de documentación
        ↓
Compara con yggdrasil-dew:
  - "Tienes X que hacen Y repos similares"
  - "Te falta Z que tienen el 80% de repos similares"
  - "Tu carpeta mocs/ es inusual, considera X"
        ↓
Genera PR o issue con propuestas
```

### Repos de referencia a analizar

- `nickvdyck/homelab` — homelab docs
- `xcad2k/homelabos` — homelab completo
- `awesome-selfhosted/awesome-selfhosted` — estructura docs
- Repos con topic `second-brain` o `pkm` en GitHub

### Cuándo ejecutar
- Manual: cuando quieras una revisión externa
- Cron mensual: comparativa automática
- Trigger: cuando añades carpeta nueva al repo

---

## Pendientes (para issues)

- [ ] Crear `docs/logs/README.md` explicando el sistema
- [ ] Crear `docs/logs/guardian/` y `docs/logs/auditoria-repo/`
- [ ] Añadir al script repo-audit.py: escribir log en docs/logs/auditoria-repo/
- [ ] Documentar en CONVENCIONES.md: sección sobre logs
- [ ] Issue: feat(guardian): TOKI-GUARDIAN hace commit de logs al repo (Fase 7)
- [ ] Issue: feat(audit): skill análisis repos externos (Fase 7)
