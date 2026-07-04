# 📐 Convenciones del Ecosistema

> Reglas que aplican a TODO. Si algo no sigue estas convenciones, hay que corregirlo.

---

## Nomenclatura de archivos

```
# Documentos wiki
kebab-case.md          ✅
NOMBRE_MAYUS.md        ❌ (solo para archivos raíz legacy)

# Scripts
nombre-accion.sh       ✅
nombreAccion.sh        ❌

# Diarios / sesiones
cierre-YYYYMMDDTHHmmss.md
sesion-YYYYMMDDTHHmmss.md
```

---

## Commits de Git

```
# Formato
<emoji> <área>: <qué se hizo>

# Ejemplos
📝 wiki: documenta configuración SSH de Madre
🐛 infra: corrige puerto Nginx mal configurado
✨ agentes: añade capacidad de lectura de calendario a THDORA
🗑️ limpieza: elimina archivos obsoletos de raíz

# Emojis estándar
📝 documentación    ✨ nueva funcionalidad
🐛 bug fix          🔒 seguridad
🗑️ eliminar         🚀 despliegue
⚙️ configuración    📦 dependencias
```

---

## Estructura de carpetas

```
wiki/           → documentación organizada (AQUÍ vive el conocimiento)
infra/          → código/config de infraestructura
proyectos/      → carpetas de proyectos activos
agentes/        → código de THDORA y otros agentes
scripts/        → scripts de automatización
diarios/        → cierres de sesión automáticos
_archivo/       → material obsoleto, nunca se borra, se archiva
```
