# 🔥 Flash ISO Mac

A simple, minimal, open-source Bash script for flashing ISO images to USB drives on macOS. Works with any ISO — Linux (Ubuntu, Fedora, Arch, etc.), Windows, and more. No dependencies, no installs — just one script.

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

### 🪟 Windows 11
Download the ISO from [microsoft.com](https://www.microsoft.com/software-download/windows11), then:
```
ISO path: ~/Downloads/Win11_24H2_English_x64.iso
Disk # (e.g. 2): 2
```

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
