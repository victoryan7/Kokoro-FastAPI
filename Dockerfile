FROM python:3.10-slim

WORKDIR /app

# Copia os arquivos do projeto
COPY . .

# Instala as dependências a partir da raiz, onde está o requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Define variáveis de ambiente para Railway
ENV PORT=8880
EXPOSE ${PORT}

# Entra na pasta src onde está o main.py
WORKDIR /app/src

# Roda o app usando uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8880"]
