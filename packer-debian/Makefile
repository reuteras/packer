CHECKPOINT_DISABLE ?= 1

all: build-debian-arm-qemu

build-debian-arm-qemu:
	cd debian-arm-qemu && packer init debian-arm-qemu.pkr.hcl && \
	    packer build -force \
	    -var-file ../variables-debian-arm.pkr.hcl debian-arm-qemu.pkr.hcl; \
	RC=$$?; \
	if [ $$RC -eq 0 ]; then \
	    qemu-img convert -f qcow2 -O vmdk \
	        Debian_64-bit/Debian_64-bit.qcow2 \
	        Debian_64-bit/Debian_64-bit.vmdk; \
	fi; exit $$RC

build-malcolm-arm-qemu:
	cd malcolm-arm-qemu && packer init malcolm-arm-qemu.pkr.hcl && \
	    packer build -force \
	    -var-file ../variables-debian-arm.pkr.hcl malcolm-arm-qemu.pkr.hcl; \
	RC=$$?; \
	if [ $$RC -eq 0 ]; then \
	    qemu-img convert -f qcow2 -O vmdk \
	        Malcolm_Debian_64-bit/Malcolm_Debian_64-bit.qcow2 \
	        Malcolm_Debian_64-bit/Malcolm_Debian_64-bit.vmdk; \
	fi; exit $$RC

build-arkime-arm-qemu:
	cd arkime-arm-qemu && packer init arkime-arm-qemu.pkr.hcl && \
	    packer build -force \
	    -var-file ../variables-debian-arm.pkr.hcl arkime-arm-qemu.pkr.hcl; \
	RC=$$?; \
	if [ $$RC -eq 0 ]; then \
	    qemu-img convert -f qcow2 -O vmdk \
	        Arkime_Debian_64-bit/Arkime_Debian_64-bit.qcow2 \
	        Arkime_Debian_64-bit/Arkime_Debian_64-bit.vmdk; \
	fi; exit $$RC

install:
	../bin/install.sh
