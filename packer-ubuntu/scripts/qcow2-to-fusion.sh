#!/usr/bin/env bash
# Convert a Packer QEMU arm64 qcow2 image into a VMware Fusion (Apple Silicon) VM.
#
# Usage: qcow2-to-fusion.sh <output_dir> <vm_name> [memory_mb] [cpus]
#
# Expects <output_dir>/<vm_name>.qcow2 and creates <output_dir>/<vm_name>.vmdk
# and <output_dir>/<vm_name>.vmx. The qcow2 is removed after a successful
# conversion. If vmrun is available a snapshot named "Installed" is taken.

set -euo pipefail

if [[ $# -lt 2 ]]; then
    echo "Usage: $0 <output_dir> <vm_name> [memory_mb] [cpus]" >&2
    exit 1
fi

OUTPUT_DIR="$1"
VM_NAME="$2"
MEMORY="${3:-8192}"
CPUS="${4:-2}"

QCOW2="$OUTPUT_DIR/$VM_NAME.qcow2"
VMDK="$OUTPUT_DIR/$VM_NAME.vmdk"
VMX="$OUTPUT_DIR/$VM_NAME.vmx"
VMRUN="/Applications/VMware Fusion.app/Contents/Library/vmrun"

if [[ ! -f "$QCOW2" ]]; then
    echo "Can't find $QCOW2" >&2
    exit 1
fi

echo "Converting $QCOW2 to $VMDK"
qemu-img convert -p -f qcow2 -O vmdk "$QCOW2" "$VMDK"

echo "Writing $VMX"
cat > "$VMX" << EOF
.encoding = "UTF-8"
config.version = "8"
virtualHW.version = "22"
displayName = "$VM_NAME"
guestOS = "arm-ubuntu-64"
firmware = "efi"
memsize = "$MEMORY"
numvcpus = "$CPUS"
# PCIe root ports as in VMs created by Fusion; without them the NIC gets no slot.
pciBridge0.present = "TRUE"
pciBridge4.present = "TRUE"
pciBridge4.virtualDev = "pcieRootPort"
pciBridge4.functions = "8"
pciBridge5.present = "TRUE"
pciBridge5.virtualDev = "pcieRootPort"
pciBridge5.functions = "8"
pciBridge6.present = "TRUE"
pciBridge6.virtualDev = "pcieRootPort"
pciBridge6.functions = "8"
pciBridge7.present = "TRUE"
pciBridge7.virtualDev = "pcieRootPort"
pciBridge7.functions = "8"
vmci0.present = "TRUE"
hpet0.present = "TRUE"
nvme0.present = "TRUE"
nvme0:0.present = "TRUE"
nvme0:0.fileName = "$VM_NAME.vmdk"
ethernet0.present = "TRUE"
ethernet0.connectionType = "nat"
ethernet0.virtualDev = "vmxnet3"
ethernet0.addressType = "generated"
usb.present = "TRUE"
usb_xhci.present = "TRUE"
svga.present = "TRUE"
mks.enable3d = "TRUE"
tools.syncTime = "TRUE"
annotation = "Built with Packer (QEMU) on $(date '+%Y-%m-%d %H:%M %Z')"
EOF

rm -f "$QCOW2"

if [[ -x "$VMRUN" ]]; then
    echo "Taking snapshot Installed"
    "$VMRUN" -T fusion snapshot "$VMX" Installed
else
    echo "vmrun not found - skipping snapshot."
fi
