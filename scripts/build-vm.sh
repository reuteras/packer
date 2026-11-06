#!/usr/bin/env bash
# Build a VM with packer + VMware Workstation Pro, move it to $VM_DIR and set up shared folders.
# Run from a packer-* folder (the just recipes do this), e.g.:
#   ../scripts/build-vm.sh debian debian Debian_64-bit
set -euo pipefail

if [[ $# -ne 3 ]]; then
    echo "Usage: $0 <base> <conf> <vm_dir_name>" >&2
    echo "  base:        variables-<base>.pkr.hcl" >&2
    echo "  conf:        folder and <conf>.pkr.hcl" >&2
    echo "  vm_dir_name: vm_name in the packer template" >&2
    exit 1
fi

BASE="$1"
CONF="$2"
VM_DIR_NAME="$3"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/vmware-lib.sh"

TARGET="$VM_DIR/$VM_DIR_NAME"
if [[ -e "$TARGET" ]]; then
    echo "Directory for VM exists ($TARGET). Remove it and rerun." >&2
    exit 1
fi
if [[ ! -d "$VM_DIR" ]]; then
    echo "VM directory $VM_DIR does not exist. Create it or edit defaults.sh." >&2
    exit 1
fi

pushd "$CONF" > /dev/null
packer init "$CONF.pkr.hcl"
packer build -force -var-file "../variables-$BASE.pkr.hcl" "$CONF.pkr.hcl"
if [[ ! -d "$VM_DIR_NAME" ]]; then
    echo "Packer finished but ./$VM_DIR_NAME was not created." >&2
    popd > /dev/null
    exit 1
fi
mv "./$VM_DIR_NAME" "$VM_DIR/"
popd > /dev/null

start_built_vm "$VM_DIR_NAME"
enable_shared_folders "$VM_DIR_NAME"
add_shared_folder "$VM_DIR_NAME" "$SHARED_RO_NAME" "$SHARED_RO_PATH" readonly
add_shared_folder "$VM_DIR_NAME" "$SHARED_RW_NAME" "$SHARED_RW_PATH" writable
stop_built_vm "$VM_DIR_NAME"

echo "Built $TARGET"
nohup vmware -q -t "$(get_vmx_path "$VM_DIR_NAME")" > /dev/null 2>&1 &
disown
