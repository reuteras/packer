#!/bin/bash -eux
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -qq install \
    curl \
    git \
    vim \
    vim-scripts \
    zip

sudo DEBIAN_FRONTEND=noninteractive apt-get -y -qq install open-vm-tools-desktop

