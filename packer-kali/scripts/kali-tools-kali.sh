#!/bin/bash -eux

git clone https://github.com/reuteras/kali-tools.git
echo "Cloning done"
cd kali-tools
./bin/setup.sh
#./bin/install-vmhgfs.sh
