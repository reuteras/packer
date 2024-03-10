CHECKPOINT_DISABLE ?= 1
all: sift remnux ubuntu

build-malcolm-arm:
	cd malcolm && packer build -force -var-file ../variables-ubuntu-2204-arm.pkr.hcl malcolm-arm.pkr.hcl

remnux:
	packer validate ubuntu-remnux-tools-remnux.json
	packer build -on-error=abort ubuntu-remnux-tools-remnux.json

sift:
	cd sift && packer build -force -var-file ../variables-ubuntu-2204.pkr.hcl sift.pkr.hcl

ubuntu-18.04:
	packer validate ubuntu-18.04.json
	packer build ubuntu-18.04.json

build-ubuntu-2004:
	cd ubuntu-2004 && packer build -force -var-file ../variables-ubuntu-2004.pkr.hcl ubuntu-2004.pkr.hcl

build-ubuntu-2204:
	cd ubuntu-2204 && packer build -force -var-file ../variables-ubuntu-2204.pkr.hcl ubuntu-2204.pkr.hcl

build-ubuntu-2004-arm:
	cd ubuntu-2004-arm && packer build -force -var-file ../variables-ubuntu-2004.pkr.hcl ubuntu-2004-arm.pkr.hcl

build-ubuntu-2204-arm:
	cd ubuntu-2204-arm && packer build -force -var-file ../variables-ubuntu-2204-arm.pkr.hcl ubuntu-2204-arm.pkr.hcl

install:
	../bin/install.sh

clean:
	echo "TODO"

dist-clean:
	make clean
	rm -rf packer_cache
