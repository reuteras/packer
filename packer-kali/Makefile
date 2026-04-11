CHECKPOINT_DISABLE ?= 1
all: kali-full

kali:
	packer build kali.json

build-kali-arm-qemu:
	cd kali-arm-qemu && packer init kali-arm-qemu.pkr.hcl && \
	    packer build -force \
	    -var-file ../variables-kali-arm.pkr.hcl kali-arm-qemu.pkr.hcl; \
	RC=$$?; \
	if [ $$RC -eq 0 ]; then \
	    qemu-img convert -f qcow2 -O vmdk \
	        Kali_64-bit_arm/Kali_64-bit_arm.qcow2 \
	        Kali_64-bit_arm/Kali_64-bit_arm.vmdk; \
	fi; exit $$RC

install:
	../bin/install.sh

clean:
	rm -rf Kali_64-bit.vmwarevm

dist-clean:
	make clean
	rm -rf packer_cache

