#!/bin/bash
set -e

osascript -e '
tell application "System Preferences"
    activate
    reveal pane id "com.apple.preference.displays"
    delay 1
    tell application "System Events" to click first pop up button of first window of application process "System Preferences" of application "System Events"
    delay 1
    tell application "System Events" to click menu item "ScottPad" of first menu of first pop up button of first window of application process "System Preferences" of application "System Events"
    quit
end tell';