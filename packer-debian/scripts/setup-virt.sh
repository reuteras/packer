#!/bin/bash -eux

sudo apt -y -qq install \
    qemu-system-x86_64 \
    virt-manager

sudo adduser cuckoo libvirt

# Packer
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt update && sudo apt -y -qq install packer

cd || exit
git clone https://github.com/reuteras/packer.git
cd packer || exit
wget -q https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/latest-virtio/virtio-win.iso
