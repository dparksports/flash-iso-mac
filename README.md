# 🔥 Flash ISO Mac

A simple, minimal, open-source set of Bash scripts that let you create bootable USB drives on macOS. Works with Linux (Ubuntu, Kali, Fedora, Arch, Mint, etc.), Windows, BSD, and more. No dependencies, no installs — just one script.

## Scripts

| Script | Lines | Description |
|--------|-------|-------------|
| `flash-iso.sh` | ~90 | Flash Linux/BSD ISOs with drive verification, size warnings, and safety checks |
| `flash-iso-min.sh` | 4 | Bare-minimum version — same job, zero fluff |
| `flash-win.sh` | ~70 | Create a bootable Windows install USB from a Windows ISO |

## Requirements

- macOS
- A USB drive
- An `.iso` file (Linux, Windows, Ubuntu, etc.)
- For Windows: `wimlib` (`brew install wimlib`) — only needed if `install.wim` > 4 GB

## Usage

### Linux / BSD
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

### Windows
```bash
chmod +x flash-win.sh
./flash-win.sh
```
The script will:
1. Ask you to drag and drop your Windows `.iso` file
2. List external drives so you can pick your USB
3. Show the drive name and size for verification
4. Format the USB as FAT32 (GPT/UEFI)
5. Mount the ISO and copy all files to the USB
6. Automatically split `install.wim` if it's larger than 4 GB (requires `wimlib`)
7. Eject the USB when done

## Sample Use Cases

### 🐧 Ubuntu Desktop (Live USB)
Download the ISO from [ubuntu.com](https://ubuntu.com/download/desktop), then:
```
ISO path: ~/Downloads/ubuntu-24.04-desktop-amd64.iso
Disk # (e.g. 2): 2
```
Boot from the USB to try Ubuntu live or install it.

### 🪟 Windows Install USB
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
