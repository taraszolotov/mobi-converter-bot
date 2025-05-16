FROM python:3.10-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    xz-utils \
    libegl1 \
    libopengl0 \
    libxcb-cursor0 \
    libxcb1 \
    libx11-6 \
    libglib2.0-0 \
    libfontconfig1 \
    libfreetype6 \
    libxrender1 \
    libsm6 \
    libxext6 \
    libxfixes3 \
    && rm -rf /var/lib/apt/lists/*

RUN wget -nv -O linux-installer.sh https://download.calibre-ebook.com/linux-installer.sh \
    && sh linux-installer.sh \
    && rm linux-installer.sh

WORKDIR /app

CMD ["bash"]
