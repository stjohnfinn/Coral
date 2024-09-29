#!/bin/bash

set -eou pipefail

################################################################################
# import_files.sh
#
#   This script "imports" configuration files from the current machine into this 
# project. All files are listed below. For example, if I am using my development
# machine and I decide to update the Codium config files, I can just run this 
# script and it will import ~/.config/VSCodium/User/settings.json to the correct
# location.

###################
# files
# 
# all of the data that is fed to the algorithm. each element is a string that 
# itself contains two space-separated strings.
# 
# the first string in each element is the source path (the path on the local machine)
# the second string in each element is the destination path (the path in the appropriate <role>/files directory)
files=(
  "~/.config/VSCodium/User/settings.json roles/codium_config/files/"
  "~/.config/VSCodium/User/keybindings.json roles/codium_config/files/"

  "~/.bashrc roles/dotfiles/files/"
  "~/.inputrc roles/dotfiles/files/"
  "~/.vimrc roles/dotfiles/files/"
  "~/.zshrc roles/dotfiles/files/"

  "~/.config/alacritty.yml roles/dotfiles/files/"
  "~/.config/gammastep.conf roles/dotfiles/files/"
)

for file in "${files[0]}"; do
  # split the string into source and destination
  source_path=$(echo "$file" | awk '{print $1}')
  destination_path=$(echo "$file" | awk '{print $2}')

  # check if the source file exists
  if [ ! -f "$source_path" ]; then
    echo "Error: Source file '$source_path' does not exist. Skipping..."
    continue
  fi

  # check if the destination file exists
  if [ ! -f "$destination_path" ]; then
    echo "Warning: Destination file '$destination_path' does not exist."
    echo "Do you want to proceed with copying '$source_path' to '$destination_path'? (y/N)"
    read -r user_input

    if [ "$user_input" != "y" ]; then
      echo "Skipping copy for '$source_path'..."
      continue
    fi
  fi

  # perform the copy operation
  cp "$source_path" "$destination_path"

  # Check if the copy succeeded
  if [ $? -eq 0 ]; then
      # Check if the file was changed by comparing source and destination
      if cmp -s "$source_path" "$destination_path"; then
          # Files are identical, so no change occurred
          echo "File '$destination_path' was unchanged."
      else
          # Files differ, so it was changed
          echo "File '$destination_path' was changed."
      fi
  else
      echo "Error: Failed to copy '$source_path' to '$destination_path'."
  fi
done