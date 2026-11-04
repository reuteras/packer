CHECKPOINT_DISABLE ?= 1
all: kali-full

kali:
	packer build kali.json

build-kali-arm-qemu:
	cd kali-arm-qemu && packer init kali-arm-qemu.pkr.hcl && \
	    packer build -force \
	    -var-file ../variables-kali-arm.pkr.hcl kali-arm-qemu.pkr.hcl && \
	    ../../scripts/qcow2-to-fusion.sh Kali_64-bit_arm Kali_64-bit_arm 8192 2 arm-debian13-64

install:
	../bin/install.sh

clean:
	rm -rf Kali_64-bit.vmwarevm

dist-clean:
	make clean
	rm -rf packer_cache
