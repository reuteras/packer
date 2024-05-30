#!/bin/bash

cd /home/user || exit
git clone https://github.com/reuteras/malir.git
cd malir || exit
./install.sh
./tools.sh
