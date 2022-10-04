#!/bin/bash
# Script for general user settings in virtual machines.

[[ ! -d ~/bin ]] && mkdir ~/bin
[[ ! -d ~/src ]] && mkdir ~/src

git clone https://github.com/reuteras/vmbin.git ~/src/vmbin
cp ~/src/vmbin/* ~/bin
rm ~/bin/README.md ~/bin/LICENSE
