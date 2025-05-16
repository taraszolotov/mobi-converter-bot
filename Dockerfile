FROM python:3.10-slim

# Оновлення системи, встановлення потрібних пакетів, включно з бібліотеками для Calibre
RUN apt update && apt install -y \
    wget \
    xz-utils \
    libegl1 \
    libopengl0 \
    && rm -rf /var/lib/apt/lists/*

# Завантажуємо інсталятор Calibre, запускаємо його і видаляємо інсталятор
RUN wget -nv -O linux-installer.sh https://download.calibre-ebook.com/linux-installer.sh \
    && sh linux-installer.sh \
    && rm linux-installer.sh

# Встановлюємо робочу директорію (опціонально, для твого проекту)
WORKDIR /app

# Копіюємо файли проекту (за потребою)
# COPY . /app

# Вказуємо команду за замовчуванням (можеш замінити на свою)
CMD ["bash"]
