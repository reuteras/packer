#!/bin/bash -eux

# Install git
apt-get -y update
apt-get -y install git sudo

# Add cuckoo user to sudoers.
echo "cuckoo        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
