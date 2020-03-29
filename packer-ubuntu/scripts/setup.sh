#!/bin/bash -eux

# Install git
apt-get -yqq update
apt-get -yqq install git open-vm-tools open-vm-tools-desktop vim
apt-get -yqq dist-upgrade

# Add malware user to sudoers.
echo "malware        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
