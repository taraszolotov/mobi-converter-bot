# Вибираємо базовий образ Python slim (легкий)
FROM python:3.10-slim

# Оновлюємо пакети і ставимо всі необхідні бібліотеки для Calibre
RUN apt update && apt install -y \
    wget \
    xz-utils \
    libegl1 \
    libopengl0 \
    libxcb-cursor0 \
    libxcb1 \
    libx11-6 \
    && rm -rf /var/lib/apt/lists/*

# Завантажуємо офіційний інсталятор Calibre, запускаємо і видаляємо інсталятор
RUN wget -nv -O linux-installer.sh https://download.calibre-ebook.com/linux-installer.sh \
    && sh linux-installer.sh \
    && rm linux-installer.sh

# Вказуємо робочу директорію в контейнері
WORKDIR /app

# За замовчуванням запускаємо bash (можеш замінити на свій CMD)
CMD ["bash"]
