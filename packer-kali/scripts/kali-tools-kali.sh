#!/bin/bash -eux

git clone https://github.com/reuteras/kali-tools.git
echo "Cloning done"
chown -R kali:kali kali-tools
cd kali-tools
./bin/setup.sh
git config --global pull.rebase false
#./bin/install-vmhgfs.sh
