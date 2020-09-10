#!/bin/bash -eux

# Delete unneeded files.
sudo rm -f /home/kali/*.sh
sudo rm -f /home/kali/*.iso

# Run clean script from remnux-tools
cd kali-tools
./bin/clean.sh

# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
sync
