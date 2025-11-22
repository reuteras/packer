#!/bin/bash -eux
sudo apt-get -y -qq install \
    curl \
    open-vm-tools-desktop \
    vim \
    vim-doc \
    vim-scripts \
    wget

cd /tmp || exit
wget -q -O google-chrome-stable_current_amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
# shellcheck disable=SC2024
sudo dpkg -i google-chrome-stable_current_amd64.deb
# shellcheck disable=SC2024
sudo apt -qq -f -y install
rm -f google-chrome-stable_current_amd64.deb
