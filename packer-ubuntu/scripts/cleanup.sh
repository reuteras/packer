#!/bin/bash -eux

# Delete unneeded files.
rm -f /home/malware/*.sh
rm -f /home/malware/linux.iso

# Clean
sudo apt-get -y autoremove
sudo apt-get autoclean
sudo apt-get clean

dd if=/dev/zero of="$HOME/zero" conv=fsync
sleep 1
sync
rm -f "$HOME"/zero

# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
sync
