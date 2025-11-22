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

while IFS= read -r vm_path; do
	vm=$(echo "$vm_path" | sed -E "s#.*/##")
	echo "Installing $vm"
	if [[ -d "$VMHOME/$vm" ]]; then
		echo "$VMHOME/$vm already exists! Will not overwrite."
	else
		mv "$vm_path" "$VMHOME/"
		open "$VMHOME/$vm"/*.vmx || true
	fi
done < <(find -E . -type d -a -regex ".*[A-Z].+")
