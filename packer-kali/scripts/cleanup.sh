#!/bin/bash -eux

# Delete unneeded files.
rm -f /root/*.sh
rm -f /root/*.iso

# Run clean script from remnux-tools
cd kali-tools
./bin/clean.sh

# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
sync
