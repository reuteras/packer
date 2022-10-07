#!/bin/bash -eux

package-cleanup --quiet --leaves | xargs yum remove -y
(( $(rpm -E %{rhel}) >= 8 )) && dnf remove $(dnf repoquery --installonly --latest-limit=-2 -q)
(( $(rpm -E %{rhel}) <= 7 )) && package-cleanup --oldkernels --count=2

yum remove -y yum-utils
yum clean all
rm -rf /var/cache/yum
rm -rf /var/tmp/yum-*
rm -rf /home/*/.cache/*/* /root/.cache/*/* 


# Zero out the rest of the free space using dd, then delete the written file.
if [[ $(df / | grep "/" | awk '{print $4}') -ge $((60*1024*1024)) ]]; then
    echo "Disk larger then limit - not zeroing disk."
else
    echo "Start zero of disk"
    dd if=/dev/zero of="$HOME/zero" conv=fsync
    sleep 1
    sync
    rm -f "$HOME"/zero
    # Add `sync` so Packer doesn't quit too early, before the large file is deleted.
    sync
fi
