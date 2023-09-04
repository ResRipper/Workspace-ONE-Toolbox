#!/bin/sh

# Load schedule task into system and start
# Doc: https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingLaunchdJobs.html

launchctl load /Library/LaunchAgents/com.hubcli.sync.plist
launchctl start com.hubcli.sync