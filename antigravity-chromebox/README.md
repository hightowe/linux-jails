# antigravity-chromebox.sh
First written 02/03/2026 by Lester Hightower as antigravity-chromebox.sh,
but it should be easy to adapt this to environments other than Antigravity
by just editing the firejail launch line to change the --whitelist options
as needed for different environments.

## Purpose
My purpose in writing this was two fold, and in this order of importance:
 1. I increasingly allow Antigravity to use a web browser independently
    while I work on other things and, with that, I grew increasingly
    frustrated by how my mouse and keyboard focus were stolen every time
    that Antigravity opened a new tab in its browser. This script is my
    resolution for that.
 2. Putting the Xephyr swallowed google-chrome into a firejail adds a layer
    of security for essentially no cost, so why not.

## Limited testing...
Before I posted this to github I used it for a little over a week and so
it seems good, but that is the extent of the testing.

## Requirements on Ubuntu-based Linux distros:
1. xserver-xephyr
2. openbox
3. google-chrome-stable
4. firejail
