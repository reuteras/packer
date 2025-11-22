#!/bin/bash -eux

git clone https://github.com/reuteras/remnux-tools.git
cd remnux-tools || exit
./bin/setup-arkime.sh
make dotfiles
