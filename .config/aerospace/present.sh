#!/bin/bash
# Send the focused window to workspace P, float it, and center it at 80% of the
# main screen, capped at MAX_W x MAX_H.
MAX_W=1600
MAX_H=1000

APP=$(aerospace list-windows --focused --format '%{app-name}')
[ -z "$APP" ] && exit 1

aerospace move-node-to-workspace P
aerospace workspace P
aerospace layout floating
sleep 0.2

read -r SX SY SW SH < <(osascript -e 'tell application "Finder" to get bounds of window of desktop' | tr -d ',' | awk '{print $1, $2, $3-$1, $4-$2}')
W=$((SW * 80 / 100)); [ "$W" -gt "$MAX_W" ] && W=$MAX_W
H=$((SH * 80 / 100)); [ "$H" -gt "$MAX_H" ] && H=$MAX_H
X=$((SX + (SW - W) / 2))
Y=$((SY + (SH - H) / 2))

osascript <<OSA
tell application "System Events"
    tell (first process whose frontmost is true)
        set position of window 1 to {$X, $Y}
        set size of window 1 to {$W, $H}
    end tell
end tell
OSA
