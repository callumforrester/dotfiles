#!/bin/bash
# Copyright 2018 - Anthony Wharton
# battery-warn.sh
# Keeps track of battery percentage, sending a notificatino to the system when
# power is low.

# Updates the internal state when battery level decreases whilst "Discharging".
# Resets the state if not discharging (i.e. charging/full).
# Takes one argument:
#   $1 - The new state, where the states are:
#          + 0: 0-5% battery
#          + 1: 6-15% battery
#          + 2: 16-25% battery
#          + 3: >25% battery
# Return status is successfull when the new status should trigger a system
# notification.
function update_state
{
	bat_status=$(cat /sys/class/power_supply/BAT0/status)
	old_state=$(tail -n 1 "$0")
	if [[ ${bat_status}  = "Discharging" && ${old_state} > $1 ]] || \
	   [[ ${bat_status} != "Discharging" ]]; then
		# Replace last line of file, preserving sym-link if needed
		# (sed in place does not seem to do this)
		if [[ -L $0 ]]; then
			# Put all but last link in tmp file
			head -n -1 "$0" > /tmp/tmp-bat-warn
			# Go to the directory of the symlinked script (if the
			# link is relative)
			cd $(dirname "$0")
			# Go to the original files directory
			cd $(dirname $(readlink "$0"))
			# Copy the tmp file (minus last line) into the original file
			cp /tmp/tmp-bat-warn $(basename $(readlink "$0"))
			# Add new last line to the file
			echo "$1" >> "$0"
			# Remove tmp file
			rm /tmp/tmp-bat-warn
		else
			# Remove last line of file in-place
			sed -i '$ d' "$0"
			# Add new last line to the file
			echo "$1" >> "$0"
		fi
	fi
	[[ ${bat_status} = "Discharging" && ${old_state} > $1 ]]
}

# Enable extended glob support
shopt -s extglob

bat_capacity=$(cat /sys/class/power_supply/BAT0/capacity)

case ${bat_capacity} in
	# 0-5% battery
	*(0)[0-5])
		update_state 0 && notify-send        \
			--urgency=critical           \
			"Critical Power Alarm"       \
			"Now in the last 5% of battery capacity. System will hibernate shortly."
		;;
	# 6-15% battery
	*(0)[6-9]|*(0)1[0-5])
		update_state 1 && notify-send        \
			--urgency=critical           \
			"Power Alarm"                \
			"Now in the last 15% of battery capacity."
		;;
	# 16-25% battery
	*(0)1[6-9]|*(0)2[0-5])
		update_state 2 && notify-send        \
			--urgency=normal             \
			"Power Alarm"                \
			"Now in the last 25% of battery capacity."
		;;
	# >25% battery
	*)
		update_state 3
		;;
esac

exit 0

3
