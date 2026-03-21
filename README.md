# 🔥 Flash ISO Mac

A simple, minimal, open-source Bash script that lets you create a bootable USB drive on macOS. Works with Linux (Ubuntu, Kali, Fedora, Arch, Mint, etc.), BSD, and other hybrid ISO images. No dependencies, no installs — just one script.

## Scripts

| Script | Lines | Description |
|--------|-------|-------------|
| `flash-iso.sh` | ~90 | Full version with drive verification, size warnings, and safety checks |
| `flash-iso-min.sh` | 4 | Bare-minimum version — same job, zero fluff |

## Requirements

- macOS
- A USB drive
- An `.iso` file (Linux, Windows, Ubuntu, etc.)

## Usage

**Full version:**
```bash
chmod +x flash-iso.sh
./flash-iso.sh
```

**Minimal version (4 lines):**
```bash
chmod +x flash-iso-min.sh
./flash-iso-min.sh
```

## Sample Use Cases

### 🐧 Ubuntu Desktop (Live USB)
Download the ISO from [ubuntu.com](https://ubuntu.com/download/desktop), then:
```
ISO path: ~/Downloads/ubuntu-24.04-desktop-amd64.iso
Disk # (e.g. 2): 2
```
Boot from the USB to try Ubuntu live or install it.

### 🪟 Windows Install USB (manual steps — `dd` won't work)

Windows ISOs are not hybrid ISOs, so `dd` won't create a bootable drive. Use these macOS-native steps instead:

1. **Format the USB as FAT32:**
   ```bash
   diskutil list external                   # find your USB disk number
   diskutil eraseDisk MS-DOS "WINUSB" GPT /dev/diskN   # replace N with your disk number
   ```
2. **Mount the Windows ISO:**
   ```bash
   hdiutil mount ~/Downloads/Win11_24H2_English_x64.iso
   ```
3. **Copy files to the USB:**
   ```bash
   # Copy everything except install.wim (often > 4GB, too large for FAT32)
   rsync -avh --progress --exclude='sources/install.wim' /Volumes/CCCOMA_X64FRE_EN-US_DV9/ /Volumes/WINUSB/

   # Split install.wim into parts that fit on FAT32
   # (requires wimlib — install via: brew install wimlib)
   wimlib-imagex split /Volumes/CCCOMA_X64FRE_EN-US_DV9/sources/install.wim /Volumes/WINUSB/sources/install.swm 3800
   ```
4. **Eject:**
   ```bash
   diskutil eject /dev/diskN
   ```

> **Tip:** Volume names may differ. Use `ls /Volumes/` after mounting to find the correct paths.

### 🐉 Kali Linux (Penetration Testing)
Download from [kali.org](https://www.kali.org/get-kali/), then:
```
ISO path: ~/Downloads/kali-linux-2024.4-installer-amd64.iso
Disk # (e.g. 2): 2
```
Supports both installer and live ISO versions.

### 🔥 Other Live Linux ISOs
Works with any bootable ISO — Fedora, Arch, Mint, Tails, Pop!_OS, etc.:
```
ISO path: ~/Downloads/Fedora-Workstation-Live-x86_64-41.iso
Disk # (e.g. 2): 2
```

## ⚠️ Warning

These tools use `sudo dd` to write raw data directly to a disk. **All existing data on the target drive will be permanently erased.**

## License

This project is open source under the [Apache License 2.0](LICENSE).
