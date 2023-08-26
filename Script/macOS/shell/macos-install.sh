#!/bin/sh

# Install macOS system upgrade
# Notice: startosinstall always cause auto-reboot, you might want to put it in custom attribute and trigger when user sign-out

installer_name="Install macOS Monterey.app"
space_required=40 # Required free space (GB)

upgrade_log="/tmp/os_upgrade.log"

if [ -e "/Applications/$installer_name" ]; then
    free_space=$(df -g / | awk 'FNR==2 {print $4}')
    if [ "$free_space" -lt $space_required ]; then
        echo "[$(date)] Error: space not enough, required: $space_required GB, remain: $free_space GB" >> $upgrade_log 2>&1
        exit 1
    else
        echo "[$(date)] System upgrade started" >> $upgrade_log 2>&1
        "/Applications/$installer_name/Contents/Resources/startosinstall" --agreetolicense >> $upgrade_log 2>&1
    fi
else
    echo "[$(date)] Error: Installer not found." >> $upgrade_log 2>&1
    exit 1
fi