#!/bin/bash -eux
# Make networking independent of the NIC name for Debian-based guests built
# with QEMU (virtio-net, e.g. enp0s1) and run in VMware Fusion (vmxnet3, e.g.
# enp2s0). The Debian installer writes the QEMU NIC name to
# /etc/network/interfaces, which does not exist in Fusion.
#
# Changes only config files; the running network is left alone so the Packer
# SSH session is not interrupted.

# Keep only loopback (and any sourced snippets) in /etc/network/interfaces.
if [[ -f /etc/network/interfaces ]]; then
    cp /etc/network/interfaces /etc/network/interfaces.installer
    cat > /etc/network/interfaces << 'EOF'
# The installer's NIC config was removed so that the VM works with any NIC
# name. Original saved as /etc/network/interfaces.installer.
source /etc/network/interfaces.d/*

auto lo
iface lo inet loopback
EOF
fi

if dpkg-query -W -f='${Status}' network-manager 2>/dev/null | grep -q "install ok installed"; then
    # NetworkManager manages ethernet devices not configured by ifupdown.
    echo "NetworkManager installed - it will manage all ethernet NICs."
else
    echo "NetworkManager not installed - using systemd-networkd for en* NICs."
    # resolved takes DNS from DHCP; otherwise resolv.conf keeps QEMU's 10.0.2.3.
    DEBIAN_FRONTEND=noninteractive apt-get -y -qq install systemd-resolved
    mkdir -p /etc/systemd/network
    cat > /etc/systemd/network/50-all-en.network << 'EOF'
[Match]
Name=en*

[Network]
DHCP=yes
EOF
    systemctl enable systemd-networkd.service
fi
