---
tags: [operaciones, incidencias, problemas]
fecha-actualizacion: 2026-07-05
---

# ⚠️ Incidencias conocidas

Registro de problemas encontrados y cómo se resolvieron.

## Formato de entrada

```
### INC-XXX — Descripción corta
- Fecha: YYYY-MM-DD
- Síntoma: qué pasaba
- Causa: por qué pasó
- Solución: cómo se resolvió
- Estado: resuelto / abierto
```

---

### INC-001 — Disco duro no detectado
- Fecha: 2026-07
- Síntoma: disco no aparecía en `lsblk`
- Causa: ver [`/hardware/incidencia-disco-duro-no-detectado.md`](../../hardware/incidencia-disco-duro-no-detectado.md)
- Estado: resuelto

### SEC-001 — Puerto 21 FTP abierto en router Digi
- Fecha: 2026-07-01
- Síntoma: puerto 21 expuesto en escaneo externo
- Causa: configuración por defecto del router
- Solución: pendiente — cerrar desde panel router Digi
- Estado: ⚠️ abierto
