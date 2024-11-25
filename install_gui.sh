#!/bin/bash

set -eou pipefail

readonly MARK_FILE="/tmp/gui_is_installed"

if [[ -f "$MARK_FILE" ]]; then
  echo "GUI seems to be installed already. Exiting..."
  exit 0
fi

sudo dnf install -y fedora-workstation-repositories
sudo dnf clean all
sudo dnf -y group install "GNOME" || sudo dnf -y group install "GNOME Desktop Environment"
sudo dnf -y install xorg-x11-drv-vesa
sudo systemctl set-default graphical.target

touch $MARK_FILE
