#!/bin/bash

target_workspace=$1

# Find discord names, discord -> discord-canary -> discord-ptb
discord_bin=""

if command -v discord; then
	discord_bin="discord"
elif command -v discord-canary; then
	discord_bin="discord-canary"
elif command -v discord-ptb; then
	discord_bin="discord-ptb"
fi

if [ "$discord_bin" = "" ]; then
	echo "Discord is not installed."
	exit 1
fi

moveToWorkspace() {
	target_address=$1
	workspace=$2
	# 0.1 *could* be too fast depending on your computer. Perhaps a better way would be
	# to repeatedly put it in the workspace until hyprctl clients agrees.
	sleep 0.1
	hyprctl dispatch movetoworkspacesilent $workspace,address:$1
}

# openwindow>>windowAddress,workspaceID,class,title
handle() {
	case $1 in
		openwindow*) {
			address=$(echo "$1" | cut -d',' -f1 | cut -d'>' -f3)
			class=$(echo "$1" | cut -d',' -f3)
			title=$(echo "$1" | cut -d',' -f4)
			if [ "$class" = "discord" ] || [ "$title" = "Discord Updater" ]; then
				moveToWorkspace "0x$address" "$target_workspace"
			fi

			if [ "$title" = "$discord_title" ]; then
				exit 0
			fi
		};;
	esac
}

2>/dev/null 1>&2 $discord_bin &
socat -U - UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done

