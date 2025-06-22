FROM python:3.10-slim

# Evita prompts interativos e reduz camadas
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Atualiza pacotes e instala dependências mínimas de sistema
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg gcc libsndfile1 \
    && rm -rf /var/lib/apt/lists/*

# Cria diretório de trabalho
WORKDIR /app

# Copia só o requirements para cache otimizado
COPY requirements.txt .

# Instala o PyTorch CPU + outras dependências
RUN pip install --no-cache-dir torch==2.1.2+cpu -f https://download.pytorch.org/whl/cpu/torch_stable.html \
    && pip install --no-cache-dir -r requirements.txt

# Copia o restante do projeto
COPY . .

# Define variáveis de ambiente e porta
ENV PORT=8880
EXPOSE ${PORT}

# Altera o diretório para onde está o main.py
WORKDIR /app/api/src

# Comando de inicialização
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8880"]
