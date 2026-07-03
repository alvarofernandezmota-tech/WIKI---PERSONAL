#!/usr/bin/env node
// ============================================================
// NOMBRE:   mcp/server.js
// VERSION:  2.0.0
// FUNCIÓN:  MCP Server Node.js para yggdrasil-dew.
//           Expone TODAS las herramientas del ecosistema como
//           tools MCP via stdio (JSON-RPC 2.0 sobre stdin/stdout).
//           Compatible con Claude Desktop, Copilot MCP, IA en C.
// REPO:     alvarofernandezmota-tech/yggdrasil-dew
// USO:      node mcp/server.js
//           O via mcp-config.json
// ============================================================

import { execSync, exec } from "child_process";
import { readFileSync, existsSync } from "fs";
import path from "path";
import { promisify } from "util";
import readline from "readline";

const execAsync = promisify(exec);
const ROOT = process.env.YGGDRASIL_ROOT || path.resolve(process.cwd());

// ─── UTILIDADES ──────────────────────────────────────────────
function runShell(cmd, timeout = 120000) {
  try {
    return execSync(cmd, { encoding: "utf8", cwd: ROOT, timeout, stdio: ["pipe","pipe","pipe"] });
  } catch (e) {
    return `[ERROR] ${e.message}\n${e.stdout || ""}${e.stderr || ""}`;
  }
}

async function runShellAsync(cmd, timeout = 120000) {
  try {
    const { stdout, stderr } = await execAsync(cmd, { cwd: ROOT, timeout });
    return stdout + (stderr ? `\n[STDERR]\n${stderr}` : "");
  } catch (e) {
    return `[ERROR] ${e.message}`;
  }
}

function scriptExists(name) {
  return existsSync(path.join(ROOT, "scripts", name)) ||
         existsSync(path.join(ROOT, "scripts", "agentes", name));
}

function runScript(name, args = "") {
  const p1 = path.join(ROOT, "scripts", name);
  const p2 = path.join(ROOT, "scripts", "agentes", name);
  const p = existsSync(p1) ? p1 : existsSync(p2) ? p2 : null;
  if (!p) return `[WARN] Script no encontrado: ${name} — pendiente de implementar`;
  return runShell(`bash "${p}" ${args}`);
}

// ─── DEFINICIÓN DE TOOLS ─────────────────────────────────────
const TOOLS = [
  {
    name: "orquestador_supremo",
    description: "Ejecuta el orquestador supremo: coordina todos los agentes y genera reporte maestro.",
    inputSchema: { type: "object", properties: {}, required: [] }
  },
  {
    name: "orquestador_total",
    description: "Ejecuta el orquestador total: audita, sincroniza islas, verifica CORE, genera reporte.",
    inputSchema: { type: "object", properties: { modo: { type: "string", enum: ["completo","rapido","solo-auditoria"], default: "completo" } }, required: [] }
  },
  {
    name: "watchdog_monitor",
    description: "Monitoriza que agentes y orquestador hayan generado reportes dentro del SLA (24h).",
    inputSchema: { type: "object", properties: { sla_horas: { type: "integer", default: 24 } }, required: [] }
  },
  {
    name: "clasificador_maestro",
    description: "Clasifica archivos del inbox y los mueve a destinos adecuados.",
    inputSchema: { type: "object", properties: {}, required: [] }
  },
  {
    name: "gestor_estados_inbox",
    description: "Gestiona estados del inbox: NUEVO → EN-PROCESO → PROCESADO.",
    inputSchema: { type: "object", properties: {}, required: [] }
  },
  {
    name: "struct_auditor",
    description: "Auditoría estructural del repo: detecta duplicados, fantasmas, inconsistencias.",
    inputSchema: { type: "object", properties: { fix: { type: "boolean", default: false } }, required: [] }
  },
  {
    name: "agent_docs",
    description: "Sincroniza y valida la documentación del ecosistema.",
    inputSchema: { type: "object", properties: {}, required: [] }
  },
  {
    name: "agent_islas",
    description: "Orquesta islas del ecosistema y detecta bloqueos.",
    inputSchema: { type: "object", properties: {}, required: [] }
  },
  {
    name: "agent_tareas",
    description: "Gestiona tareas y detecta pendientes críticos.",
    inputSchema: { type: "object", properties: {}, required: [] }
  },
  {
    name: "agent_investigacion",
    description: "Indexa y organiza investigación RAG/OSINT.",
    inputSchema: { type: "object", properties: {}, required: [] }
  },
  {
    name: "agent_ecosistema",
    description: "Auditoría global del ecosistema yggdrasil-dew.",
    inputSchema: { type: "object", properties: {}, required: [] }
  },
  {
    name: "agent_meta",
    description: "Auditoría rápida de agentes y herramientas (inventario + cabeceras).",
    inputSchema: { type: "object", properties: {}, required: [] }
  },
  {
    name: "agent_meta_deep",
    description: "Investigación profunda de agentes, scripts y workflows con LLM local. Propone mejoras.",
    inputSchema: { type: "object", properties: { scope: { type: "string", enum: ["full","scripts","docs","workflows"], default: "full" }, modelo: { type: "string", default: "llama3" } }, required: [] }
  },
  {
    name: "galatea_fabrica_agente",
    description: "Crea un nuevo agente con plantilla estándar, DISEÑO.md y script base.",
    inputSchema: { type: "object", properties: { nombre: { type: "string" }, rol: { type: "string" }, scope: { type: "string" }, tags: { type: "string" } }, required: ["nombre","rol"] }
  },
  {
    name: "galatea_isla_bot",
    description: "Crea una isla o bot Galatea con estructura completa.",
    inputSchema: { type: "object", properties: { tipo: { type: "string", enum: ["isla","bot"] }, nombre: { type: "string" }, descripcion: { type: "string" } }, required: ["tipo","nombre","descripcion"] }
  },
  {
    name: "llm_router",
    description: "Enruta prompts al LLM adecuado. Prefijos: ollama:<model>, openai:<model>, anthropic:<model>, http:<url>. Auto-detecta si model='auto'.",
    inputSchema: { type: "object", properties: { model: { type: "string", default: "auto" }, prompt: { type: "string" }, options: { type: "object" } }, required: ["prompt"] }
  },
  {
    name: "core_estado",
    description: "Devuelve el contenido de CORE-ECOSISTEMA.md (fuente de verdad del ecosistema).",
    inputSchema: { type: "object", properties: {}, required: [] }
  },
  {
    name: "health_check",
    description: "Pulso completo: scripts, workflows, MCP, Ollama, APIs remotas.",
    inputSchema: { type: "object", properties: {}, required: [] }
  }
];

