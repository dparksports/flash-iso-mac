#!/bin/bash

echo "======================================="
echo "     Mac Windows USB Flasher           "
echo "  (Create Bootable Windows Install)    "
echo "======================================="
echo "WARNING: This tool will completely ERASE the selected USB drive."
echo ""

# 1. Get the Windows ISO path
read -p "Drag and drop your Windows .iso file here (and press Return): " RAW_ISO_PATH
ISO_PATH=$(echo "$RAW_ISO_PATH" | sed -e "s/^'//" -e "s/'$//" -e 's/^"//' -e 's/"$//' -e 's/ $//')

if [ ! -f "$ISO_PATH" ]; then
    echo "Error: Could not find the file at $ISO_PATH"
    exit 1
fi

# 2. Show external drives
echo ""
echo "--- Scanning for external drives ---"
diskutil list external
echo "------------------------------------"
echo ""

# 3. Get the target disk number
read -p "Enter the disk NUMBER of your USB drive (e.g., 2 for /dev/disk2): " DISK_NUM
TARGET_DISK="/dev/disk$DISK_NUM"

if ! diskutil info "$TARGET_DISK" > /dev/null 2>&1; then
    echo "Error: Disk $TARGET_DISK does not exist."
    exit 1
fi

DRIVE_SIZE=$(diskutil info "$TARGET_DISK" | grep -E "(Disk Size|Total Size)" | head -n 1 | awk -F: '{print $2}' | xargs | cut -d' ' -f1,2)
DRIVE_NAME=$(diskutil info "$TARGET_DISK" | grep "Device / Media Name" | awk -F: '{print $2}' | xargs)

echo ""
echo "Selected: $TARGET_DISK | ${DRIVE_NAME:-Unknown} | $DRIVE_SIZE"
echo ""

# 4. Confirm
read -p "Type 'yes' to erase $TARGET_DISK and create a bootable Windows USB: " CONFIRM
if [ "$CONFIRM" != "yes" ]; then
    echo "Cancelled."
    exit 0
fi

# 5. Format USB as FAT32 (MS-DOS) with GPT for UEFI boot
echo ""
echo "Formatting $TARGET_DISK as FAT32 (MS-DOS)..."
diskutil eraseDisk MS-DOS "WINUSB" GPT "$TARGET_DISK"

# 6. Mount the Windows ISO
echo ""
echo "Mounting Windows ISO..."
MOUNT_OUTPUT=$(hdiutil mount "$ISO_PATH" 2>&1)
ISO_VOLUME=$(echo "$MOUNT_OUTPUT" | grep "/Volumes/" | awk -F'\t' '{print $NF}' | head -1)

if [ -z "$ISO_VOLUME" ] || [ ! -d "$ISO_VOLUME" ]; then
    echo "Error: Failed to mount ISO."
    echo "$MOUNT_OUTPUT"
    exit 1
fi
echo "Mounted at: $ISO_VOLUME"

# 7. Copy files to USB, handle install.wim > 4GB
echo ""
echo "Copying Windows files to USB (this may take several minutes)..."
rsync -avh --progress --exclude='sources/install.wim' "$ISO_VOLUME/" /Volumes/WINUSB/

WIM_FILE="$ISO_VOLUME/sources/install.wim"
if [ -f "$WIM_FILE" ]; then
    WIM_SIZE=$(stat -f%z "$WIM_FILE")
    MAX_FAT32=$((4 * 1024 * 1024 * 1024)) # 4 GB

    if [ "$WIM_SIZE" -gt "$MAX_FAT32" ]; then
        echo ""
        echo "install.wim is $(($WIM_SIZE / 1024 / 1024 / 1024)) GB (> 4 GB) — splitting for FAT32..."
        if command -v wimlib-imagex > /dev/null 2>&1; then
            wimlib-imagex split "$WIM_FILE" /Volumes/WINUSB/sources/install.swm 3800
        else
            echo "Error: wimlib is required to split install.wim."
            echo "Install it with: brew install wimlib"
            hdiutil unmount "$ISO_VOLUME"
            exit 1
        fi
    else
        echo "Copying install.wim (fits in FAT32)..."
        cp "$WIM_FILE" /Volumes/WINUSB/sources/
    fi
fi

# 8. Cleanup
echo ""
echo "Unmounting ISO..."
hdiutil unmount "$ISO_VOLUME"

echo "Ejecting USB..."
diskutil eject "$TARGET_DISK"

echo ""
echo "Done! Your bootable Windows USB is ready."
