---
tags: [thdora, guardian, pipeline, liga, fase6]
fecha-creacion: 2026-07-03
estado: diseño-aprobado
---

# 🏆 LIGA DE THDORA GUARDIÁN

> Documento maestro del pipeline de automatización del ecosistema.
> Diseñado en sesión 2026-07-03. Parte de Fase 5 + Fase 6.

---

## Visión

Cada archivo que entra al ecosistema es **analizado, clasificado y reportado automáticamente**.
Nadie tiene que recordar nada. El sistema avisa.

---

## El Pipeline Completo

```
┌─────────────────────────────────┐
│  ARCHIVO SUBIDO AL REPO          │
└─────────────────────────────────┘
                ↓
   GitHub Action: audit-on-push.yml
   (se dispara en cada push a main)
                ↓
┌─────────────────────────────────┐
│  inbox/audit-FECHA-RUN.md        │
│  • ruta correcta?                │
│  • frontmatter presente?         │
│  • zombie sospechoso?            │
│  • tamaño OK?                    │
└─────────────────────────────────┘
                ↓
   Thdora Guardian lee inbox/
   handler /inbox en Telegram
                ↓
┌─────────────────────────────────┐
│  📱 TELEGRAM                        │
│  "Subiste config.py — OK"        │
│  "zombie.sh fuera de scripts/"   │
│  "3 archivos en inbox pendientes"│
└─────────────────────────────────┘
```

---

## Cron adicional: sync-estado.yml

Independiente del push. Se ejecuta **cada día a las 02:00 UTC** (04:00 CEST):

- Actualiza `fecha-actualizacion` en ESTADO-SISTEMA.md
- Cuenta archivos pendientes en `inbox/`
- Si inbox tiene >5 archivos sin procesar → alerta en `inbox/ALERTA-INBOX.md`
- Commit automático firmado como `thdora-guardian[bot]`

---

## Componentes del pipeline

| Componente | Ubicación | Estado | Fase |
|---|---|---|---|
| `audit-on-push.yml` | `.github/workflows/` | ✅ Activo | 5 |
| `sync-estado.yml` | `.github/workflows/` | ✅ Activo | 5 |
| `inbox/` carpeta | Raíz repo | ✅ Existe | 3 |
| Handler `/inbox` en thdora | `~/Projects/thdora/` | ⏳ Pendiente | 6 |
| Handler `/estado` en thdora | `~/Projects/thdora/` | ⏳ Pendiente | 6 |
| Bot Telegram envío | thdora Guardián | ⏳ Pendiente Docker | 6 |
| Ema (auditor IA) | `~/Projects/thdora/src/tools/ema/` | ⏳ Diseñado | 7 |

---

## Reglas del pipeline (SINE aplicada)

1. **Un solo punto de salida**: todo resultado va a `inbox/` primero
2. **No ocupar terminales**: GitHub Actions corre en la nube, no en Madre
3. **El bot comenta, no decide**: Thdora avisa, el humano aprueba cambios
4. **Cada script lleva header**: fecha, autor, función, output esperado
5. **Inbox se limpia**: los audits procesados se mueven a `docs/audits/`

---

## Próximos pasos (orden exacto)

```
1. [ ] Confirmar Docker thdora arriba en Madre
2. [ ] Implementar handler /inbox en thdora
3. [ ] Implementar handler /estado en thdora  
4. [ ] Test end-to-end: push archivo → inbox → Telegram
5. [ ] Integrar Ema como lector de inbox (Fase 7)
```

---

_Creado: 2026-07-03 06:48 CEST — diseñado en sesión Perplexity MCP_
_Próxima sesión: implementar handlers thdora para completar el loop_
