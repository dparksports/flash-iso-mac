#!/bin/bash
read -p "ISO path: " F; F=$(echo "$F" | sed "s/^'//;s/'$//;s/^\"//" | sed 's/"$//;s/ $//')
read -p "Disk # (e.g. 2): " D
diskutil unmountDisk /dev/disk$D && sudo dd if="$F" of=/dev/rdisk$D bs=1m && diskutil eject /dev/disk$D && echo "Done."
