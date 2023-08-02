#!/bin/bash -eux                                                                                                                                                                                                                              
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -qq install \
    curl \
    fuse \
    exfat-fuse \
    git \
    vim \
    vim-doc \
    vim-scripts \
    zip

#    vim-scripts \
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -qq install open-vm-tools-desktop

