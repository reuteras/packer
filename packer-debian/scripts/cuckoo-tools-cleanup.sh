#!/bin/bash -eux

# Delete unneeded files.
rm -f /home/cuckoo/*.sh
rm -f /home/cuckoo/linux.iso

# Run clean script from remnux-tools
cd cuckoo-tools
./bin/clean.sh

# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
sync
