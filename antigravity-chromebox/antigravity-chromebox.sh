#!/bin/bash

##############################################################################
# First written 02/03/2026 by Lester Hightower as antigravity-chromebox.sh,
# but it should be easy to adapt this to environments other than Antigravity
# by just editing the firejail launch line to change the --whitelist options
# as needed for different environments.
#
# My purpose in writing this was two fold, and in this order of importance:
#  1. I increasingly allow Antigravity to use a web browser independently
#     while I work on other things and, with that, I grew increasingly
#     frustrated by how my mouse and keyboard focus were stolen every time
#     that Antigravity opened a new tab in its browser. This script is my
#     resolution for that.
#  2. Putting the Xephyr swallowed google-chrome into a firejail adds a layer
#     of security for essentially no cost, so why not.
#
# Before I posted this to github I used it for a little over a week and so
# it seems good, but that is the extent of the testing.
#
# Requirements on Ubuntu-based Linux distros:
#  1. xserver-xephyr
#  2. openbox
#  3. google-chrome-stable
#  4. firejail
##############################################################################

# Define the display and resolution
TARGET_DISPLAY=":5"
RESOLUTION="1440x900"

echo "Starting dedicated Xephyr session on $TARGET_DISPLAY..."

# Start Xephyr in the background and capture its Process ID (PID)
Xephyr "$TARGET_DISPLAY" -ac -br -screen $RESOLUTION &
XEPHYR_PID=$!

# Wait briefly for Xephyr to initialize
sleep 1

# Launch the Openbox (window manager) into that display
DISPLAY="$TARGET_DISPLAY" openbox &

# Launch Chrome into that display
# We DO NOT use '&' here. We want the script to pause here
# and wait until you (or Antigravity) close the browser.
#DISPLAY="$TARGET_DISPLAY" google-chrome --password-store=basic --no-first-run "$@"
DISPLAY="$TARGET_DISPLAY" firejail --whitelist=~/.gemini/antigravity --whitelist=~/.gemini/antigravity-browser-profile --whitelist=~/Downloads google-chrome --password-store=basic --no-first-run "$@"

# When Chrome closes and the script resumes, kill Xephyr.
echo "Browser closed. Terminating sandbox..."
kill $XEPHYR_PID

