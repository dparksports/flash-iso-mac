#!/bin/bash

echo "======================================"
echo "      Mac Linux USB Flasher           "
echo "     (With Size-Check Safety)         "
echo "======================================"
echo "WARNING: This tool will completely ERASE the selected drive."
echo "Please proceed with extreme caution."
echo ""

# 1. Get the path to the ISO file
read -p "Drag and drop your Linux .iso file here (and press Return): " RAW_ISO_PATH

# Clean up trailing spaces or quotes that Terminal adds during drag-and-drop
ISO_PATH=$(echo "$RAW_ISO_PATH" | sed -e "s/^'//" -e "s/'$//" -e 's/^"//' -e 's/"$//' -e 's/ $//')

if [ ! -f "$ISO_PATH" ]; then
    echo "Error: Could not find the file at $ISO_PATH"
    exit 1
fi

# 2. Show external drives to help prevent selecting the main Mac drive
echo ""
echo "--- Scanning for external drives ---"
diskutil list external
echo "------------------------------------"
echo ""

# 3. Get the target disk number
read -p "Enter the disk NUMBER of your USB drive (e.g., if it says /dev/disk2, just type 2): " DISK_NUM

TARGET_DISK="/dev/disk$DISK_NUM"
TARGET_RDISK="/dev/rdisk$DISK_NUM"

# Verify the user didn't type a non-existent disk
if ! diskutil info "$TARGET_DISK" > /dev/null 2>&1; then
    echo ""
    echo "Error: Disk $TARGET_DISK does not exist. Please check the list and try again."
    exit 1
fi

# 4. NEW: Get and verify the size and name of the selected drive
DRIVE_SIZE=$(diskutil info "$TARGET_DISK" | grep -E "(Disk Size|Total Size)" | head -n 1 | awk -F: '{print $2}' | xargs | cut -d' ' -f1,2)
DRIVE_NAME=$(diskutil info "$TARGET_DISK" | grep "Device / Media Name" | awk -F: '{print $2}' | xargs)

echo ""
echo "======================================"
echo "          DRIVE VERIFICATION          "
echo "======================================"
echo "You have selected: $TARGET_DISK"
echo "Drive Name:        ${DRIVE_NAME:-Unknown}"
echo "Drive Size:        $DRIVE_SIZE"
echo "======================================"
echo ""

# Heuristic warning if the drive is unusually large
if [[ "$DRIVE_SIZE" == *"TB"* ]]; then
    echo "⚠️  WARNING: This drive is measured in Terabytes ($DRIVE_SIZE)."
    echo "This is unusually large for a Linux Live USB. Are you SURE this is not a backup drive?"
    echo ""
fi

# 5. The Point of No Return (Safety Check)
echo "!!! DANGER ZONE !!!"
echo "You are about to completely format and overwrite: $TARGET_DISK"
read -p "Type 'yes' to confirm and proceed: " CONFIRM

if [ "$CONFIRM" != "yes" ]; then
    echo "Operation cancelled. Your drives have not been touched."
    exit 0
fi

# 6. Execute the formatting and flashing
echo ""
echo "Unmounting $TARGET_DISK..."
diskutil unmountDisk "$TARGET_DISK"

echo ""
echo "Writing $ISO_PATH to $TARGET_RDISK..."
echo "You will be prompted for your Mac administrator password to authorize the write."
echo "NOTE: There is no progress bar. This will take 3 to 10 minutes. Please be patient..."

# Run the dd command with sudo
sudo dd if="$ISO_PATH" of="$TARGET_RDISK" bs=1m

echo ""
echo "Ejecting the USB drive safely..."
diskutil eject "$TARGET_DISK"

echo ""
echo "Success! Your bootable Linux USB is ready to use."
