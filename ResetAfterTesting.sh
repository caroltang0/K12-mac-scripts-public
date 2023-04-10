#!/bin/bash

#Remove existing configuration profile for testing
/usr/bin/profiles -R -p com.apple.commonassessmentsettings.1

#Set $LAST_USER
LAST_USER=$(defaults read /Library/Preferences/com.apple.loginwindow.plist lastUserName)

#Quit System Preferences using Apple Script
/usr/bin/osascript -e 'tell application "System Preferences" to quit'

#Backup current system preferences
/usr/bin/rsync -rv /Users/"$LAST_USER"/Library/Preferences /Users/"$LAST_USER"/Documents/PrefBackup

#Remove current system preferences
/bin/rm -f /Users/"$LAST_USER"/Library/Preferences/com.apple.AppleMultitouchMouse.plist
/bin/rm -f /Users/"$LAST_USER"/Library/Preferences/com.apple.AppleMultitouchTrackpad.plist
/bin/rm -f /Users/"$LAST_USER"/Library/Preferences/com.apple.dock.plist
/bin/rm -f /Users/"$LAST_USER"/Library/Preferences/com.apple.symbolichotkeys.plist
/bin/rm -f /Users/"$LAST_USER"/Library/Preferences/.GlobalPreferences.plist

#Rsync payload default plists to user's Preferences folder
/usr/bin/rsync -rv --progress /usr/local/csbplist/defaults/com.apple.AppleMultitouchMouse.plist /Users/"$LAST_USER"/Library/Preferences/
/usr/bin/rsync -rv --progress /usr/local/csbplist/defaults/com.apple.AppleMultitouchTrackpad.plist /Users/"$LAST_USER"/Library/Preferences/
/usr/bin/rsync -rv --progress /Users/"$LAST_USER"/Documents/PrefBackup/Dock/com.apple.dock.plist /Users/"$LAST_USER"/Library/Preferences/
/usr/bin/rsync -rv --progress /usr/local/csbplist/defaults/com.apple.symbolichotkeys.plist /Users/"$LAST_USER"/Library/Preferences/
/usr/bin/rsync -rv --progress /usr/local/csbplist/defaults/com.apple.universalaccess.plist /Users/"$LAST_USER"/Library/Preferences/
/usr/bin/rsync -rv --progress /usr/local/csbplist/defaults/.GlobalPreferences.plist /Users/"$LAST_USER"/Library/Preferences/

#Modify owner of newly replaced .plist preference files
/usr/sbin/chown $LAST_USER /Users/"$LAST_USER"/Library/Preferences/.GlobalPreferences.plist
/usr/sbin/chown $LAST_USER /Users/"$LAST_USER"/Library/Preferences/com.apple.AppleMultitouchMouse.plist
/usr/sbin/chown $LAST_USER /Users/"$LAST_USER"/Library/Preferences/com.apple.AppleMultitouchTrackpad.plist
/usr/sbin/chown $LAST_USER /Users/"$LAST_USER"/Library/Preferences/com.apple.dock.plist
/usr/sbin/chown $LAST_USER /Users/"$LAST_USER"/Library/Preferences/com.apple.symbolichotkeys.plist


#Apple Script for good measure 
osascript <<EOF
tell application "System Preferences"
	reveal anchor "keyboardTab" of pane "com.apple.preference.keyboard"
end tell

EOF

#defaults read for 2nd good measure
/usr/bin/defaults read /Users/"$LAST_USER"/Library/Preferences/.GlobalPreferences.plist
/usr/bin/defaults read /Users/"$LAST_USER"/Library/Preferences/com.apple.AppleMultitouchMouse.plist
/usr/bin/defaults read /Users/"$LAST_USER"/Library/Preferences/com.apple.AppleMultitouchTrackpad.plist
/usr/bin/defaults read /Users/"$LAST_USER"/Library/Preferences/com.apple.dock.plist
/usr/bin/defaults read /Users/"$LAST_USER"/Library/Preferences/com.apple.symbolichotkeys.plist


/usr/bin/killall cfprefsd
/usr/bin/killall Dock
/usr/bin/killall Finder
