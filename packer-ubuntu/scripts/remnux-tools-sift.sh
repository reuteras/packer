#!/bin/bash -eux

git clone https://github.com/reuteras/remnux-tools.git
cd remnux-tools
echo "## Run: ./bin/setup-sift.sh"
./bin/setup-sift.sh
echo "## Run: make dotfiles"
make dotfiles
echo "## Run: ./bin/install-vmhgfs.sh ~/linux.iso"
./bin/install-vmhgfs.sh ~/linux.iso
