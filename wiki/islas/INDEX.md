---
tipo: canon
author: Alvaro Fernandez Mota
creado: 2026-07-09
actualizado: 2026-07-13T10:13:00+02:00
ruta: wiki/islas/INDEX.md
tags: [canon, indice, islas, wiki]
status: vigente
---

# Índice de Islas — Wiki Yggdrasil

> Mapa completo de todo el conocimiento documentado del ecosistema.
> 25 islas · 19 repos · Auditado: 2026-07-13

---

## 🇪🇸 Ecosistema y arquitectura

| Isla | Archivo | Repo asociado | Estado |
|------|---------|---------------|--------|
| Ecosistema general | [ecosistema.md](ecosistema.md) | yggdrasil-dew | ✅ |
| Arquitectura C4 | → [ARQUITECTURA-C4.md](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/docs/canon/ARQUITECTURA-C4.md) | yggdrasil-dew | ✅ |
| Filosofia y principios | [filosofia.md](filosofia.md) | yggdrasil-wiki | ✅ |
| Normas del tridente | → [NORMAS-TRIDENTE.md](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/docs/canon/NORMAS-TRIDENTE.md) | yggdrasil-dew | ✅ |

---

## 🖥️ Infraestructura y hardware

| Isla | Archivo | Repo asociado | Estado |
|------|---------|---------------|--------|
| Madre (servidor principal) | [madre.md](madre.md) | madre-config | ✅ |
| Infra general | [infra.md](infra.md) | madre-config | ✅ |
| Scripts operativos | [scripts.md](scripts.md) | yggdrasil-scripts | ✅ Nuevo |
| Acer (laptop Arch/Hyprland) | [acer.md](acer.md) | acer-config | 🟡 Sin auditar |
| Thea (iPhone) | [thea.md](thea.md) | — | 🟡 Parcial |

---

## 🤖 IA y automatización

| Isla | Archivo | Repo asociado | Estado |
|------|---------|---------------|--------|
| THDORA (bot IA personal) | [thdora.md](thdora.md) | THDORA-PERSONAL | 🔴 Caído #44 #45 |
| Ollama Stack (LLM local) | [ollama-stack.md](ollama-stack.md) | ollama-stack | 🟡 Sin auditar |
| IA Local (RAG/cerebro) | [ia-local.md](ia-local.md) | local-brain | 🟡 Sin auditar |
| Investigación IA (PoCs) | [investigacion-ia.md](investigacion-ia.md) | investigacion-ia | 🟡 Sin auditar |
| Cerebro / conocimiento | [cerebro.md](cerebro.md) | local-brain | 🟡 Fusionar con ia-local |
| Orquestador (n8n+THDORA+MCP)| [orquestador.md](orquestador.md) | THDORA-PERSONAL | 🟡 Parcial |
| MCP (protocolo agentes) | [mcp.md](mcp.md) | — | ✅ |

---

## 🔒 Seguridad

| Isla | Archivo | Repo asociado | Estado |
|------|---------|---------------|--------|
| Seguridad (blue team) | [seguridad.md](seguridad.md) | yggdrasil-secops | 🟡 Bot caído |
| OSINT | [osint.md](osint.md) | osint-stack | 🟡 Sin auditar |

---

## 💻 Desarrollo

| Isla | Archivo | Repo asociado | Estado |
|------|---------|---------------|--------|
| Dev Labs (sandbox) | [dev-labs.md](dev-labs.md) | dev-labs | 🟡 Sin auditar |
| Labs generales | [labs.md](labs.md) | dev-labs | ⚠️ Solapamiento con dev-labs — unificar |
| Conocimiento técnico | [conocimiento.md](conocimiento.md) | formacion-tech | ⚠️ Solapamiento con formacion — revisar |
| Formación | [formacion.md](formacion.md) | formacion-tech | 🟡 Stub — necesita input Alvaro |

---

## 🌱 Vida personal

| Isla | Archivo | Repo asociado | Estado |
|------|---------|---------------|--------|
| Vida personal general | [vida.md](vida.md) | VIDAPERSONAL | ✅ |
| VIDAPERSONAL (estructura) | [VIDAPERSONAL.md](VIDAPERSONAL.md) | VIDAPERSONAL | ✅ |
| Impresión 3D | [impresion3d.md](impresion3d.md) | impresion-3d | 🟡 Stub — necesita input Alvaro |

---

## ⚠️ Desalineaciones detectadas (arreglar)

| Problema | Isla(s) afectada | Acción |
|---------|-----------------|--------|
| **Solapamiento** labs.md ≡ dev-labs.md | labs.md + dev-labs.md | Unificar en dev-labs.md · archivar labs.md |
| **Solapamiento** cerebro.md ≈ ia-local.md | cerebro.md + ia-local.md | Unificar en ia-local.md · archivar cerebro.md |
| **Solapamiento** conocimiento.md ≈ formacion.md | conocimiento.md + formacion.md | Revisar y unificar o separar por scope |
| **Stub** formacion.md (776 bytes) | formacion.md | Necesita input Alvaro (#56 DEW) |
| **Stub** impresion3d.md (963 bytes) | impresion3d.md | Necesita input Alvaro (#56 DEW) |

---

## Números clave — 2026-07-13 10:13 CEST

| Métrica | Valor |
|---------|-------|
| Islas totales | 25 |
| Islas completas (✅) | 11 |
| Islas parciales (🟡) | 11 |
| Islas stub (⚪) | 3 |
| Solapamientos a resolver | 3 pares |
| Repos sin isla propia | 0 (todos cubiertos) |
| Repos sin auditar terminal | 6 |

---

_Actualizado: 2026-07-13 10:13 CEST · Perplexity-MCP · Auditoría completa 25 islas_
