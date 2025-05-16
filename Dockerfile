FROM python:3.10-slim

RUN apt update && apt install -y \
    wget \
    xz-utils \
    libegl1 \
    libopengl0 \
    libxcb-cursor0 \
    libxcb1 \
    libx11-6 \
    && rm -rf /var/lib/apt/lists/*

RUN wget -nv -O linux-installer.sh https://download.calibre-ebook.com/linux-installer.sh \
    && sh linux-installer.sh \
    && rm linux-installer.sh

WORKDIR /app

CMD ["bash"]
