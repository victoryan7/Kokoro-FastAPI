# Dockerfile para Kokoro (FastAPI + uvicorn)
FROM python:3.10-slim

WORKDIR /app

# Copia os arquivos do projeto
COPY . .

# Instala dependências
RUN pip install --no-cache-dir -r requirements.txt

# Define a porta que o Railway vai expor (Railway usa env.PORT)
ENV PORT=8880

EXPOSE ${PORT}

# Comando para iniciar o app com uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8880"]
