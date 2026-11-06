#!/usr/bin/env bash
# Shared helpers for building VMware Workstation Pro VMs on Linux.
# Sourced by build-vm.sh. Configuration lives in ../defaults.sh.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/../defaults.sh"

vmrun_ws() {
    vmrun -T ws "$@"
}

get_vmx_path() {
    echo "$VM_DIR/$1/$1.vmx"
}

enable_shared_folders() {
    vmrun_ws enableSharedFolders "$(get_vmx_path "$1")"
}

add_shared_folder() {
    local vm_dir_name="$1" share_name="$2" share_path="$3" state="$4"
    local vmx
    vmx="$(get_vmx_path "$vm_dir_name")"
    vmrun_ws addSharedFolder "$vmx" "$share_name" "$share_path"
    vmrun_ws setSharedFolderState "$vmx" "$share_name" "$share_path" "$state"
}

start_built_vm() {
    local vmx
    vmx="$(get_vmx_path "$1")"
    vmrun_ws start "$vmx" nogui
    # Waits until the guest has an IP address, i.e. is running
    vmrun_ws getGuestIPAddress "$vmx" -wait
}

stop_built_vm() {
    local vmx
    vmx="$(get_vmx_path "$1")"
    vmrun_ws stop "$vmx"
    # Replace the Installed snapshot with a Secure one
    vmrun_ws deleteSnapshot "$vmx" Installed || echo "No Installed snapshot to delete."
    vmrun_ws snapshot "$vmx" Secure
}
