#!/bin/bash

if [[ $(uname -m) == "aarch64" ]]; then
	if grep "trixie/sid" /etc/debian_version >/dev/null; then
		apt-get install -y ubuntu-desktop firefox
	else
		apt-get install -y ubuntu-desktop plymouth-theme-ubuntu-logo firefox
	fi
else
	if grep "trixie/sid" /etc/debian_version >/dev/null; then
		apt-get install -y ubuntu-desktop grub-gfxpayload-lists firefox
	else
		apt-get install -y ubuntu-desktop plymouth-theme-ubuntu-logo grub-gfxpayload-lists firefox
	fi
fi
