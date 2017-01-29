#!/bin/bash -eux

git clone https://github.com/reuteras/remnux-tools.git
cd remnux-tools
./bin/setup-sift.sh
make dotfiles
./bin/install-vmhgfs.sh ~/linux.iso
