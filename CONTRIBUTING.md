# 🤝 CONTRIBUTING — yggdrasil-dew

> Este repo es un proyecto personal de infraestructura y segundo cerebro.
> Las contribuciones externas no están abiertas, pero este fichero sirve como
> guía de trabajo para el propio Álvaro y para agentes IA.

---

## Antes de empezar

Lee en este orden:

1. [`AGENT.md`](./AGENT.md) — contexto del ecosistema
2. [`CONTEXT.md`](./CONTEXT.md) — estado actual
3. [`CONVENCIONES.md`](./CONVENCIONES.md) — normas de estructura y commits
4. [`MASTER-PENDIENTES.md`](./MASTER-PENDIENTES.md) — qué está pendiente

---

## Flujo de trabajo

### Para cualquier cambio

```bash
# 1. Rama descriptiva
git checkout -b feat/nombre-corto

# 2. Hacer los cambios
# 3. Commit semántico
git commit -m "feat(scope): descripción imperativa"

# 4. Push y PR
git push origin feat/nombre-corto
```

### Excepciones que van directo a main

- Diarios de sesión (`docs/diarios/`)
- Cierre de sesión (CONTEXT.md + diario)
- Hotfixes críticos documentados

---

## Qué NUNCA commitear

```
❌  .env o cualquier fichero con secrets
❌  Claves SSH, tokens, certificados
❌  APKs, binarios, ISOs
❌  .obsidian/, .vscode/ (configs privadas de IDE)
❌  Ficheros con contraseñas en texto plano
❌  Logs con datos sensibles
```

Ver `.gitignore` para la lista completa.

---

## Estructura de commits

```
feat(scope):     nueva funcionalidad
fix(scope):      corrección
docs(scope):     solo documentación
chore(scope):    mantenimiento
infra(scope):    infraestructura
security(scope): seguridad
refactor(scope): reestructuración
ci(scope):       GitHub Actions
```

Ejemplos reales del proyecto:
```
docs(diarios): cierre sesion 02-jul noche
infra(madre): configurar hostapd r8852be
security(ssh): eliminar auth por password
chore(repo): eliminar binarios trackeados
feat(wazuh): desplegar agente en Madre
```

---

## Issues y etiquetas

Usa las etiquetas definidas en `CONVENCIONES.md` §9 para categorizar correctamente.
Siempre asigna `needs-terminal` o `mobile-ok` para saber desde dónde se puede ejecutar.

---

_Este repo sigue el estándar de [Conventional Commits](https://www.conventionalcommits.org/)_
