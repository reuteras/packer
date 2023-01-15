CHECKPOINT_DISABLE ?= 1
all: kali-full

kali:
	packer build kali.json

build-kali-arm:
	cd kali-arm && packer build -force -var-file ../variables-kali-arm.pkr.hcl kali-arm.pkr.hcl 

kali-full:
	make validate-kali
	packer build kali.json

debug-kali:
	make validate-kali
	packer build -on-error=abort kali.json

validate-kali:
	packer validate kali.json

install:
	../bin/install.sh

clean:
	rm -rf Kali_64-bit.vmwarevm

dist-clean:
	make clean
	rm -rf packer_cache

