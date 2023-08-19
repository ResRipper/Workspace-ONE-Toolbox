#!/bin/sh

# Notice: startosinstall always cause auto-reboot, you might want to put it in custom attribute and trigger when user sign-out

installer_name="Install macOS Monterey.app"

if [ -e "/Applications/$installer_name" ]; then
    "/Applications/$installer_name/Contents/Resources/startosinstall" --agreetolicense >> /tmp/os_upgrade.log 2>&1
else
    exit 0
fi