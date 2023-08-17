#!/bin/bash

dmg_url=""

# Suggest using static dmg_name for installer to prevent having special characters in file name
# For using file name from URL: dmg_name=$(basename $dmg_url)
dmg_name="installer.dmg"
mount_point="/Volumes/installer"
install_log="/tmp/install.log"

if [ -e "/tmp/$dmg_name" ]; then
    # Continue
    curl -L -o /tmp/$dmg_name -C - $dmg_url >> $install_log 2>&1
    stat=$?
else
    curl -L -o /tmp/$dmg_name $dmg_url >> $install_log 2>&1
    stat=$?
fi

# Breake if download fail
if [ $stat -ne 0 ]; then
    exit 1
fi

# Extract
hdiutil attach /tmp/$dmg_name -mountpoint $mount_point >> $install_log 2>&1
app_name=$(basename $mount_point/*.app)
cp -R $mount_point/$app_name /Applications/$app_name >> $install_log 2>&1
cp_stat=$!

# Un-mount
wait $cp_stat
hdiutil detach $mount_point >> $install_log 2>&1

# Clean-up
rm /tmp/$dmg_name