#!/bin/bash

#Remove existing configuration profile for testing
/usr/bin/profiles -R -p com.apple.commonassessmentsettings.1

#Set $LAST_USER
LAST_USER=$(defaults read /Library/Preferences/com.apple.loginwindow.plist lastUserName)

#Quit System Preferences using Apple Script
/usr/bin/osascript -e 'tell application "System Preferences" to quit'

#Make backup current system dock preferences
/usr/bin/rsync /Users/"$LAST_USER"/Library/Preferences/com.apple.dock.plist /Users/"$LAST_USER"/Documents/PrefBackup/Dock

#Remove current system preferences
/bin/rm -f /Users/"$LAST_USER"/Library/Preferences/com.apple.AppleMultitouchMouse.plist
/bin/rm -f /Users/"$LAST_USER"/Library/Preferences/com.apple.AppleMultitouchTrackpad.plist
/bin/rm -f /Users/"$LAST_USER"/Library/Preferences/com.apple.dock.plist
/bin/rm -f /Users/"$LAST_USER"/Library/Preferences/com.apple.symbolichotkeys.plist
/bin/rm -f /Users/"$LAST_USER"/Library/Preferences/.GlobalPreferences.plist