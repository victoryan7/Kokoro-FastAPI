FROM python:3.10-slim

WORKDIR /app

COPY . .

RUN pip install --no-cache-dir -r requirements.txt

# Railway usa a variável de ambiente PORT
ENV PORT=8880
EXPOSE ${PORT}

# Caminho onde está o main.py
WORKDIR /app/api/src

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8880"]
