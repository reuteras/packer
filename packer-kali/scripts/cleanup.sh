#!/bin/bash -eux

# Delete unneeded files.
sudo rm -f /root/*.sh
sudo rm -f /root/*.iso

# Run clean script from remnux-tools
cd kali-tools
./bin/clean.sh

# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
sync
