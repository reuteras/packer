#!/bin/bash -eux

# Install git
DEBIAN_FRONTEND=noninteractive apt-get -y update
DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade
DEBIAN_FRONTEND=noninteractive apt-get -y install sudo

# Add cuckoo user to sudoers.
echo "cuckoo        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
echo "user          ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
