FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    wget \
    python3 \
    libxkbcommon0 \
    libgl1 \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    libfontconfig1 \
    libfreetype6 \
    libxext6 \
    libxcb1 \
    libx11-6 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

RUN wget -nv -O linux-installer.sh https://download.calibre-ebook.com/linux-installer.sh \
    && sh linux-installer.sh \
    && rm linux-installer.sh

WORKDIR /app
