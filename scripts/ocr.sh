#!/bin/sh
# 1. Select region and capture to stdout
# 2. Use tesseract to read text from stdin
# 3. Copy to clipboard via wl-copy
# 4. Notify via SwayNC
image_path="/tmp/ocr_snapshot.png"

grim -g "$(slurp)" "$image_path" && \
tesseract "$image_path" - | wl-copy && \
notify-send "OCR Complete" "Text copied to clipboard" && \
rm "$image_path"