// ─── IMPLEMENTACIÓN DE TOOLS ──────────────────────────────────
async function callTool(name, args = {}) {
  switch (name) {
    case "orquestador_supremo":
      return runScript("orquestador-supremo.sh");
    case "orquestador_total":
      return runScript("orquestador-total.sh", args.modo || "completo");
    case "watchdog_monitor":
      return runScript("watchdog.sh", String(args.sla_horas || 24));
    case "clasificador_maestro":
      return runScript("clasificador-maestro.sh");
    case "gestor_estados_inbox":
      return runScript("gestor-estados-inbox.sh");
    case "struct_auditor":
      return runScript("struct-auditor.sh", args.fix ? "--fix" : "");
    case "agent_docs":
      return runScript("agent-docs-sync.sh");
    case "agent_islas":
      return runScript("agent-islas-orquestador.sh");
    case "agent_tareas":
      return runScript("agent-tareas-manager.sh");
    case "agent_investigacion":
      return runScript("agent-investigacion-sync.sh");
    case "agent_ecosistema":
      return runScript("agent-ecosistema-audit.sh");
    case "agent_meta":
      return runScript("agent-meta-audit.sh");
    case "agent_meta_deep":
      return runScript("agentes/agente-meta-deep.sh", `${args.scope||"full"} ${args.modelo||"llama3"}`);
    case "galatea_fabrica_agente":
      return runScript("agentes/galatea-fabrica-agentes.sh", `"${args.nombre}" "${args.rol}" "${args.scope||"general"}" "${args.tags||""}"`);
    case "galatea_isla_bot":
      return runScript("galatea-islas-bots.sh", `"${args.tipo}" "${args.nombre}" "${args.descripcion}"`);
    case "llm_router":
      return await _llmRouter(args);
    case "core_estado": {
      const p = path.join(ROOT, "docs", "CORE-ECOSISTEMA.md");
      return existsSync(p) ? readFileSync(p, "utf8") : "[ERROR] CORE-ECOSISTEMA.md no encontrado";
    }
    case "health_check":
      return _healthCheck();
    default:
      return `[ERROR] Tool desconocida: ${name}`;
  }
}

