#!/usr/bin/env node
// ============================================================
// NOMBRE:   mcp/test-mcp.js
// FUNCIÓN:  Tests end-to-end del MCP server via stdio
// USO:      node mcp/test-mcp.js
// ============================================================
import { spawn } from "child_process";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const SERVER = path.join(__dirname, "server.js");

const TESTS = [
  { id: 1, method: "initialize", params: { protocolVersion: "2024-11-05", capabilities: {}, clientInfo: { name: "test", version: "1.0" } } },
  { id: 2, method: "tools/list", params: {} },
  { id: 3, method: "tools/call", params: { name: "health_check", arguments: {} } },
  { id: 4, method: "tools/call", params: { name: "core_estado", arguments: {} } }
];

const proc = spawn("node", [SERVER], {
  env: { ...process.env, YGGDRASIL_ROOT: process.env.YGGDRASIL_ROOT || process.cwd() },
  stdio: ["pipe","pipe","pipe"]
});

let results = [];
let buf = "";
proc.stdout.on("data", d => {
  buf += d.toString();
  let lines = buf.split("\n");
  buf = lines.pop();
  lines.forEach(l => {
    if (!l.trim()) return;
    try {
      const r = JSON.parse(l);
      results.push(r);
      const test = TESTS.find(t => t.id === r.id);
      if (r.error) console.error(`❌ Test ${r.id} (${test?.method}): ${r.error.message}`);
      else console.log(`✅ Test ${r.id} (${test?.method}): OK`);
      if (results.length >= TESTS.length) { proc.kill(); process.exit(0); }
    } catch {}
  });
});

proc.stderr.on("data", d => process.stderr.write(d));

TESTS.forEach((t, i) => {
  setTimeout(() => proc.stdin.write(JSON.stringify({ jsonrpc: "2.0", ...t }) + "\n"), i * 200);
});

setTimeout(() => {
  console.error("[TIMEOUT] Test no completado en 10s");
  proc.kill();
  process.exit(1);
}, 10000);
