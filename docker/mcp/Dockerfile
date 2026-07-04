FROM python:3.11-slim
WORKDIR /app
# Copy requirements first for layer caching
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
# Copy source
COPY . ./
ENV YGGDRASIL_ROOT=/app
EXPOSE 8081
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s CMD curl -f http://localhost:8081/health || exit 1
CMD ["python3", "server.py", "--port", "8081"]
