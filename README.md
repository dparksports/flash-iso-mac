# 🔥 Flash ISO Mac

A simple, minimal, open-source Bash script for flashing Linux ISO images to USB drives on macOS. No dependencies, no installs — just one script.

## Features

- **Dead simple** — one script, no setup required
- **Drag-and-drop ISO input** — drag your `.iso` file into the Terminal prompt
- **Safe by default** — only lists external drives, verifies drive name and size, and requires explicit confirmation before writing
- **Large-drive warning** — warns if the target looks too big to be a USB stick

## Requirements

- macOS
- A USB drive
- A Linux `.iso` file

## Usage

```bash
chmod +x flash-iso.sh
./flash-iso.sh
```

1. Drag and drop your `.iso` file into the Terminal when prompted.
2. Pick your USB drive from the list of external drives.
3. Verify the drive name and size.
4. Type `yes` to confirm — the script writes the image and ejects the drive.

## ⚠️ Warning

This tool uses `sudo dd` to write raw data directly to a disk. **All existing data on the target drive will be permanently erased.**

## License

This project is open source under the [Apache License 2.0](LICENSE).
