#!/bin/bash

# Remove current user's admin privileage

loggedInUser=$(/usr/bin/stat -f%Su /dev/console)

# Remember to add IT admin !
if [ $loggedInUser == "root" ] || [ $loggedInUser == "_mbsetupuser" ] || [ $loggedInUser == "itadmin" ]; then
    exit 0
fi

dseditgroup -o edit -d $loggedInUser -t user admin
