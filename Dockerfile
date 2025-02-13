# Use uma imagem base com CUDA (se precisar da GPU). Se não precisar, use uma imagem Python mais leve.
# Exemplo com CUDA:
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

# Exemplo sem CUDA (mais leve, para uso apenas na CPU):
# FROM python:3.9-slim-buster

# Informações sobre o autor (opcional)
LABEL maintainer="Seu Nome <seu.email@exemplo.com>"

# Configura o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia os arquivos do projeto para o contêiner
COPY . .


RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    pkg-config \
    libopenblas-dev \
    liblapack-dev \
    libavcodec-dev \
    libavformat-dev \
    libavutil-dev \
    libswscale-dev \
    libopencv-dev \
    git \
    wget \
    curl \
    python3-pip


RUN python3 -m venv .venv
ENV VIRTUAL_ENV=/app/.venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"


RUN source .venv/bin/activate


RUN pip install --upgrade pip
RUN pip install -r requirements.txt


EXPOSE 7860  


CMD ["python", "run.py"]
