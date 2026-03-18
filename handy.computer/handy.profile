################################################################
# Firejail profile for Handy (https://handy.computer)
#
# Written 03/18/2026 by Lester Hightower and Google Gemini
#
# To be used in conjuction with this /etc/hosts.handy file,
# which allows "Check for updates" to work:
# ---
# $ cat /etc/hosts.handy
# # Used in conjunction with ~/.config/firejail/handy.profile
#
# 127.0.0.1   localhost
# ::1         localhost
#
# # Only allow these for the updater
# 185.199.108.154	objects.githubusercontent.com
# 140.82.112.3		github.com
#
# # GitHub Assets / Content Delivery Network
# 185.199.108.133  raw.githubusercontent.com
# 185.199.108.154  objects.githubusercontent.com
# 140.82.112.6     api.github.com
# 185.199.110.153  release-assets.github.com
# 185.199.110.154  release-assets.githubusercontent.com
# ---
################################################################

# 1. Access to Handy's config and models
noblacklist ${HOME}/.local/share/com.pais.handy
whitelist ${HOME}/.local/share/com.pais.handy

# 2. Manual PulseAudio Access
# Whitelists the actual socket instead of using the 'pulse' command
noblacklist ${HOME}/.config/pulse
whitelist ${HOME}/.config/pulse
# NOTE: ${RUNUSER}/pulse expands to /run/user/${UID}/pulse
whitelist ${RUNUSER}/pulse
env CPAL_ASHARE_BACKEND=pulseaudio

# 3. Whitelist the X11 socket so Handy can 'type' with xdotool
whitelist /tmp/.X11-unix

# 4. Security Baselines
include disable-common.inc
include disable-devel.inc
include disable-interpreters.inc
include disable-programs.inc

# 5. Network Configuration
# 5a. Enable a standard network stack via the default eth0/wlan0 share
netfilter
# 5b. Break DNS
dns 0.0.0.0
# 5c. Provide the jail only the allowed names via a custom hosts file
hosts-file /etc/hosts.handy

# 6. Lock it down
caps.drop all
nonewprivs
noroot
seccomp

