# 🔥 Flash ISO Mac

A simple, minimal, open-source Bash script for flashing Linux ISO images to USB drives on macOS. No dependencies, no installs — just one script.

## Scripts

| Script | Lines | Description |
|--------|-------|-------------|
| `flash-iso.sh` | ~90 | Full version with drive verification, size warnings, and safety checks |
| `flash-iso-min.sh` | 4 | Bare-minimum version — same job, zero fluff |

## Requirements

- macOS
- A USB drive
- A Linux `.iso` file

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

## ⚠️ Warning

These tools use `sudo dd` to write raw data directly to a disk. **All existing data on the target drive will be permanently erased.**

## License

This project is open source under the [Apache License 2.0](LICENSE).
