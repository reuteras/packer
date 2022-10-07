#!/bin/bash

cd /home/malware || exit
git clone https://github.com/reuteras/malir.git
cd malir || exit
./install.sh
./tools.sh
