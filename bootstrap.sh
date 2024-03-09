#!/bin/bash

link() {
	# Source is $1, Target is $2
	# Source is a directory
	local target_path="$2/$(basename $1)"
	if [ -L "$target_path" ] && [ "$(readlink -f "$target_path")" = "$(realpath "$1")" ]; then
		echo "$target_path already linked"
	elif [ -L "$target_path" ]; then
		echo "Failed to link $target_path, already points to $(readlink -f "$target_path")"
	elif [ -e "$target_path" ]; then
		echo "Failed to link $target_path, already exists as a non-symlink"
	else
		echo "Linking $1 to $target_path"
		ln -s "$1" "$target_path"
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
link "$PWD/nvim/" "$HOME/.config"
link "$PWD/dunst/" "$HOME/.config"
link "$PWD/swaylock/swaylock/" "$HOME/.config"

# NeoVim
paru --needed -S neovim-nvim-treesitter
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
link "$PWD/nvim/" "$HOME/.config"

