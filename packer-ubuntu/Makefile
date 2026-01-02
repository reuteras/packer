CHECKPOINT_DISABLE ?= 1
all: sift remnux ubuntu

remnux:
	packer validate ubuntu-remnux-tools-remnux.json
	packer build -on-error=abort ubuntu-remnux-tools-remnux.json

sift:
	cd sift && packer build -force -var-file ../variables-ubuntu-2204.pkr.hcl sift.pkr.hcl

build-ubuntu-2404-arm:
	cd ubuntu-2404-arm && packer build -force -var-file ../variables-ubuntu-2404-arm.pkr.hcl ubuntu-2404-arm.pkr.hcl

install:
	../bin/install.sh

dist-clean:
	make clean
	rm -rf packer_cache
