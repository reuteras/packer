CHECKPOINT_DISABLE ?= 1
all: kali-full

kali:
	packer build kali.json

build-kali-arm:
	cd kali-arm && packer build -force -var-file ../variables-kali-arm.pkr.hcl kali-arm.pkr.hcl 

install:
	../bin/install.sh

clean:
	rm -rf Kali_64-bit.vmwarevm

dist-clean:
	make clean
	rm -rf packer_cache

