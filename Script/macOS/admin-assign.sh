#!/bin/bash

# Assign current user to admin group

loggedInUser=$(/usr/bin/stat -f%Su /dev/console)

# Remember to add IT admin !
if [ $loggedInUser == "root" ] || [ $loggedInUser == "_mbsetupuser" ] || [ $loggedInUser == "itadmin" ]; then
    exit 0
fi

dseditgroup -o edit -a $loggedInUser -t user admin
