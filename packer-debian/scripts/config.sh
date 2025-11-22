#!/bin/bash

echo "xrandr --output Virtual1 --mode 1440x900 --rate 60" > /home/cuckoo/.xprofile
# dconf write /org/compiz/profiles/unity/plugins/core/outputs "['1440x900+0+0']"
