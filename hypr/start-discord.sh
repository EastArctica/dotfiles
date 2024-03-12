#!/bin/bash

target_workspace=$1

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
			if [ "$title" = "Discord" ] || [ "$title" = "Discord Updater" ]; then
				moveToWorkspace "0x$address" "$target_workspace"
			fi

			if [ "$title" = "Discord" ]; then
				exit 0
			fi
		};;
	esac
}

2>/dev/null 1>&2 discord &
socat -U - UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done

