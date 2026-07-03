# 🤖 Decisión: ¿Automatizaciones ahora o después?

**Fecha análisis:** 03-Jul-2026  
**Estado del ecosistema:** ~60% construido

---

## Lo que YA está automatizado (no tocar)

| Automatización | Dónde | Estado |
|---|---|---|
| Guardian nocturno | ygg Action | ✅ Activo — abre issues si hay zombies |
| Islas health check | ygg Action | ✅ Activo — audita maestros cada día |
| Mapa sync | ygg Action | ✅ Activo — actualiza timestamp auto |
| Lint commits | ygg Action | ✅ Activo |
| Orquestador maestro | ygg Action | ✅ Activo |
| new-session.sh | Script local | ✅ Funcional en madre |

---

## Lo que FALTA para poder automatizar más

### Bloqueantes duros (sin esto no se puede avanzar)

1. **SSH key de madre en GitHub** — sin esto, git pull falla en madre
2. **gh CLI autenticado en madre** — sin esto, las Actions no pueden crear issues desde madre
3. **thdora funcional** — issue #12 y #10 sin cerrar = código inestable

### Bloqueantes blandos (se puede avanzar pero con riesgo)

4. **batcueva sin crear** — sin backup de madre, si falla madre se pierde todo
5. **osint-stack sin definir** — carpetas duplicadas generan confusión en Actions

---

## Veredicto

```
¿Puedo lanzar automatizaciones complejas ahora?

RESPUESTA: NO todavía. Faltan 2 fixes bloqueantes.

¿Puedo usar las automatizaciones que ya existen?

RESPUESTA: SÍ. Las 6 Actions activas funcionan.

¿Cuándo empezar automatizaciones nuevas?

RESPUESTA: Después de cerrar issue #12 y #10 en thdora
            y arreglar SSH key de madre.
```

---

## Orden recomendado S21 → S22

```
S21 (hoy mismo):
  1. fix: SSH key madre → GitHub
  2. fix: gh auth login en madre
  3. close: thdora #12 (zombie)
  4. close: thdora #10 (timeout)

S22 (próxima sesión):
  5. create: batcueva repo + docker-compose madre
  6. merge: osint-stack en ygg (eliminar duplicado)
  7. automatización: daily-report Telegram desde thdora

S23:
  8. automatización: sync bidireccional ygg ↔ thdora
  9. automatización: backup nocturno madre → batcueva
```

---

*Documento vivo — actualizar al cerrar cada sesión.*
