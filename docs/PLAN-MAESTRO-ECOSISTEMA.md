# PLAN MAESTRO — ECOSISTEMA YGGDRASIL

> Documento vivo. Última actualización: 2026-07-03  
> Regla: **Un solo punto de entrada. Todo conectado. Nada disperso.**

---

## ESTADO ACTUAL — 7:42 CEST 2026-07-03

| Componente | Estado | Notas |
|---|---|---|
| thdora (bot principal) | 🟡 Docker corriendo | Issues #10 y #12 pendientes |
| TOKI-Guardian | 🔴 En construcción | Fase 6a |
| TOKI-DEW | 🔴 Pendiente | Issue yggdrasil-dew #12 |
| Ollama (Madre) | 🟡 Descargando | Issue #25 |
| n8n | 🔴 Pendiente | Fase 6b |
| GitHub Action Auditor | 🔴 No existe | **NUEVO — ver sección abajo** |

---

## ARQUITECTURA DE BOTS — DIVISIÓN DE RESPONSABILIDADES

> Regla SINE: cada bot tiene UN dominio. No se mezclan. Cuando el ecosistema crezca se unen en cadenas, nunca en un bot monolítico.

### Bot 1 — TOKI-Guardian (puerto :8000)
**Dominio: Infraestructura física de Madre**
- Alertas Wazuh / seguridad
- Estado servicios Docker
- SSH events
- `/status` → servicios activos
- `/docker` → containers
- `/wazuh` → alertas recientes
- `/reboot` → reinicio controlado

