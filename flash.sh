#!/bin/bash

# --- Detect sketch directory and .ino file ---
SKETCH_DIR="$(pwd)"
INO_FILE=$(ls *.ino 2>/dev/null | head -n 1)

if [ -z "$INO_FILE" ]; then
  echo "No .ino file found in this directory."
  exit 1
fi

SKETCH_PATH="$SKETCH_DIR/$INO_FILE"

# --- Auto-detect serial port ---
PORT=$(ls /dev/cu.* | grep -E "usbserial|usbmodem" | head -n 1)

if [ -z "$PORT" ]; then
  echo "No ESP32 serial port detected."
  exit 1
fi

echo "Sketch:     $SKETCH_PATH"
echo "Serial:     $PORT"
echo "Baud:       115200"
echo "Board:      esp32:esp32:esp32"
echo "-----------------------------------------"

# --- Compile ---
arduino-cli compile --fqbn esp32:esp32:esp32 "$SKETCH_DIR"
if [ $? -ne 0 ]; then
  echo "Compile failed."
  exit 1
fi

# --- Upload ---
arduino-cli upload \
  --fqbn esp32:esp32:esp32 \
  --port "$PORT" \
  --upload-property upload.speed=115200 \
  "$SKETCH_DIR"
