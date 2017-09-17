#!/usr/bin/env bash

DESKTOP_IMAGE_ROOT="$HOME/.desktop/image"

ICON="$DESKTOP_IMAGE_ROOT/lock.png"
DSK_BACKGROUND="$DESKTOP_IMAGE_ROOT/desktop.png"
LCK_BACKGROUND="$DESKTOP_IMAGE_ROOT/lock-background.png"

#(( $# )) && { icon=$1; }

# Make a new lockscreen background if one doesn't exist or if the desktop
# background has been replaced
if [ ! -f "$LCK_BACKGROUND" ] || ["$DSK_BACKGROUND" -nt "$LCK_BACKGROUND"]; then
    convert "$DSK_BACKGROUND" -blur 0x2 -grayscale Average -brightness-contrast -20x20 "$LCK_BACKGROUND"
    convert "$LCK_BACKGROUND" "$ICON" -gravity center -composite -matte "$LCK_BACKGROUND"
fi

i3lock -u -i "$LCK_BACKGROUND"
# Can add -u to get rid of feedback!