### Bot 2 — TOKI-DEW (puerto :8001)
**Dominio: Gestión del repo yggdrasil-dew**  
_(Issue #12 yggdrasil-dew — pendiente de implementar)_
- `/inbox` → count inbox/
- `/pendientes` → resumen MASTER-PENDIENTES.md
- `/git log` → últimos 5 commits
- `/issues` → issues abiertos
- `/audit` → ejecuta audit-repo.sh
- `/context` → resumen CONTEXT.md
- `/fases` → estado fases actual

### Bot 3 — TOKI-Personal (puerto :8002)
**Dominio: Productividad personal**  
_(Fase futura — no abrir hasta que los 2 anteriores estén estables)_
- Recordatorios
- Notas rápidas → inbox/
- Resumen diario
- Gestión agenda

### Cadena futura (cuando los 3 bots estén estables)
```
Usuario (Telegram)
    ↓
ROUTER-BOT (un único punto de entrada)
    ├── /infra* → TOKI-Guardian
    ├── /repo*  → TOKI-DEW
    └── /yo*    → TOKI-Personal
```
**Principio: hoy dividimos, mañana encadenamos. Nunca al revés.**

---

## FASES DEL ECOSISTEMA — ESTADO REAL

| Fase | Nombre | Estado | Bloqueado por |
|---|---|---|---|
| Fase 0 | Setup base repo | ✅ Completa | — |
| Fase 1 | Documentación base | ✅ Completa | — |
| Fase 2 | Scripts sesión | ✅ Completa | — |
| Fase 3 | Estructura docs | 🟡 90% | inbox/ pendiente migrar |
| Fase 4 | Governance auditoría | 🟡 70% | issue #10 |
| Fase 5 | thdora estable | 🔴 Bloqueada | thdora #12 + #10 |
| Fase 6a | TOKI-Guardian handlers | 🔴 En curso | Docker thdora |
| Fase 6b | n8n hardened | 🔴 Pendiente | Fase 6a |
| Fase 6c | TOKI-DEW | 🔴 Pendiente | Fase 6a |
| Fase 6d | Gemini+DeepSeek vía n8n | 🔴 Pendiente | Fase 6b |
| Fase 7 | Ollama local (IA) | 🟡 Descargando | Modelos ~15GB |
| Fase 8 | Servidor MCP propio | 🔴 Pendiente | Fase 7 |

**Cuello de botella real:** thdora #12 y #10 bloquean todo a partir de Fase 5.

---

## GITHUB ACTION AUDITOR — SPEC COMPLETA

> Responde a: "un bot/script/GitHub Action que analice a nivel profesional y sea un experto en alineamiento de proyectos"

### Qué hace

Un workflow de GitHub Actions que se ejecuta:
- En cada push a `main`
- Cada noche a las 03:00 CEST (schedule)
- Manual (`workflow_dispatch`)

### Lo que audita (5 categorías)

**1. Componentes faltantes**
- ¿Existe `README.md` en cada directorio con contenido?
- ¿Existe `.github/workflows/` con al menos 1 workflow?
- ¿Existe `CONVENCIONES.md`, `HOME.md`, `MASTER-PENDIENTES.md`?
- ¿Existe `scripts/maintenance/new-session.sh`?

**2. Issues huérfanos**
- Issues abiertos sin label → crea comentario automático
- Issues sin milestone asignado a una fase → alerta
- PRs abiertos >7 días sin actividad → notificación

**3. inbox/ acumulada**
- Cuenta ficheros en `inbox/`
- Si >10 → abre issue automático "⚠️ inbox acumulada: N ficheros pendientes"
- Si >20 → label `p0-critico`

**4. Consistencia del ecosistema**
- Detecta ficheros en raíz que deberían estar en `docs/` (patrón `*.md` en raíz ≠ whitelist)
- Detecta directorios duplicados (ej: `cli-tools/` + `tools/` + `scripts/`)
- Verifica que `HOME.md` menciona todos los directorios raíz existentes

**5. Deuda técnica**
- Busca `TODO:`, `FIXME:`, `HACK:`, `XXX:` en archivos `.py`, `.sh`, `.md`
- Genera reporte → `docs/AUDIT-DEUDA-FECHA.md`
- Si encuentra >5 TODOs nuevos → abre issue automático

### Salida del auditor

Todo pendiente que detecte → se convierte en:
1. **Issue GitHub** con label correspondiente + fase
2. **Entrada en `inbox/YYYY-MM-DD-audit-findings.md`**
3. **Comentario en PR** si el fallo viene de un commit reciente

### Archivo a crear
`.github/workflows/ecosystem-auditor.yml`

```yaml
# Pendiente de implementar — issue yggdrasil-dew #11 relacionado
name: Ecosystem Auditor
on:
  push:
    branches: [main]
  schedule:
    - cron: '0 1 * * *'  # 03:00 CEST
  workflow_dispatch:

jobs:
  audit:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run ecosystem audit
        run: python scripts/ecosystem_auditor.py
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      - name: Create issues from findings
        if: steps.audit.outputs.findings != ''
        uses: peter-evans/create-issue-from-file@v5
```

---

## MICROSERVICIOS — ¿SÍ O NO?

**Respuesta corta: NO todavía.**

Los microservicios tienen sentido cuando:
- Tienes >3 componentes con tráfico independiente
- Necesitas escalar partes por separado
- El equipo es >1 persona trabajando en paralelo

**Ahora mismo tienes:**
- 1 persona
- 1 máquina (Madre)
- Bots con tráfico mínimo (uso personal)

**Arquitectura correcta para la fase actual:**
```
Madre (1 máquina)
├── thdora (FastAPI, puerto 8000) — Docker
├── TOKI-DEW (aiogram, puerto 8001) — Docker
└── TOKI-Guardian (aiogram, puerto 8002) — Docker
```

Cada bot = 1 contenedor Docker. Esto **ya es** separación de responsabilidades sin la complejidad de microservicios reales (Kubernetes, service mesh, etc.).

**Microservicios reales: cuando Fase 8 esté completa y el sistema tenga >100 req/día sostenido.**

---

## ORDEN DE TRABAJO — PRÓXIMAS TAREAS

### HOY (Fase 5 — desbloquear thdora)
1. `thdora#12` — eliminar `src/bot/agents/` + archivos LLM zombie (**terminal necesaria**)
2. `thdora#10` — fix timeout config (**ya tiene spec de 3 líneas**)
3. Verificar `ollama list` una vez Docker libre

### ESTA SEMANA (Fase 6a)
4. `scripts/ecosystem_auditor.py` — implementar el auditor
5. `.github/workflows/ecosystem-auditor.yml` — activar
6. TOKI-Guardian handlers básicos `/status`, `/docker`

### PRÓXIMA SEMANA (Fase 6b+)
7. n8n hardened en Madre
8. TOKI-DEW comandos repo
9. Profile README GitHub (#18)

---

## REGLA DE ORO — FLUJO DE PENDIENTES

```
Algo queda pendiente
    ↓
¿Es accionable HOY? → SÍ → MASTER-PENDIENTES.md
¿Es accionable esta semana? → SÍ → Issue GitHub con fase+label
¿Es una idea/investigación? → inbox/YYYY-MM-DD-nombre.md
¿Es un fallo detectado automáticamente? → GitHub Action lo convierte en issue
¿Es un fallo crítico en producción? → p0-critico label + Telegram alert
```

**Todo tiene un destino. Nada se pierde en el chat.**

---

_Creado: 2026-07-03 — Perplexity vía MCP_  
_Próxima revisión: al completar Fase 5 (thdora deuda técnica)_
