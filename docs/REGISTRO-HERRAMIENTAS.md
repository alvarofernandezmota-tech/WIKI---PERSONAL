# 🧰 REGISTRO DE HERRAMIENTAS DEL ECOSISTEMA

> Inventario completo de todas las herramientas, etiquetas, rutas y funciones.
> Cada herramienta tiene UNA función. Sin solapamientos.
> Última actualización: 2026-07-03

---

## 📋 TABLA MAESTRA

| Herramienta | Tipo | Función única | Trigger | Etiquetas | Ruta |
|---|---|---|---|---|---|
| clasificador-maestro.sh | Script | Decide destino de cada archivo inbox | push / manual | inbox, clasificacion | scripts/ |
| gestor-estados-inbox.sh | Script | Mueve tareas por 3 estados | push / cron | inbox | scripts/ |
| struct-auditor.sh | Script | Detecta carpetas duplicadas | cron semanal | deuda-tecnica, duplicado | scripts/ |
| ghost-file-detector.sh | Script | Encuentra archivos huérfanos | cron semanal | estructura | scripts/ |
| script-inicio-sesion.sh | Script | Carga contexto al arrancar | manual | — | scripts/ |
| script-cierre-sesion.sh | Script | Snapshot + diary + agentes nocturnos | manual | — | scripts/ |
| script-centinela.sh | Script | Observador global | cron horario | urgente | scripts/ |
| apertura-sesion.sh | Script | Inicio de sesión humano | manual | — | scripts/ |
| cierre-sesion.sh | Script | Cierre de sesión humano | manual | — | scripts/ |
| mcp_server.py | Python | Expone tools a agentes vía socket | servicio | — | proyectos/mcp/ |
| thdora-guardian | Bot GitHub | Audita pushes, mueve a inbox | push | automatizacion | scripts/thdora/ |
| audit-on-push.yml | Action | Audita estructura en cada push | push | estructura | .github/workflows/ |
| diary-writer.yml | Action | Escribe entrada diary | push | — | .github/workflows/ |
| lint-commits.yml | Action | Valida formato de commits | push | — | .github/workflows/ |
| tripwire-repo.yml | Action | Detecta cambios estructurales | push | estructura | .github/workflows/ |
| new-file-bootstrap.yml | Action | Añade cabecera a archivos nuevos | push | — | .github/workflows/ |
| clasificador-maestro.yml | Action | Ejecuta clasificador en cada push | push | inbox, clasificacion | .github/workflows/ |
| gestor-estados-inbox.yml | Action | Gestiona estados del inbox | push / schedule | inbox | .github/workflows/ |
| autonomous-cron.yml | Action | Ciclos autónomos cada X horas | schedule | — | .github/workflows/ |
| health-check.yml | Action | Pulso de servicios Madre | schedule | urgente | .github/workflows/ |
| repo-audit.yml | Action | Auditoría profunda semanal | schedule | deuda-tecnica | .github/workflows/ |
| inbox-cleanup.yml | Action | Limpia inbox si >10 archivos | schedule | inbox | .github/workflows/ |
| mapa-islas-sync.yml | Action | Actualiza MAPA-ISLAS.md | schedule / push | estructura | .github/workflows/ |
| ecosystem-guardian.yml | Action | Vigila comportamiento global | schedule | urgente | .github/workflows/ |
| resumen-diario.yml | Action | Resumen al final del día | schedule | — | .github/workflows/ |
| orquestador-maestro.yml | Action | Coordina otros workflows | schedule | — | .github/workflows/ |

---

## 🏷️ REGISTRO DE ETIQUETAS

| Etiqueta | Cuándo usarla |
|---|---|
| `deuda-tecnica` | Problema conocido sin resolver |
| `automatizacion` | Algo que debería automatizarse |
| `estructura` | Cambio o problema de estructura del repo |
| `agentes` | Relacionado con agentes IA |
| `seguridad` | Problema de seguridad o auditoría |
| `osint` | Relacionado con investigación OSINT |
| `investigacion` | Tema en investigación activa |
| `urgente` | Requiere atención en próxima sesión |
| `duplicado` | Archivo o carpeta duplicada |
| `inbox` | Relacionado con el flujo del inbox |
| `clasificacion` | Error o mejora en el clasificador |
| `centinela` | Detectado por el centinela |
| `islas` | Relacionado con las islas del ecosistema |

---

## 📍 RUTAS CLAVE

```
/inbox/                    → zona de entrada temporal
/inbox/archive/            → archivos expirados o procesados
/diarios/                  → entradas del diario (USAR ESTA)
/diary/                    → DEPRECADA, merge pendiente con diarios/
/docs/                     → documentación permanente
/docs/leyes/               → reglas y leyes del sistema
/docs/tareas/              → tareas pendientes estructuradas
/scripts/                  → scripts ejecutables
/agentes/                  → modelfiles y prompts
/proyectos/                → proyectos activos
/investigacion/            → research en proceso
/osint/                    → USAR ESTA (osint-stack/ deprecada)
/islas/                    → estructura de islas futuras
/.github/workflows/        → todas las Actions
```

---

## 🔄 CONVENCIÓN DE NAMING

```
scripts/         → kebab-case.sh
docs/            → MAYUSCULAS-CON-GUIONES.md (docs permanentes)
                   YYYY-MM-DD-nombre.md (docs fechados)
diarios/         → YYYY-MM-DD.md
agentes/         → nombre-agente.modelfile o nombre-agente.md
.github/         → kebab-case.yml
```
