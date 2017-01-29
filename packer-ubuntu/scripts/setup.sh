#!/bin/bash -eux

# Install git
apt-get -y update
apt-get -y install git

# Add malware user to sudoers.
echo "malware        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
