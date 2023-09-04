#!/bin/bash

# Put this in customize attribute

# User name
name="itadmin"
# Full name
fullname="IT Admin"
# Password
passwd=""
# UID
uid=501
# Login shell
default_shell="/bin/zsh"

# ------------ Delete if admin account exist ------------
# Check conflict UID
if id $uid; then
    username=$(id $uid | awk '{print $1}' | awk -F '[()]' '{print $2}')
    dscl . -delete "/Users/$username"
fi
# Check conflict Username
user_list=$(dscl . list /Users)
for username in $user_list; do
    if [ "$username" = $name ]; then
        sudo dscl . -delete "/Users/$username"
    fi
done

# ------------ Create admin ------------
sudo dscl . -create "/Users/$name" IsHidden 1
sudo dscl . -create "/Users/$name" UserShell $default_shell
sudo dscl . -create "/Users/$name" RealName "$fullname"
sudo dscl . -create "/Users/$name" UniqueID $uid
sudo dscl . -create "/Users/$name" PrimaryGroupID 80
sudo dscl . -create "/Users/$name" NFSHomeDirectory "/var/$name"
sudo dscl . -passwd "/Users/$name" "$passwd"
sudo dscl . -append /Groups/admin GroupMembership $name
