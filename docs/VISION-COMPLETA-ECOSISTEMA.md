# 🧠 VISIÓN COMPLETA DEL ECOSISTEMA YGGDRASIL-DEW

> Documento vivo. Actualizar tras cada sesión relevante.
> Última actualización: 2026-07-03

---

## ✅ QUÉ ESTÁ CUBIERTO

| Bloque | Estado | Ubicación |
|---|---|---|
| Macro-spec del ecosistema | ✅ | inbox/2026-07-03-MACRO-SPEC-ECOSISTEMA.md |
| Diseño de agentes (alvaro + obsidian) | ✅ | inbox/ |
| MCP server (docker build) | ✅ build / ❌ socket | inbox/2026-07-03-MCP-SERVER-DISEÑO.md |
| Health-agent | ✅ | docker-compose |
| Diario por commit | ✅ básico | .github/workflows/diary-writer.yml |
| Reglas de orquestación | ✅ | inbox/2026-07-03-reglas-orquestacion.md |
| Rutas del ecosistema | ✅ | docs/ |
| Plantillas inbox | ✅ | inbox/PLANTILLA-INBOX.md |
| Estructura base repo | ✅ | README.md |
| Estructura Madre (servicios) | ✅ documentada | docs/ |
| Fases de sesión | ✅ | inbox/2026-07-03-plan-fases-ecosistema.md |
| Automatización mínima (Actions) | ✅ | .github/workflows/ |

---

## ❌ QUÉ FALTA (DEUDA ACTIVA)

| Script/Acción | Prioridad | Descripción |
|---|---|---|
| clasificador-maestro.sh | 🔴 CRÍTICO | Decide dónde va cada archivo del inbox |
| gestor-estados-inbox.sh | 🔴 CRÍTICO | Mueve tareas por los 3 estados |
| struct-auditor.sh | 🟠 ALTA | Detecta carpetas duplicadas, abre issues |
| ghost-file-detector.sh | 🟠 ALTA | Encuentra archivos huérfanos/vacíos |
| script-inicio-sesion.sh | 🟠 ALTA | Carga contexto completo al arrancar |
| script-cierre-sesion.sh | 🟠 ALTA | Snapshot + diary + lanza agentes nocturnos |
| script-centinela.sh | 🟡 MEDIA | Observador global continuo |
| script-actividad-continua.sh | 🟡 MEDIA | Repo nunca parada entre sesiones |
| script-agentes-paralelos.sh | 🟡 MEDIA | Lanza agentes simultáneamente |
| between-sessions.yml | 🟡 MEDIA | Cron nocturno con tareas programadas |
| agent-monitor.yml | 🟡 MEDIA | Centinela que vigila todos los agentes |
| REGISTRO-HERRAMIENTAS.md | 🟡 MEDIA | Inventario completo tools + etiquetas |

---

## 🏛️ PLANTILLA UNIVERSAL DEL ECOSISTEMA

Todos los agentes, scripts y fases siguen esta estructura:

### 1. Inicio de sesión
```
• Cargar PERFIL-ALVARO.md
• Cargar MACRO-SPEC-ECOSISTEMA.md
• Cargar REGISTRO-AGENTES.md
• Cargar REGLAS-AGENTES.md
• Cargar ROADMAP-MASTER.md
• Snapshot del estado (MCP: get_ecosystem_state)
• Activar centinela
• Activar islas
• Activar agentes persistentes
```

### 2. Fases internas
```
1. Fase diagnóstico    → ¿qué hay? ¿qué falta? ¿qué roto?
2. Fase planificación  → prioridad, tiempo estimado, bloqueos
3. Fase acción         → ejecutar, testear, commitear
4. Fase registro       → actualizar docs, issues, REGISTRO
5. Fase diary          → escribir entrada del día
6. Fase cierre         → snapshot + lanzar agentes nocturnos
```

### 3. Cierre de sesión
```
• Guardar snapshot
• Guardar diary
• Activar modo "reposo activo"
• Lanzar agentes de mantenimiento
• Lanzar centinela nocturno
• Lanzar health-agent
• Lanzar obsidian-agent para indexación
• Lanzar alvaro-agent para propuestas de issues
```

---

## 🏝️ ISLAS + CENTINELA

### Islas (clusters de agentes)

| Isla | Función | Estado |
|---|---|---|
| isla-obsidian | Indexación, knowledge base | 🟡 Planificada |
| isla-alvaro | Propuestas, issues, roadmap | 🟡 Planificada |
| isla-health | Monitoreo servicios Madre | ✅ Operativa |
| isla-mcp | Tools, funciones, contexto | ❌ Socket caído |
| isla-secops | Auditoría de seguridad | 🟡 Planificada |
| isla-diary | Diario automático | ✅ Básico |
| isla-roadmap | Seguimiento fases | 🟡 Planificada |
| isla-producción | Solo lectura, no toca prod | 🟡 Planificada |

### Cada isla tiene:
```
• docker-compose.yml propio
• DISEÑO.md
• Reglas propias
• Herramientas propias
• Etiquetas propias
• Scripts de acción propios
```

### Centinela (agente observador global)
```
Vigilar: logs, errores, actividad, agentes, islas,
         MCP, producción, roadmap, commits, diary

Acciones: lanzar acciones automáticas, crear issues,
          activar agentes, mantener actividad continua
```

---

## 📚 FLUJO DIARY POR COMMIT

```
Commit
  └→ Hook / Action (diary-writer.yml)
       └→ diary-agent
            └→ Acción
                 ├→ Nota en /diarios/YYYY-MM-DD.md
                 ├→ Issue si hay anomalía detectada
                 └→ Actualización roadmap si procede
```

---

## 🗂️ FLUJO DEL INBOX

### Los 3 estados de una tarea en inbox

```
📥 NUEVO        → archivo entra al inbox sin clasificar
   ↓
🔄 EN-PROCESO   → clasificador asigna destino + etiquetas
   ↓
✅ PROCESADO    → se mueve a su destino final o archive/
```

### Destinos posibles desde inbox

| Tipo de archivo | Destino |
|---|---|
| Diseño de agente | agentes/ |
| Script ejecutable | scripts/ |
| Documentación permanente | docs/ |
| Investigación activa | investigacion/ |
| Plan de islas | islas/ |
| OSINT/research | osint/ |
| Reglas/leyes del sistema | docs/leyes/ |
| Roadmap/fases | docs/ |
| Tarea pendiente | docs/tareas/ |
| Expirado o duplicado | inbox/archive/ |

---

## 🧰 SERVICIOS EN MADRE (localhost)

| Servicio | Puerto | Estado |
|---|---|---|
| Ollama | :11434 | ✅ |
| n8n | :5678 | ✅ |
| Portainer | :9000 | ✅ |
| Grafana | :3000 | ✅ |
| Uptime Kuma | :3001 | ✅ |
| Qdrant | :6333 | ✅ |
| MCP agent | :8000 / /tmp/mcp.sock | ❌ Socket KO |

---

## 🔍 QUÉ INVESTIGAR

- [ ] Automatización total (zero-touch)
- [ ] Agentes autónomos con memoria persistente (Qdrant)
- [ ] MCP avanzado (tools dinámicas según contexto)
- [ ] Islas inteligentes (auto-escalan según carga)
- [ ] Centinela predictivo (anticipa problemas)
- [ ] Actividad continua 24h real
- [ ] Agentes que se auto-mejoran (feedback loop)
- [ ] Acciones por contexto semántico (no solo por commit)
