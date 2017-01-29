#!/bin/bash -eux

# Delete unneeded files.
rm -f /home/malware/*.sh
rm -f /home/malware/linux.iso
rm -f /home/malware/.config/autostart/X-Debian-Applications-Terminal-Emulators-lxterminal.desktop

# No release upgrade for this VM
sudo apt-get remove ubuntu-release-upgrader-core ubuntu-release-upgrader-gtk

# Run clean script from remnux-tools
cd remnux-tools
./bin/clean.sh

# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
sync
