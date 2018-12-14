#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 0.1; done

# Figure out primary monitor
PRIMARY=$(xrandr -q | grep " connected primary" | cut -d" " -f1)

# Launch bar1
echo "Primary monitor is $PRIMARY"
MONITOR=$PRIMARY polybar bar1 &

echo "Bars launched..."
