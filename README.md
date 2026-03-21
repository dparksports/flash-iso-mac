# 🔥 Flash ISO Mac

![Flash ISO Mac](assets/banner.png)
A simple, minimal, open-source set of Bash scripts that let you create bootable USB drives on macOS. Works with Linux (Ubuntu, Fedora, Arch, Mint, etc.), BSD, and more. No dependencies, no installs — just one script.

## Scripts

| Script | Lines | Description |
|--------|-------|-------------|
| `flash-iso.sh` | ~90 | Flash Linux/BSD ISOs with drive verification, size warnings, and safety checks |
| `flash-iso-min.sh` | 4 | Bare-minimum version — same job, zero fluff |
| `flash-win.sh` | ~70 | (*Requires Homebrew*) Create a bootable Windows install USB |
| `flash-win-min.sh` | 4 | (*Requires Homebrew*) Bare-minimum version of the Windows USB creator |

## Requirements

- macOS
- A USB drive
- An `.iso` file (Linux, Windows, Ubuntu, etc.)
- **For Windows only:** `wimlib` — must be installed via Homebrew (`brew install wimlib`)

## Usage

### Linux / BSD
**Full version:**
```bash
bash flash-iso.sh
```

**Minimal version (4 lines):**
```bash
bash flash-iso-min.sh
```

### 🪟 Windows Install USB (For Homebrew Users)
*Because Windows ISOs have files larger than 4GB, they require `wimlib` to split them for FAT32 compatibility. These scripts require Homebrew.*

**Full version:**
```bash
bash flash-win.sh
```

**Minimal version (4 lines):**
```bash
bash flash-win-min.sh
```


## Sample Use Cases

### 🐧 Ubuntu Desktop (Live USB)
Download the ISO from [ubuntu.com](https://ubuntu.com/download/desktop), then:
```
ISO path: ~/Downloads/ubuntu-24.04-desktop-amd64.iso
Disk # (e.g. 2): 2
```
Boot from the USB to try Ubuntu live or install it.

### 🪟 Windows Install USB (For Homebrew Users)
Download the ISO from [microsoft.com](https://www.microsoft.com/software-download/windows11). Run `brew install wimlib`, then:
```
ISO path: ~/Downloads/Win11_24H2_English_x64.iso
Disk # (e.g. 2): 2
```


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
