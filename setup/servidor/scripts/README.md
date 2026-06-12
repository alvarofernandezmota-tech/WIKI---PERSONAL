# Scripts — Automatización

> Scripts ejecutables para setup y mantenimiento del servidor.
> Última actualización: 13 junio 2026

---

| Script | Qué hace | Cuándo ejecutar |
|---|---|---|
| [bootstrap-madre.sh](bootstrap-madre.sh) | Instalación completa de Madre (6 fases) | Primera vez, tras Arch limpio |

---

## Cómo ejecutar bootstrap desde Acer

Una vez `sshd` activo en Madre:

```bash
bash <(curl -s https://raw.githubusercontent.com/alvarofernandezmota-tech/personal-v2/main/setup/servidor/scripts/bootstrap-madre.sh)
```

---

_Ver: [arquitectura.md](../arquitectura.md) · [plan-maestro.md](../plan-maestro.md)_
