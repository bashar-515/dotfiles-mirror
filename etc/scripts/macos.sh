#!/bin/bash

set -euo pipefail

osascript -e 'tell application "System Settings" to quit'

navigate_desktops_using_ctrl() {
  local keycodes=(18 19 20 21 23 22 26 28 25 29)

  for i in {0..9}; do
    hotkey_id=$((118 + i))
    keycode=${keycodes[$i]}
    defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add $hotkey_id \
      "<dict><key>enabled</key><true/><key>value</key><dict><key>type</key><string>standard</string><key>parameters</key><array><integer>65535</integer><integer>${keycode}</integer><integer>262144</integer></array></dict></dict>"
  done

  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 79 \
    "<dict><key>enabled</key><true/><key>value</key><dict><key>type</key><string>standard</string><key>parameters</key><array><integer>65535</integer><integer>123</integer><integer>8650752</integer></array></dict></dict>"

  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 81 \
    "<dict><key>enabled</key><true/><key>value</key><dict><key>type</key><string>standard</string><key>parameters</key><array><integer>65535</integer><integer>124</integer><integer>8650752</integer></array></dict></dict>"

  /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
}

dock() {
  # automatically rearrange spaces based on most recent use
  defaults write com.apple.dock mru-spaces -bool false
  
  # show suggested and recent apps in dock
  defaults write com.apple.dock show-recents -bool false

  # automatically hide and show the dock
  defaults write com.apple.dock autohide -bool true

  killall Dock
}

finder() {
  # show path bar
  defaults write com.apple.finder ShowPathbar -bool true

  # show status bar
  defaults write com.apple.finder ShowStatusBar -bool true

  killall Finder
}

navigate_desktops_using_ctrl

# slightly dim the display on battery
sudo pmset -b lessbright 0

# adjust keyboard brightness in lowlight
sudo /usr/libexec/PlistBuddy -c "Set :KeyboardBacklight:KeyboardBacklightABEnabled 0" /private/var/root/Library/Preferences/com.apple.CoreBrightness.plist

# show scroll bars - always
defaults write -g AppleShowScrollBars -string "Always"

# click in the scroll bar to - jump to the spot that's clicked
defaults write -g AppleScrollerPagingBehavior -bool true

# play sound on startup
sudo nvram StartupMute=%01

# prevent automatic sleeping on power adapter when the display is off
sudo pmset -c sleep 0

# play user interface sound effects
defaults write -g com.apple.sound.uiaudio.enabled -bool false

dock

finder
