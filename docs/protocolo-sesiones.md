# Protocolo de Sesiones — yggdrasil-dew

> Documento vivo. Última actualización: 2026-07-03

---

## Regla de oro

**Issue #29 (o el issue activo de sesión) es siempre el punto de entrada.**
Antes de hacer cualquier cosa, abrir ese issue y leerlo.

---

## Apertura de sesión

```bash
# Desde Madre (SSH vía Termius)
cd ~/yggdrasil-dew && bash scripts/inicio-sesion.sh
```

Este script automáticamente:
- `git pull` del repo
- Fija permisos de todos los scripts
- Muestra estado git
- Lista issues abiertos (si `gh` está autenticado)
- Muestra estado de servicios (ollama, ssh, ufw)

---

## Cierre de sesión

```bash
bash scripts/cierre-sesion.sh
```

Este script automáticamente:
- Auto-commit de cambios sin commitear
- Push al repo
- Crea entrada en `sesiones/YYYY-MM-DD-cierre.md`

---

## Labels en GitHub

```bash
# Crear/actualizar todos los labels de una vez
bash scripts/setup-labels.sh
```

Requiere `gh` autenticado. En Madre (Arch Linux):
```bash
sudo pacman -S github-cli
gh auth login
# → GitHub.com → HTTPS → Login with a web browser
# → Copiar código → Abrir github.com/login/device en iPhone
# → Introducir código → Autorizar → Enter en Termius
```

---

## Issues — sistema de seguimiento

| Label | Significado |
|---|---|
| `prioridad-critica` | Bloquea el progreso, hacer ya |
| `prioridad-alta` | Esta semana |
| `fase-X-nombre` | A qué fase del roadmap pertenece |
| `agente-pendiente` | Espera al agente IA |
| `auditoria` | Revisión y alineación |

---

## Registro de sesiones

Cada sesión tiene su archivo en `sesiones/YYYY-MM-DD[-descripcion].md`.
Formato obligatorio: frontmatter YAML + timeline + hecho + pendiente.

---

## Normas de commit

```
tipo(scope): descripcion corta en minusculas
```

Tipos: `feat`, `fix`, `docs`, `chore`, `infra`, `scripts`, `refactor`
Scopes: `sesion`, `thdora`, `ollama`, `scripts`, `docs`, `infra`, `labels`

Ejemplos:
```
docs(sesion): cierre 03-jul-2026
scripts(labels): setup-labels.sh v2
fix(permisos): chmod scripts bc
```

---

## Arquitectura Madre

| Dato | Valor |
|---|---|
| **OS** | Arch Linux |
| **Usuario** | varopc |
| **Hostname** | madre |
| **IP Tailscale** | 100.91.112.32 |
| **Repo** | `~/yggdrasil-dew` |
| **Instalar pkgs** | `sudo pacman -S` o `yay -S` |
| **NO usar** | `apt`, `apt-get` |

---

## Fases del ecosistema

| Fase | Nombre | Script | Estado |
|---|---|---|---|
| 0 | Estructura base | — | ✅ |
| 1 | Seguridad Madre | `03-fase1-seguridad.sh` | ✅ |
| 2 | Batcueva servicios | `04-fase2-start-batcueva.sh` | ✅ |
| 3 | Backup Restic | `07-fase3-restic-backup.sh` | 🟡 verificar |
| 4 | Red / VPN | — | 🔴 pendiente |
| 5 | Docker stack | — | 🔴 pendiente |
| 6 | thdora bot | `08-fase6-thdora-handlers.sh` | 🟡 deuda técnica |
| 7 | Ollama IA local | `05-fase7-ollama-pull.sh` | 🟡 verificar |
| 8 | Agentes IA | — | 🔴 próximo bloque |
| 9 | OSINT stack | `10-fase9-osint-stack.sh` | 🔴 pendiente |