async function _llmRouter({ model = "auto", prompt, options = {} }) {
  // Auto-detección
  if (model === "auto") {
    try { runShell("ollama list", 5000); model = "ollama:llama3"; }
    catch { model = process.env.OPENAI_API_KEY ? "openai:gpt-4o-mini" : "anthropic:claude-3-haiku-20240307"; }
  }

  if (model.startsWith("ollama:")) {
    const m = model.replace("ollama:", "");
    const safe = prompt.replace(/"/g, '\\"').replace(/\n/g, " ");
    return await runShellAsync(`ollama run ${m} "${safe}"`, 120000);
  }

  if (model.startsWith("openai:")) {
    const key = process.env.OPENAI_API_KEY;
    if (!key) return "[ERROR] OPENAI_API_KEY no configurada";
    const m = model.replace("openai:", "");
    const payload = JSON.stringify({ model: m, messages: [{ role: "user", content: prompt }], temperature: options.temperature || 0.3 });
    return await runShellAsync(`curl -s -X POST https://api.openai.com/v1/chat/completions -H "Authorization: Bearer ${key}" -H "Content-Type: application/json" -d '${payload.replace(/'/g,"'\\''")}' | python3 -c "import sys,json;d=json.load(sys.stdin);print(d['choices'][0]['message']['content'])"`);
  }

  if (model.startsWith("anthropic:")) {
    const key = process.env.ANTHROPIC_API_KEY;
    if (!key) return "[ERROR] ANTHROPIC_API_KEY no configurada";
    const m = model.replace("anthropic:", "");
    const payload = JSON.stringify({ model: m, max_tokens: 2048, messages: [{ role: "user", content: prompt }] });
    return await runShellAsync(`curl -s -X POST https://api.anthropic.com/v1/messages -H "x-api-key: ${key}" -H "anthropic-version: 2023-06-01" -H "Content-Type: application/json" -d '${payload.replace(/'/g,"'\\''")}' | python3 -c "import sys,json;d=json.load(sys.stdin);print(d['content'][0]['text'])"`);
  }

  if (model.startsWith("http")) {
    const payload = JSON.stringify({ prompt });
    return await runShellAsync(`curl -s -X POST ${model} -H "Content-Type: application/json" -d '${payload.replace(/'/g,"'\\''")}' `);
  }

  return `[ERROR] Modelo no reconocido: ${model}. Usa ollama:<name>, openai:<name>, anthropic:<name>, http:<url>, o 'auto'`;
}

function _healthCheck() {
  const checks = [];
  checks.push(`ROOT: ${ROOT} — ${existsSync(ROOT) ? "✅" : "❌"}`);
  ["scripts","inbox","diary","mcp","docs"].forEach(d => {
    checks.push(`${d}/: ${existsSync(path.join(ROOT,d)) ? "✅" : "❌"}`);
  });
  checks.push(`CORE-ECOSISTEMA.md: ${existsSync(path.join(ROOT,"docs","CORE-ECOSISTEMA.md")) ? "✅" : "❌"}`);
  try { runShell("ollama list", 5000); checks.push("Ollama: ✅"); } catch { checks.push("Ollama: ❌ no disponible"); }
  checks.push(`OPENAI_API_KEY: ${process.env.OPENAI_API_KEY ? "✅" : "⚠️  no configurada"}`);
  checks.push(`ANTHROPIC_API_KEY: ${process.env.ANTHROPIC_API_KEY ? "✅" : "⚠️  no configurada"}`);
  return checks.join("\n");
}

// ─── LOOP MCP STDIO (JSON-RPC 2.0) ───────────────────────────
const rl = readline.createInterface({ input: process.stdin });

function send(obj) {
  process.stdout.write(JSON.stringify(obj) + "\n");
}

rl.on("line", async (line) => {
  let req;
  try { req = JSON.parse(line.trim()); } catch { return; }
  if (!req) return;

  const { id, method, params } = req;

  if (method === "initialize") {
    send({ jsonrpc: "2.0", id, result: {
      protocolVersion: "2024-11-05",
      capabilities: { tools: {} },
      serverInfo: { name: "yggdrasil-ecosistema", version: "2.0.0" }
    }});
    return;
  }

  if (method === "tools/list") {
    send({ jsonrpc: "2.0", id, result: { tools: TOOLS } });
    return;
  }

  if (method === "tools/call") {
    const { name, arguments: args } = params;
    try {
      const result = await callTool(name, args || {});
      const text = typeof result === "string" ? result : JSON.stringify(result);
      send({ jsonrpc: "2.0", id, result: { content: [{ type: "text", text: text.slice(0, 8000) }] } });
    } catch (e) {
      send({ jsonrpc: "2.0", id, error: { code: -32603, message: String(e.message) } });
    }
    return;
  }

  if (method === "notifications/initialized") return; // ACK, no response needed

  send({ jsonrpc: "2.0", id, error: { code: -32601, message: `Method not found: ${method}` } });
});

process.stderr.write("[MCP] yggdrasil-ecosistema server v2.0 listo (stdio JSON-RPC 2.0)\n");
