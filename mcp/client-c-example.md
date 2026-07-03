# Cliente MCP en C — Guía de implementación

## FUNCIÓN: Documentación del protocolo MCP para implementar un cliente en C
##          que hable con el MCP server de yggdrasil-dew.

## Protocolo MCP (stdio transport)

El MCP server se comunica por **stdin/stdout** usando mensajes JSON-RPC 2.0.
Tu IA en C lanza `node server.js` como proceso hijo y le manda/lee JSON.

### Estructura de mensaje (request)

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "method": "tools/call",
  "params": {
    "name": "orquestador_supremo",
    "arguments": {}
  }
}
```

### Estructura de respuesta

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "result": {
    "content": [
      {
        "type": "text",
        "text": "✅ Orquestador ejecutado. Estado: OK"
      }
    ]
  }
}
```

### Inicialización (handshake obligatorio)

Antes de llamar tools, el cliente DEBE enviar:

```json
{
  "jsonrpc": "2.0",
  "id": 0,
  "method": "initialize",
  "params": {
    "protocolVersion": "2024-11-05",
    "capabilities": { "tools": {} },
    "clientInfo": { "name": "yggdrasil-c-client", "version": "1.0.0" }
  }
}
```

Y esperar la respuesta antes de llamar tools.

---

## Ejemplo en C (esqueleto funcional)

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define BUF_SIZE 65536

// Lanzar server.js como proceso hijo, obtener pipes stdin/stdout
typedef struct {
    int stdin_fd;   // escribimos aquí → entra al server
    int stdout_fd;  // leemos aquí ← sale del server
    pid_t pid;
} MCPProcess;

MCPProcess mcp_start(const char* server_path) {
    int to_child[2], from_child[2];
    pipe(to_child);
    pipe(from_child);

    pid_t pid = fork();
    if (pid == 0) {
        // Hijo: es el MCP server
        dup2(to_child[0], STDIN_FILENO);
        dup2(from_child[1], STDOUT_FILENO);
        close(to_child[1]); close(from_child[0]);
        setenv("YGGDRASIL_ROOT", "/srv/yggdrasil-dew", 1);
        execlp("node", "node", server_path, NULL);
        exit(1);
    }

    // Padre: guardamos los file descriptors
    close(to_child[0]); close(from_child[1]);
    return (MCPProcess){ to_child[1], from_child[0], pid };
}

// Enviar mensaje JSON al server (añade newline como delimitador)
void mcp_send(MCPProcess* proc, const char* json) {
    write(proc->stdin_fd, json, strlen(json));
    write(proc->stdin_fd, "\n", 1);
}

// Leer respuesta del server (hasta newline)
void mcp_recv(MCPProcess* proc, char* buf, size_t maxlen) {
    size_t i = 0;
    char c;
    while (i < maxlen - 1 && read(proc->stdout_fd, &c, 1) == 1) {
        if (c == '\n') break;
        buf[i++] = c;
    }
    buf[i] = '\0';
}

// Llamar una tool MCP
void mcp_call_tool(MCPProcess* proc, const char* tool_name,
                   const char* arguments_json, char* result, size_t maxlen) {
    char msg[4096];
    static int req_id = 1;
    snprintf(msg, sizeof(msg),
        "{\"jsonrpc\":\"2.0\",\"id\":%d,"
        "\"method\":\"tools/call\","
        "\"params\":{\"name\":\"%s\",\"arguments\":%s}}",
        req_id++, tool_name, arguments_json);
    mcp_send(proc, msg);
    mcp_recv(proc, result, maxlen);
}

// ─── Uso ejemplo ─────────────────────────────────────────────────────────
int main(void) {
    MCPProcess mcp = mcp_start("/srv/yggdrasil-dew/server.js");
    char result[BUF_SIZE];

    // 1. Handshake de inicialización
    mcp_send(&mcp,
        "{\"jsonrpc\":\"2.0\",\"id\":0,\"method\":\"initialize\","
        "\"params\":{\"protocolVersion\":\"2024-11-05\","
        "\"capabilities\":{\"tools\":{}},"
        "\"clientInfo\":{\"name\":\"yggdrasil-c-client\",\"version\":\"1.0.0\"}}}");
    mcp_recv(&mcp, result, sizeof(result));
    printf("Init: %s\n", result);

    // 2. Llamar orquestador_supremo
    mcp_call_tool(&mcp, "orquestador_supremo", "{}", result, sizeof(result));
    printf("Orquestador: %s\n", result);

    // 3. Llamar llm_router con Ollama local
    mcp_call_tool(&mcp, "llm_router",
        "{\"model\":\"ollama:llama3\","
        "\"prompt\":\"Resume el estado del ecosistema en 3 puntos.\"}",
        result, sizeof(result));
    printf("LLM: %s\n", result);

    // 4. Llamar core_estado
    mcp_call_tool(&mcp, "core_estado", "{}", result, sizeof(result));
    printf("Core: %s\n", result);

    return 0;
}
```

---

## Compilar y ejecutar

```bash
gcc -o yggdrasil-client mcp-client.c
./yggdrasil-client
```

---

## Llamar llm_router desde C

```c
// Ollama local
mcp_call_tool(&mcp, "llm_router",
    "{\"model\":\"ollama:llama3\",\"prompt\":\"¿Qué hay en el inbox?\"}",
    result, sizeof(result));

// OpenAI
mcp_call_tool(&mcp, "llm_router",
    "{\"model\":\"openai:gpt-4.1\",\"prompt\":\"Analiza el último audit.\","
    "\"maxTokens\":1024}",
    result, sizeof(result));

// Groq (ultra-rápido, gratis con límites)
mcp_call_tool(&mcp, "llm_router",
    "{\"model\":\"groq:llama3-70b-8192\",\"prompt\":\"Clasifica este inbox.\","
    "\"temperature\":0.3}",
    result, sizeof(result));

// Modelo local compilado en C (tu propio modelo)
mcp_call_tool(&mcp, "llm_router",
    "{\"model\":\"local:mi-modelo\",\"prompt\":\"..\"}",
    result, sizeof(result));
```

---

## Variables de entorno necesarias

```bash
export YGGDRASIL_ROOT=/srv/yggdrasil-dew
export OLLAMA_HOST=http://localhost:11434     # Ollama local
export LMSTUDIO_HOST=http://localhost:1234    # LM Studio local
export OPENAI_API_KEY=sk-...                  # OpenAI
export ANTHROPIC_API_KEY=sk-ant-...           # Anthropic
export GROQ_API_KEY=gsk_...                  # Groq
export LOCAL_AI_BIN=/usr/local/bin/mi-modelo # Binario propio
```

Guárdalas en `.env` (ya está en `.gitignore`) y el server las carga automáticamente.
