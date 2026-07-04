# Estado del sistema

> Foto del estado real del ecosistema. Se actualiza manualmente cuando cambia algo importante.

---

## Estado general — 2026-07-05

| Capa | Estado | Notas |
|---|---|---|
| **yggdrasil-dew** (este repo) | ✅ Activo | Reorganización en curso |
| **Madre** (servidor) | 🟡 Activo | Documentación pendiente |
| **Ollama / IA local** | 🟡 En construcción | Stack creado, configuring |
| **THDORA** (bot) | 🟡 En construcción | Repo activo, pendiente despliegue |
| **OSINT stack** | 🟡 En construcción | Repo creado |
| **yggdrasil-secops** | 🟡 En construcción | Canary tokens, tripwires |
| **local-brain** (RAG) | 🟡 En construcción | Repo creado |
| **Automatizaciones (GitHub Actions)** | ⏸️ Pausadas | 33 workflows eliminados. Sin infra real. |

---

## Leyenda

| Icono | Significado |
|---|---|
| ✅ | Funcionando y estable |
| 🟡 | Existe pero en construcción / configuración |
| 🔴 | No existe todavía |
| ⏸️ | Pausado intencionalmente |
| ⚠️ | Requiere atención |

---

## Alertas activas

- ⚠️ **Repo `personal` es público** — contiene información personal (finanzas, salud, diario). Considerar hacerlo privado.
- ⚠️ **47 issues abiertos** en `yggdrasil-dew` — revisar y cerrar los que ya no aplican.
- ⚠️ **33 archivos `.yml` de workflows** todavía en `.github/workflows/` — borrar.

---

## Próximas acciones prioritarias

1. [ ] Hacer privado el repo `personal`
2. [ ] Completar `docs/hardware.md` con datos reales de Madre
3. [ ] Documentar servicios Docker activos en Madre
4. [ ] Borrar carpetas vacías del repo (ver `inbox/2026-07-04-sesion-organizacion.md`)
5. [ ] Mover archivos sueltos de la raíz a `docs/` o `_archivo/`
6. [ ] Limpiar los 47 issues abiertos

---

*Última actualización: 2026-07-05*
