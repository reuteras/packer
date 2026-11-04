CHECKPOINT_DISABLE ?= 1

all: build-debian-arm-qemu

build-debian-arm-qemu:
	cd debian-arm-qemu && packer init debian-arm-qemu.pkr.hcl && \
	    packer build -force \
	    -var-file ../variables-debian-arm.pkr.hcl debian-arm-qemu.pkr.hcl && \
	    ../../scripts/qcow2-to-fusion.sh Debian_64-bit Debian_64-bit 8192 2 arm-debian13-64

build-malcolm-arm-qemu:
	cd malcolm-arm-qemu && packer init malcolm-arm-qemu.pkr.hcl && \
	    packer build -force \
	    -var-file ../variables-debian-arm.pkr.hcl malcolm-arm-qemu.pkr.hcl && \
	    ../../scripts/qcow2-to-fusion.sh Malcolm_Debian_64-bit Malcolm_Debian_64-bit 24576 6 arm-debian13-64

build-arkime-arm-qemu:
	cd arkime-arm-qemu && packer init arkime-arm-qemu.pkr.hcl && \
	    packer build -force \
	    -var-file ../variables-debian-arm.pkr.hcl arkime-arm-qemu.pkr.hcl && \
	    ../../scripts/qcow2-to-fusion.sh Arkime_Debian_64-bit Arkime_Debian_64-bit 16384 4 arm-debian13-64

install:
	../bin/install.sh
