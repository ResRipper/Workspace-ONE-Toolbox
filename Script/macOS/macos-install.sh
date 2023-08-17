#!/bin/sh

installer_name="Install macOS Monterey.app"

if [ -e "/Applications/$installer_name" ]; then
    "/Applications/$installer_name/Contents/Resources/startosinstall" --agreetolicense --forcequitapps >> /tmp/os_upgrade.log 2>&1
else
    exit 0
fi