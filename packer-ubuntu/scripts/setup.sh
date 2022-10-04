#!/bin/bash -eux

# Install git
apt-get -yqq update
apt-get -yqq install git open-vm-tools open-vm-tools-desktop screen tmux vim
apt-get -yqq dist-upgrade

# Add malware user to sudoers.
if [[ -d /home/malware ]]; then
    echo "malware        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
else
    echo "remnux        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
fi
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

if [[ -e /etc/update-manager/release-upgrades ]]; then
    sed -i "s/Prompt=lts/Prompt=never/" /etc/update-manager/release-upgrades
fi
