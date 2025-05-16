FROM python:3.10-slim

RUN apt update && apt install -y wget xz-utils && \
    wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin

WORKDIR /app
COPY . /app
RUN pip install -r requirements.txt

ENV BOT_TOKEN=7772598857:AAHiO0pz2me1ONp1yWwfavR23KJrP4DfMSs

CMD ["python", "bot.py"]
