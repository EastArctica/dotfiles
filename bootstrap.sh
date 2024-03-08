#!/bin/bash

link() {
	# Source is $1, Target is $2
	if [ -f "$1" ]; then
		# Source is a file
		local target_path="$2/$(basename $1)"
		if [ -L "$target_path" ] && [ "$(readlink -f "$target_path")" = "$(realpath "$1")" ]; then
			echo "$target_path already linked"
		elif [ -L "$target_path" ]; then
			echo "Failed to link $target_path, already points to $(readlink -f "$target_path")"
		elif [ -e "$target_path" ]; then
			echo "Failed to link $target_path, a file already exists"
		else
			echo "Linking file $1 to $target_path"
			ln -s "$1" "$target_path"
		fi
	elif [ -d "$1" ]; then
		# Source is a directory
		local target_path="$2/$(basename $1)"
		if [ -L "$target_path" ] && [ "$(readlink -f "$target_path")" = "$(realpath "$1")" ]; then
			echo "$target_path already linked"
		elif [ -L "$target_path" ]; then
			echo "Failed to link $target_path, already points to $(readlink -f "$target_path")"
		elif [ -e "$target_path" ]; then
			echo "Failed to link $target_path, a directory already exists"
		else
			echo "Linking directory $1 to $target_path"
			ln -s "$1" "$target_path"
		fi
	else
		echo "Source $1 does not exist"
	fi
}


link "$PWD/.gitconfig" "$HOME"
link "$PWD/.gtkrc-2.0" "$HOME"

link "$PWD/hypr/" "$HOME/.config"
link "$PWD/waybar/" "$HOME/.config"
link "$PWD/pipes-rs/" "$HOME/.config"
link "$PWD/gtk-3.0/" "$HOME/.config"
link "$PWD/cava/" "$HOME/.config"
link "$PWD/kitty/" "$HOME/.config"
link "$PWD/wofi/" "$HOME/.config"

