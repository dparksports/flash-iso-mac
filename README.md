# 🔥 Flash ISO Mac

A simple, safe Bash tool for flashing Linux ISO images to USB drives on macOS.

## Features

- **Drag-and-drop ISO input** — just drag your `.iso` file into the Terminal prompt
- **External-drive-only listing** — only shows external drives to prevent accidentally selecting your Mac's internal disk
- **Drive verification** — displays the selected drive's name and size before proceeding
- **Large-drive warning** — warns if the selected drive is measured in terabytes (likely not a USB stick)
- **Confirmation gate** — requires you to type `yes` before any data is written

## Requirements

- macOS (uses `diskutil` and `dd`)
- A USB drive
- A Linux `.iso` file

## Usage

```bash
chmod +x flashusbv2.sh
./flashusbv2.sh
```

1. **Provide the ISO** — drag and drop your Linux `.iso` file into the Terminal window when prompted, then press Return.
2. **Select the USB drive** — the script lists external drives. Enter the disk number (e.g., `2` for `/dev/disk2`).
3. **Verify the drive** — review the drive name and size displayed on screen.
4. **Confirm** — type `yes` to proceed. The script unmounts the drive, writes the image with `dd`, and ejects the drive when finished.

## ⚠️ Warning

This tool uses `sudo dd` to write raw data directly to a disk. **All existing data on the target drive will be permanently erased.** Double-check the disk number before confirming.

## License

This project is licensed under the [Apache License 2.0](LICENSE).
