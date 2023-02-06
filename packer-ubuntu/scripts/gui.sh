#!/bin/bash

if [[ $(uname -m) == "aarch64" ]]; then
    apt-get install -yqq ubuntu-desktop plymouth-theme-ubuntu-logo firefox
else
    apt-get install -yqq ubuntu-desktop plymouth-theme-ubuntu-logo grub-gfxpayload-lists firefox
fi

