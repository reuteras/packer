#!/bin/bash -eux

# Delete unneeded files.
rm -f "$HOME"/*.sh
rm -f "$HOME"/examples.desktop
rm -f /tmp/remnux-tools.log

# Remove unneeded packages
apt-get remove -y gnome-initial-setup

# Clean
sudo DEBIAN_FRONTEND=noninteractive apt-get -yqq autoremove
sudo apt-get autoclean
sudo apt-get clean

echo "Start zero of disk"
dd if=/dev/zero of="$HOME/zero" conv=fsync
sleep 1
sync
rm -f "$HOME"/zero

# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
sync
