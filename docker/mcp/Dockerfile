FROM python:3.11-slim
LABEL maintainer="alvarofernandezmota-tech"
LABEL description="Yggdrasil MCP Server"
WORKDIR /app
# Copy requirements if they exist
COPY mcp/ ./
RUN pip install --no-cache-dir -r requirements.txt 2>/dev/null || true
ENV YGGDRASIL_ROOT=/app
EXPOSE 8081
CMD ["python3", "server.py", "--port", "8081"]
