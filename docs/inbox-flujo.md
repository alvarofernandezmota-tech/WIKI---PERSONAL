# Flujo de entrada inbox — yggdrasil-dew

## El acuerdo: un único punto de entrada

Todo lo que quieras meter en el ecosistema (notas, docs, scripts, sesiones, investigación) pasa por `inbox/drop/`.
Desde ahí, el ecosistema lo lleva a donde tiene que ir.

## Flujo completo

```
TÚ                        SCRIPTS                    GITHUB ACTIONS

[copia archivo]           
      ↓
inbox/drop/archivo.md
      ↓
bash scripts/inbox-commit.sh "descripción"
      ↓
   git push
                               ↓
               inbox-clasificador.sh (detecta destino)
                               ↓
       diarios/ | sesiones/ | osint-stack/ | infra/
       investigacion/ | formacion/ | proyectos/ | docs/
       scripts/ | templates/ | inbox/sin-clasificar/
                               ↓
               file-arrival-guardian.sh valida estructura
                               ↓
                  ✅ todo en su sitio
```

## Cómo usarlo desde la terminal

### Paso 1: copiar el archivo a drop/

```bash
cp /ruta/de/tu/archivo.md ~/yggdrasil-dew/inbox/drop/
# o directamente desde donde estés:
cp mi-nota.md inbox/drop/
```

### Paso 2: commitear con un comando

```bash
bash scripts/inbox-commit.sh "descripción de lo que entra"
```

Eso hace automáticamente:
- `git add inbox/drop/`
- Genera nota de entrada en `inbox/_meta/drop-entrada-TIMESTAMP.md`
- `git commit`
- `git push origin main`

### Paso 3: el clasificador se activa (o lo lanzas tú)

Después del push, GitHub Actions lanza `inbox-clasificador.sh` que mueve el archivo al destino correcto según estas reglas:

| Nombre del archivo contiene | Destino |
|---|---|
| Fecha `YYYY-MM-DD` | `diarios/` |
| `sesion`, `cierre`, `session` | `sesiones/` |
| `osint` | `osint-stack/` |
| `infra`, `docker`, `service` | `infra/` |
| `investigacion`, `research`, `grok` | `investigacion/` |
| `formacion`, `curso`, `tutorial` | `formacion/` |
| `proyecto`, `project` | `proyectos/` |
| `hardware`, `disco`, `ssd`, `hdd` | `hardware/` |
| `doc`, `docs`, `readme` | `docs/` |
| `template`, `plantilla` | `templates/` |
| Extensión `.sh` | `scripts/` (revisión manual) |
| Extensión `.py` | `tools/` |
| Extensión `.json` | `core/` |
| Extensión `.yml/.yaml` | `.github/workflows/` |
| Todo lo demás | `inbox/sin-clasificar/` |

### Modo dry-run (ver dónde iría sin mover nada)

```bash
bash scripts/inbox-clasificador.sh --dry-run
```

## Si el clasificador no acierta el destino

El archivo va a `inbox/sin-clasificar/`. Desde ahí:

```bash
# Moverlo manualmente al destino correcto
git mv inbox/sin-clasificar/mi-archivo.md diarios/
git commit -m "fix(inbox): mover mi-archivo.md a diarios/"
git push origin main
```

## Comandos rápidos de referencia

```bash
# Meter un archivo en el ecosistema
cp mi-archivo.md inbox/drop/
bash scripts/inbox-commit.sh "descripción"

# Ver dónde irían los archivos actuales sin moverlos
bash scripts/inbox-clasificador.sh --dry-run

# Clasificar manualmente (sin esperar Actions)
bash scripts/inbox-clasificador.sh
git add -A
git commit -m "inbox: clasificación manual"
git push origin main

# Auditar estructura después
bash scripts/orquestador-unico.sh audit
```

## Estructura de inbox/

```
inbox/
├── drop/              ← ZONA DE ATERRIZAJE: dejas tus archivos aquí
├── sesiones/          ← logs y cierres de sesión (antes de ir a diarios/)
├── sin-clasificar/    ← lo que el clasificador no supo dónde meter
└── _meta/             ← reportes automáticos (arrival-report, clasificador, orquestador)
```
