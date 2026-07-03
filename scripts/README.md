# Scripts — yggdrasil-dew

Directorio raíz de scripts del ecosistema. Los scripts están organizados en subdirectorios por dominio (islas).

## Ruta canónica del repo

```
/srv/yggdrasil-dew
```

Si no existe, crea un symlink desde home:
```bash
ln -s /srv/yggdrasil-dew ~/yggdrasil-dew
```

---

## Scripts de sesión

| Script | Uso | Descripción |
|---|---|---|
| `inicio-sesion.sh` | Al arrancar el día | Sincroniza repo, muestra estado |
| `cierre-sesion.sh` | Al terminar sesión | Auto-commit, push, diario |

```bash
# Cierre de sesión:
bash /srv/yggdrasil-dew/scripts/cierre-sesion.sh

# Inicio de sesión:
bash /srv/yggdrasil-dew/scripts/inicio-sesion.sh
```

---

## Scripts de auditoría y mejora del repo

| Script | Uso | Descripción |
|---|---|---|
| `audit-and-migrate.sh` | Auditoría + migración | Analiza y mueve ficheros mal ubicados |
| `repo-research.sh` | Investigación de mejora | Genera reporte en `inbox/` con gaps detectados |

```bash
# Auditoría (siempre dry-run primero):
bash scripts/audit-and-migrate.sh --dry-run
bash scripts/audit-and-migrate.sh

# Research del repo:
bash scripts/repo-research.sh --dry-run  # ver sin escribir
bash scripts/repo-research.sh            # genera inbox/DATE-repo-research.md
```

---

## Subdirectorios (islas)

| Directorio | Contenido |
|---|---|
| `backup/` | Scripts de backup (restic) |
| `ci/` | Scripts de CI/CD |
| `infra/` | Infraestructura Docker / servicios |
| `maintenance/` | Mantenimiento del sistema |
| `osint/` | OSINT tools y workflows |

---

## Scripts numerados (legacy)

Los scripts con prefijo numérico (`01-`, `02-`...) son de las fases de setup inicial. No borrar, pero **no añadir nuevos** con ese patrón — usar nombres descriptivos.

---

## Ver auditoría del estado

Ver [`SCRIPTS-AUDITORIA.md`](./SCRIPTS-AUDITORIA.md) para el inventario completo con estado de cada script.
