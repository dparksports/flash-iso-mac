#!/bin/bash
read -p "ISO path: " F; F=$(echo "$F" | sed "s/^'//;s/'$//;s/^\"//" | sed 's/"$//;s/ $//'); read -p "Disk # (e.g. 2): " D
diskutil eraseDisk MS-DOS "WINUSB" GPT /dev/disk$D && M=$(hdiutil mount "$F" | grep "/Volumes/" | awk -F'\t' '{print $NF}' | head -1)
rsync -avh --progress --exclude='sources/install.wim' "$M/" /Volumes/WINUSB/ && wimlib-imagex split "$M/sources/install.wim" /Volumes/WINUSB/sources/install.swm 3800 && hdiutil unmount "$M" && diskutil eject /dev/disk$D && echo "Done."
