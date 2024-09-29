#!/bin/bash

set -eou pipefail

################################################################################
# import_files.sh
#
#   This script "imports" configuration files from the current machine into this 
# project. All files are listed below. For example, if I am using my development
# machine and I decide to update the Codium config files, I can just run this 
# script and it will import $HOME/.config/VSCodium/User/settings.json to the correct
# location.

###################
# files
# 
# all of the data that is fed to the algorithm. each element is a string that 
# itself contains two space-separated strings.
# 
# the first string in each element is the source path (the path on the local machine)
# the second string in each element is the destination path (the path in the appropriate <role>/files directory)
#   the destination path must be the full path, OR YOU DIE
files=(
  "$HOME/.config/VSCodium/User/settings.json roles/codium_config/files/settings.json"
  "$HOME/.config/VSCodium/User/keybindings.json roles/codium_config/files/keybindings.json"

  "$HOME/.bashrc roles/dotfiles/files/.bashrc"
  "$HOME/.inputrc roles/dotfiles/files/.inputrc"
  "$HOME/.vimrc roles/dotfiles/files/.vimrc"
  "$HOME/.zshrc roles/dotfiles/files/.zshrc"

  "$HOME/.config/alacritty.toml roles/dotfiles/files/alacritty.toml"
  # "$HOME/.config/gammastep.conf roles/dotfiles/files/gammastep.conf"
)

################################################################################
# algorithm
################################################################################

for file in "${files[@]}"; do
  # split the string into source and destination
  source_path=$(echo "$file" | awk '{print $1}')
  source_path_absolute=$(realpath $source_path)
  destination_path=$(echo "$file" | awk '{print $2}')

  # check if the source file exists
  if [ ! -f "$source_path_absolute" ]; then
    echo "Error: Source file '$source_path_absolute' does not exist. Skipping..."
    file $source_path_absolute
    continue
  fi

  # check if the destination file exists
  if [ ! -f "$destination_path" ]; then
    echo "Warning: Destination file '$destination_path' does not exist."
    echo "Do you want to proceed with copying '$source_path_absolute' to '$destination_path'? (y/N)"
    read -r user_input

    if [ "$user_input" != "y" ]; then
      echo "Skipping copy for '$source_path_absolute'..."
      continue
    fi
  fi

  # perform the copy operation
  cp "$source_path_absolute" "$destination_path"

  # Check if the copy succeeded
  if [ $? -eq 0 ]; then
    echo "File '$destination_path' was copied."
  else
    echo "Error: Failed to copy '$source_path_absolute' to '$destination_path'."
  fi
done