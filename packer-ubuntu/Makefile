CHECKPOINT_DISABLE ?= 1
all: remnux ubuntu

remnux:
	packer validate ubuntu-remnux-tools-remnux.json
	packer build -on-error=abort ubuntu-remnux-tools-remnux.json

build-ubuntu-2404-arm-qemu:
	cd ubuntu-2404-arm-qemu && packer init ubuntu-2404-arm-qemu.pkr.hcl && \
	    packer build -force \
	    -var-file ../variables-ubuntu-2404-arm.pkr.hcl ubuntu-2404-arm-qemu.pkr.hcl; \
	RC=$$?; \
	if [ $$RC -eq 0 ]; then \
	    qemu-img convert -f qcow2 -O vmdk \
	        Ubuntu_24.04_64-bit_arm/Ubuntu_24.04_64-bit_arm.qcow2 \
	        Ubuntu_24.04_64-bit_arm/Ubuntu_24.04_64-bit_arm.vmdk; \
	fi; exit $$RC

install:
	../bin/install.sh

dist-clean:
	make clean
	rm -rf packer_cache
