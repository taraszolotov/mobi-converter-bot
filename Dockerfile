FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    wget \
    python3 \
    libxkbcommon0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

RUN wget -nv -O linux-installer.sh https://download.calibre-ebook.com/linux-installer.sh \
    && sh linux-installer.sh \
    && rm linux-installer.sh

WORKDIR /app
