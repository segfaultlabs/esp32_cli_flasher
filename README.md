# OSX esp32_cli_flasher

## OR JUST USE A ONE LINER 

# PORT=$(ls /dev/cu.* | grep -E "usbserial|usbmodem" | head -n 1); INO=$(ls *.ino | head -n 1); [ -z "$INO" ] && echo "no .ino found" && exit 1; arduino-cli compile --fqbn esp32:esp32:esp32 . && arduino-cli upload --fqbn esp32:esp32:esp32 --port "$PORT" --upload-property upload.speed=115200 .




Simple shell script for flashing ESP boards from any directory.  
Put it somewhere in your PATH and run it next to your firmware files.

## Features
- Automatically detects the serial port (`cu.usbserial*`)
- Uses the first `.bin` file if you don’t specify one
- Wraps `esptool.py` with clean, sensible defaults

## Usage
```sh
flash
````

or

```sh
flash firmware.bin
```

## Exit Codes

* **0** — flash succeeded
* **1** — no firmware file found
* **2** — serial port not found
* **3** — esptool missing

```
```
