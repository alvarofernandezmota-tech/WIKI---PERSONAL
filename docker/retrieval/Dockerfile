FROM python:3.11-slim
WORKDIR /app
COPY retrieval_api.py ./
RUN pip install --no-cache-dir flask requests
EXPOSE 9001
HEALTHCHECK --interval=30s --timeout=5s CMD curl -f http://localhost:9001/health || exit 1
CMD ["python3", "retrieval_api.py"]
