FROM python:3.10-slim

WORKDIR /app

# Copia tudo para o /app
COPY . .

# Muda para a pasta onde está o app real
WORKDIR /app/src

# Instala as dependências corretamente
RUN pip install --no-cache-dir -r requirements.txt

# Porta que o Railway fornece via env.PORT
ENV PORT=8880
EXPOSE ${PORT}

# Executa com uvicorn (precisa instalar uvicorn no requirements se ainda não tiver)
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8880"]
