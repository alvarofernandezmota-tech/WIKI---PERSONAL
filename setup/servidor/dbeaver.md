# DBeaver — Gestión PostgreSQL

> Última actualización: 13 junio 2026
> Host: Acer — conecta a PostgreSQL en Madre

---

## Estado

| Item | Estado |
|---|---|
| DBeaver en Acer | ⏳ Pendiente instalar |
| PostgreSQL en Madre | ⏳ Pendiente (bootstrap) |
| Conexión configurada | ⏳ Pendiente |

---

## Instalar DBeaver en Acer

```bash
yay -S dbeaver
```

---

## Configurar conexión a Madre

```
Tipo:        PostgreSQL
Host:        100.91.112.32
Puerto:      5432
Base datos:  postgres (o thdora)
Usuario:     varo
Contraseña:  (la que definas)

Túnel SSH:
  Activar:   ✅
  Host SSH:  100.91.112.32
  Usuario:   varo
  Clave:     ~/.ssh/id_ed25519
```

---

## Alternativas comparadas

| Herramienta | Tipo | Por qué DBeaver |
|---|---|---|
| **DBeaver** | Desktop open source | Multi-DB, potente, gratuito |
| TablePlus | Desktop propietario | Descartado — propietario |
| pgAdmin | Web/Desktop | Más pesado, peor UX |
| Beekeeper Studio | Desktop | Buena alternativa si DBeaver falla |

---

_Ver también: [ssh.md](ssh.md) · [vscode.md](vscode.md)_
_Volver al índice: [README.md](README.md)_
