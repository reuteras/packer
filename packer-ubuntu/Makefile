CHECKPOINT_DISABLE ?= 1
all: build-ubuntu-2404-arm-qemu

# arm64 builds use QEMU (hvf) and are converted to VMware Fusion VMs.
build-ubuntu-2404-arm-qemu:
	cd ubuntu-2404-arm-qemu && packer init ubuntu-2404-arm-qemu.pkr.hcl && \
	    packer build -force \
	    -var-file ../variables-ubuntu-2404-arm.pkr.hcl ubuntu-2404-arm-qemu.pkr.hcl && \
	    ../../scripts/qcow2-to-fusion.sh Ubuntu_24.04_64-bit_arm Ubuntu_24.04_64-bit_arm 8192 2 arm-ubuntu-64

build-remnux-arm-qemu:
	cd remnux-arm-qemu && packer init remnux-arm-qemu.pkr.hcl && \
	    packer build -force \
	    -var-file ../variables-ubuntu-2404-arm.pkr.hcl remnux-arm-qemu.pkr.hcl && \
	    ../../scripts/qcow2-to-fusion.sh REMnux_arm64 REMnux_arm64 8192 4 arm-ubuntu-64

install:
	../bin/install.sh

clean:
	rm -rf ubuntu-2404-arm-qemu/Ubuntu_24.04_64-bit_arm remnux-arm-qemu/REMnux_arm64

dist-clean:
	make clean
	rm -rf packer_cache
