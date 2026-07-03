# REGLAS-ISLAS.md — Cuándo separar, cómo documentar, cómo enlazar

> **Principio fundamental:** Cuando algo crece, se independiza. Nunca monolitos.

---

## 1. Cuándo crear una isla

Una isla es un servicio, módulo o agente que se separa del repo principal cuando:

| Señal | Umbral | Acción |
|-------|--------|--------|
| **Tamaño** | > 5 ficheros de código | Crear subdirectorio dedicado |
| **Despliegue** | Necesita su propio Docker | Crear Dockerfile + docker-compose propio |
| **Dependencias** | Requirements.txt diferente | Isla con su propio entorno |
| **Ciclo de vida** | Se actualiza independientemente | Potencial repo separado |
| **Equipo** | Otro agente o humano lo mantiene | Repo separado con README propio |
| **Secretos** | Necesita variables de entorno propias | .env propio, nunca compartido |

---

## 2. Estructura de una isla

Toda isla sigue este patrón:

```
isla-nombre/
├── README.md          ← OBLIGATORIO: qué hace, cómo arranca, qué expone
├── Dockerfile         ← si se Dockeriza
├── docker-compose.yml ← si tiene servicios propios
├── requirements.txt   ← si es Python
├── .env.example       ← template de secretos (NUNCA el .env real)
├── config/            ← configuración (yaml, json)
├── src/ o main.py     ← código
├── tests/             ← evals o smoke tests
└── CHANGELOG.md       ← historial de cambios de la isla
```

---

## 3. Cómo documentar una isla

### README.md de la isla (obligatorio)

```markdown
# Nombre de la isla

## Qué hace
[Una frase. Qué problema resuelve.]

## Cómo arranca
\`\`\`bash
docker compose up -d
\`\`\`

## Qué expone
- Puerto: XXXX
- Endpoint principal: /api/v1/...
- Tools MCP: tool1, tool2

## Dependencias
- Requiere: [lista de servicios que necesita]
- Expone a: [lista de agentes que la usan]

## Variables de entorno (.env)
| Variable | Descripción | Obligatoria |
|----------|-------------|-------------|
| TOKEN | Auth token | Sí |

## Enlace con el ecosistema
- MCP tool: `nombre_tool` en madre-ecosystem MCP
- Documentación completa: [link]
- Issues activos: [link a GitHub label]
```

---

## 4. Cómo enlazar con las herramientas

Cada isla se registra en **tres sitios**:

### 4.1 REGISTRO-ISLAS.md (este repo)
```markdown
| Isla | Path | Docker | MCP tools | Estado |
|------|------|--------|-----------|--------|
| mcp-server | agentes/mcp-server/ | ✅ | 21 tools | Fase 0 |
| health-agent | agentes/health-agent/ | pendiente | 0 | Fase 1 |
```

### 4.2 agentes/mcp-server/config/whitelist.yaml
Añadir las tools que expone la isla a la whitelist del MCP gatekeeper.

### 4.3 ROADMAP-MASTER.md
Añadir la isla como tarea con su fase y estado.

---

## 5. Islas actuales del ecosistema

| Isla | Ubicación | Estado | Docker | MCP |
|------|-----------|--------|--------|-----|
| **mcp-server** | `agentes/mcp-server/` | 🟡 Fase 0 | ✅ Listo | Gen-3 |
| **health-agent** | `agentes/health-agent/` | 🔴 Pendiente | ❌ Falta Dockerfile | Pendiente |
| **ecosystem-snapshot** | `agentes/ecosystem-snapshot/` | 🟡 Parcial | ❌ | ❌ |
| **osint-stack** | `scripts/osint/` | 🟡 Scripts | ❌ | Pendiente |
| **secops** | repo `yggdrasil-secops` | 🟢 Activo | ✅ | Pendiente isla |
| **thdora-bot** | `scripts/thdora/` | 🟢 Activo | ✅ en Madre | Pendiente |

---

## 6. Checklist de creación de isla

```
[ ] README.md creado con estructura estándar
[ ] Dockerfile (si aplica)
[ ] docker-compose.yml (si aplica)
[ ] .env.example (si usa secretos)
[ ] Registrada en REGISTRO-ISLAS.md
[ ] Tools añadidas a whitelist.yaml
[ ] Issue GitHub creado con label isla
[ ] Documentada en ROADMAP-MASTER.md
[ ] Al menos 1 smoke test
```

---

_Documento vivo · Yggdrasil Dew · 2026-07-03_
