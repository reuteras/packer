#!/usr/bin/env bash
# shellcheck disable=SC2034 # variables are used by scripts/vmware-lib.sh
# Default location for virtual machines (Linux + VMware Workstation Pro)
# Change the values below for your environment. You have to create the directories.
# Sourced by scripts/vmware-lib.sh - do not execute directly.

# Name and location of readonly folder to mount in VM
SHARED_RO_NAME="ro"
SHARED_RO_PATH="$HOME/Shared/ro"

# Name and location of writable folder to mount in VM
SHARED_RW_NAME="rw"
SHARED_RW_PATH="$HOME/Shared/rw"

# Folder to store VMs in after they are created
VM_DIR="$HOME/Virtual Machines"

# --- No need to edit below --- #

# Defaults for shared cache for Packer.
export PACKER_CACHE_DIR="${PACKER_CACHE_DIR:-../packer_cache}"
export CHECKPOINT_DISABLE="${CHECKPOINT_DISABLE:-1}"
