FROM python:3.11-slim
LABEL maintainer="alvarofernandezmota-tech"
LABEL description="Yggdrasil Retrieval API"
WORKDIR /app
RUN pip install --no-cache-dir flask requests
COPY tools/ ./tools/
EXPOSE 9001
CMD ["python3", "tools/retrieval_api.py"]
