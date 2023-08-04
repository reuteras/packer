#!/bin/bash -eux                                                                                                                                                                                                                              
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -qq install \
    curl \
    git \
    vim \
    vim-doc \
    vim-scripts \
    zip \
    fuse \
    exfat-fuse

sudo DEBIAN_FRONTEND=noninteractive apt-get -y -qq install open-vm-tools-desktop

