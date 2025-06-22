FROM pytorch/pytorch:2.1.2-cpu-py3.10-slim

# Evita prompts interativos e reduz camadas
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Atualiza pacotes essenciais e instala dependências do sistema
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg gcc libsndfile1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copia apenas requirements.txt para cache
COPY requirements.txt .

# Instala as dependências que você precisa, exceto torch (já na imagem)
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código
COPY . .

# Variável PORT que Railway usa
ENV PORT=8880
EXPOSE ${PORT}

WORKDIR /app/api/src

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8880"]
