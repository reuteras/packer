#!/bin/bash

if [[ $# -ne 1 ]]; then
	echo "Need a vmx file as argument."
	exit
fi

VM="$1"

make centos-7

vmrun -T fusion start "$VM" nogui
sleep 5
vmrun -T fusion getGuestIPAddress "$VM" -wait >/dev/null
sleep 1
vmrun -T fusion -gu user -gp password runScriptInGuest "$VM" /bin/bash "/bin/rpm -qa > /home/user/rpm.txt"
vmrun -T fusion -gu user -gp password CopyFileFromGuestToHost "$VM" /home/user/rpm.txt rpm.txt
vmrun -T fusion stop "$VM"
vmrun -T fusion deleteVM "$VM"

make clean
