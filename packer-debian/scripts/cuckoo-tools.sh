#!/bin/bash -eux

git clone https://github.com/reuteras/cuckoo-tools.git
cd cuckoo-tools
./bin/setup.sh
make
