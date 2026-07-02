---
tags: [tipo/investigacion, estado/activo, hardware, iphone, terminal, ssh, ios]
fecha: 2026-07-02
fuente: investigacion-app-store
---

# 📱 Terminales iOS para iPhone 11 — Investigación completa

> Barrido completo App Store 02-jul-2026.
> Contexto: iPhone 11 → SSH a madre (`100.91.112.32`) vía Tailscale.
> **Recomendación final: Blink Shell** para infraestructura + iSH/a-Shell para herramientas locales.

---

## 🎯 Decisión para este ecosistema

| App | Razón | Prioridad |
|---|---|---|
| **Blink Shell** | Mosh + Tailscale nativo + Secure Enclave + Open Source | ⭐ INSTALAR PRIMERO |
| **iSH Shell** | Alpine Linux local, `apk add nmap/git/python3` | ✅ Complementaria |
| **a-Shell** | Scripts ARM nativos, Python rapido | ✅ Complementaria |
| Termius | Freemium agresivo, llaves en nube terceros | ⚠️ Descartada |
| Secure ShellFish | Buena para archivos, no para sysadmin SSH puro | ⚠️ Opcional |

---

## Bloque 1 — Clientes Remotos (SSH/Mosh)

### Blink Shell (Build & Code) — ⭐ RECOMENDADA

- **Código:** Open Source (GPLv3) — compilable desde Xcode o compra en App Store
- **Mosh nativo** + ControlMaster — cero lag en conexiones móviles inestables
- **Tailscale integrado en la propia app** — acceso directo a `100.91.112.32` sin saltar apps
- **Blink Code:** VS Code remoto integrado (Code Server)
- **Secure Enclave** para llaves criptográficas (ed25519 generada y residente en chip, nunca exportable)
- Lee `.ssh/config` complejo directamente

### Prompt 3 (Panic)

- Propietario, pago único
- Motor renderizado GPU — logs masivos sin congelar iPhone 11
- SSH + Mosh + **Eternal Terminal (ET)** — historial completo si la conexión parpadea
- **YubiKey** hardware + Secure Enclave
- ProxyJump nativo (Jump Hosts / bastions)

### Termius — ⚠️ DESCARTADA para este ecosistema

- Freemium con suscripción agresiva
- **Llaves privadas sincronizadas en nube de terceros** — inaceptable para infra crítica
- Buena UX, pero modelo de seguridad incompatible con enfoque local-first

### Secure ShellFish

- Integra servidores SFTP/SSH en app **Archivos (Files)** de iOS nativa
- Soporte **Atajos (Shortcuts)** — automatizar SSH en background
- Freemium, Secure Enclave para llaves
- Ideal para mover ficheros, no para sysadmin puro

---

## Bloque 2 — Entornos Locales (código en el iPhone)

### iSH Shell — ✅ Complementaria

- Open Source
- Emula x86 vía software → corre **Alpine Linux** real en iOS sandbox
- `apk add nmap git openssh python3 curl` — herramientas de red en local
- Contras: lento en tareas CPU pesadas (emulación software)
- Uso ideal: diagnóstico de red rápido sin SSH

### a-Shell / a-Shell mini — ✅ Complementaria

- Open Source
- Ejecuta ARM nativo del chip A13 (iPhone 11) + WebAssembly
- Python con `pip`, JavaScript, Lua, C — todo nativo, muy rápido
- Uso ideal: scripts pesados, manipulación de datos locales de iOS

---

## Tabla comparativa técnica

| App | Código | Protocolos remotos | Ejecución local | Llaves | Archivos |
|---|---|---|---|---|---|
| **Blink Shell** | Open Source (GPLv3) | SSH, Mosh, WebDAV | Básico + WASM | Secure Enclave / .ssh/config | Files app integrada |
| **Prompt 3** | Propietario (pago) | SSH, Mosh, ET | No (solo Mac) | Secure Enclave / YubiKey | Panic Sync |
| **iSH Shell** | Open Source | SSH vía apk | Alpine Linux x86 | ~/.ssh nativo Linux | Expone sistema Alpine |
| **Termius** | Propietario (suscr.) | SSH, Mosh | No | Nube cifrada / local | SFTP gráfico |
| **a-Shell** | Open Source | No (solo local) | ARM nativo / WASM | No aplica | Directorios iOS |
| **Secure ShellFish** | Propietario | SSH, SFTP | No | Secure Enclave | Files app nativa |

---

## 🔐 Análisis de seguridad — gestión de llaves

- **Blink Shell, Prompt 3, Secure ShellFish:** llaves ed25519 generadas y residentes en **Secure Enclave** del A13. La clave privada nunca sale del chip, nunca es exportable. Opción correcta para infra crítica.
- **Termius:** llaves sincronizadas en nube propia cifradas con clave maestra. Cómodo para equipos, pero expone material criptográfico a servidor externo. **No recomendado para madre/ecosistema yggdrasil.**
- **iSH:** gestiona llaves vía `~/.ssh` en el sistema Alpine emulado. Funcional pero sin protección hardware.

---

## 🗓️ Próximos pasos

- [ ] Instalar **Blink Shell** desde App Store (o compilar vía Xcode)
- [ ] Generar llave ed25519 en Secure Enclave desde Blink
- [ ] Añadir llave pública a madre: `~/.ssh/authorized_keys`
- [ ] Configurar host `madre` en Blink: IP `100.91.112.32`, user `varo`
- [ ] Verificar conexión Tailscale desde iPhone antes de conectar
- [ ] Issue dew #8: configuración paso a paso

---

## 🔗 Referencias

- [[ECOSISTEMA]] — acceso móvil iPhone tabla
- [[hardware/iphone-11]] — ficha hardware iPhone 11
- [[infra/ssh-hardening-madre]] — hardening SSH completado en madre
- Issue dew #8 — configurar Termius/Blink paso a paso (pendiente)
