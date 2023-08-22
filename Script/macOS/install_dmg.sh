#!/bin/bash

# Move .app file in dmg to /Application folder

# ------------ Configuration ------------
dmg_url=""
space_required=40 # Required free space (GB)


# Suggest using static dmg_name for installer to prevent having special characters in file name
# For using file name from URL: dmg_name=$(basename $dmg_url)
dmg_name="installer.dmg"
mount_point="/Volumes/installer"
install_log="/tmp/install.log"

# ------------ Check remain space ------------
free_space=$(df -g / | awk 'FNR==2 {print $4}')
if [ "$free_space" -lt $space_required ]; then
    echo "[$(date)] Error: space not enough, required: $space_required GB, remain: $free_space GB" >> $install_log 2>&1
    exit 1
fi

# ------------ Download installer ------------
if [ -e "/tmp/$dmg_name" ]; then
    # Continue
    curl -L -o /tmp/$dmg_name -C - "$dmg_url" >> $install_log 2>&1
    stat=$?
else
    curl -L -o /tmp/$dmg_name "$dmg_url" >> $install_log 2>&1
    stat=$?
fi

# ------------ Breake if download fail ------------
if [ $stat -ne 0 ]; then
    echo "[$(date)] Error: Download fail." >> $install_log 2>&1
    exit 1
fi

# ------------ Extract ------------
echo "[$(date)] Download finish, mounting..." >> $install_log 2>&1
hdiutil attach /tmp/$dmg_name -mountpoint $mount_point >> $install_log 2>&1

app_name=$(basename $mount_point/*.app)
echo "[$(date)] Copying..." >> $install_log 2>&1
cp -R $mount_point/"$app_name" /Applications/"$app_name" >> $install_log 2>&1
cp_stat=$!

# ------------ Un-mount ------------
wait $cp_stat
echo "[$(date)] Copy finish." >> $install_log 2>&1
hdiutil detach $mount_point >> $install_log 2>&1

# ------------ Clean-up ------------
rm /tmp/$dmg_name
echo "[$(date)] Clean-up done, install complete." >> $install_log 2>&1