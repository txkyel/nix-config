#!/bin/sh

# Qtile like workspace changing behaviour
# Based on https://github.com/Jareng/dotfiles/blob/7cf34f020e18f8b5bb5a977baac1f1412a177d7d/.config/hypr/scripts/workspace_qtile.sh

monitors="$(hyprctl monitors -j)"

# Workspace must be selected for this command to work
if [ "$1" = "" ]; then
    echo -e "Command format:\n\tWorkspace.sh <workspace number>"
    exit 1
fi

targetworkspace="$1"

prevworkspace_temp="/tmp/hypr/prevworkspace_temp"
prevworkspace="$(cat "$prevworkspace_temp")"
currworkspace="$(echo "$monitors" | jq '.[] | select(.focused==true) | .activeWorkspace.id')"

# Save current workspace before switching to new
# Exit if current workspace is target workspace
if [ "$targetworkspace" != "$currworkspace" ]; then
	echo "$currworkspace" >"$prevworkspace_temp"
fi

# Switch to previous workspace and quit
if [ "$targetworkspace" == "prev" ]; then
	hyprctl dispatch workspace "$prevworkspace"
	exit 0
fi

activemonitor="$(echo "$monitors" | jq '.[] | select(.focused==true) | .id')"
passivemonitor="$(echo "$monitors" | jq '.[] | select(.focused==false) | .id')"
passiveworkspace="$(echo "$monitors" | jq '.[] | select(.focused==false) | .activeWorkspace.id')"

if [ $2 = "switch" ]; then
    hyprctl dispatch movetoworkspacesilent "$targetworkspace"
fi


if [ "$targetworkspace" = "$passiveworkspace" ] && [ "$activemonitor" != "$passivemonitor" ]; then
	hyprctl dispatch swapactiveworkspaces "$activemonitor" "$passivemonitor"
else
	hyprctl dispatch moveworkspacetomonitor "$targetworkspace" "$activemonitor"
	hyprctl dispatch workspace "$targetworkspace"
fi

exit 0
