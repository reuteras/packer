#!/bin/bash -eux
# Fixes for Kali 2020.1 from https://github.com/NJonesUK/kali-packer-vagrant

# Disable daily apt unattended updates.
echo 'APT::Periodic::Enable "0";' >> /etc/apt/apt.conf.d/10periodic

# Don't require password for kali user
echo "kali        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

# Install git and open-vm-tools
apt -y update
DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confnew" dist-upgrade -yq
apt -y install bc git open-vm-tools haveged

# Fix for login issues related to lack of randomness
# https://bugs.kali.org/view.php?id=4994
systemctl enable haveged

