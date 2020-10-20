#!/bin/bash

VMHOME="$HOME/Documents/Virtual Machines.localized"

if [[ ! -d "$VMHOME" ]]; then
    VMHOME="$HOME/Virtual Machines.localized"
    if [[ ! -d "$VMHOME" ]]; then
        echo "This script assumes that $VMHOME exists."
        exit 1
    fi
fi

shopt -s nullglob

for vm in [A-Z]*.vmwarevm ; do
    echo "Installing $vm"
    if [[ -d "$VMHOME/$vm" ]]; then
        echo "$VMHOME/$vm already exists! Will not overwrite."
    else
        mv "$vm" "$VMHOME/"
        open "$VMHOME/$vm"/*.vmx || true
    fi
done

