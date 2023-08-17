#!/bin/bash

# Put this in customize attribute

# User name
name="itadmin"
# Full name
fullname="IT Admin"
# Password
passwd=""
# UID
user_id=2000
# Login shell
default_shell="/bin/zsh"

# Delete if admin account exist
userList=$(/usr/bin/dscl . list /Users)
for user in ${userList}; do
	if [ $user = $name ]; then
		sudo dscl . -delete "/Users/$name"
	fi
done

# Create admin
sudo dscl . -create "/Users/$name" IsHidden 1
sudo dscl . -create "/Users/$name" UserShell $default_shell
sudo dscl . -create "/Users/$name" RealName $fullname
sudo dscl . -create "/Users/$name" UniqueID $user_id
sudo dscl . -create "/Users/$name" PrimaryGroupID 80
sudo dscl . -create "/Users/$name" NFSHomeDirectory "/var/$name"
sudo dscl . -passwd "/Users/$name" $passwd
sudo dscl . -append /Groups/admin GroupMembership $name
