import os
from telegram import Update
from telegram.ext import ApplicationBuilder, MessageHandler, CommandHandler, ContextTypes, filters
import subprocess
import uuid

TOKEN = os.getenv("BOT_TOKEN")

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text("📚 Привіт! Надішли мені файл (PDF, EPUB, TXT тощо), і я перетворю його в MOBI 📥📤")

async def handle_file(update: Update, context: ContextTypes.DEFAULT_TYPE):
    file = update.message.document
    if not file:
        return

    file_name = file.file_name
    file_ext = os.path.splitext(file_name)[-1].lower()
    download_path = f"/tmp/{uuid.uuid4()}{file_ext}"
    output_path = download_path.replace(file_ext, ".mobi")

    file_obj = await file.get_file()
    await file_obj.download_to_drive(download_path)

    try:
        result = subprocess.run(["ebook-convert", download_path, output_path], capture_output=True)
        if result.returncode == 0:
            await update.message.reply_document(document=open(output_path, "rb"))
        else:
            await update.message.reply_text("❌ Не вдалося конвертувати. Можливо, формат не підтримується.")
            print(result.stderr.decode())
    except Exception as e:
        await update.message.reply_text("⚠️ Сталася помилка при обробці файлу.")
        print(e)

    if os.path.exists(download_path): os.remove(download_path)
    if os.path.exists(output_path): os.remove(output_path)

app = ApplicationBuilder().token(TOKEN).build()
app.add_handler(CommandHandler("start", start))
app.add_handler(MessageHandler(filters.Document.ALL, handle_file))

if __name__ == "__main__":
    app.run_polling()
