CHECKPOINT_DISABLE ?= 1
all: sift remnux ubuntu
ubuntu: ubuntu-20.04

build-malcolm-arm:
	cd malcolm && packer build -force -var-file ../variables-ubuntu-2204-arm.pkr.hcl malcolm-arm.pkr.hcl

remnux:
	packer validate ubuntu-remnux-tools-remnux.json
	packer build -on-error=abort ubuntu-remnux-tools-remnux.json

sift:
	packer validate ubuntu-remnux-tools-sift.json
	packer build ubuntu-remnux-tools-sift.json

ubuntu-18.04:
	packer validate ubuntu-18.04.json
	packer build ubuntu-18.04.json

ubuntu-20.04:
	packer validate ubuntu-20.04.json
	packer build ubuntu-20.04.json

ubuntu-22.04:
	packer validate ubuntu-22.04.json
	packer build ubuntu-22.04.json

build-ubuntu-2004-arm:
	cd ubuntu-2004-arm && packer build -force -var-file ../variables-ubuntu-2004.pkr.hcl ubuntu-2004-arm.pkr.hcl

build-ubuntu-2204-arm:
	cd ubuntu-2204-arm && packer build -force -var-file ../variables-ubuntu-2204-arm.pkr.hcl ubuntu-2204-arm.pkr.hcl

install:
	../bin/install.sh

clean:
	make clean-remnux
	make clean-sift
	make clean-ubuntu
	make clean-ubuntu-16.04
	make clean-ubuntu-18.04
	make clean-ubuntu-18.04-arkime
	make clean-ubuntu-20.04
	make clean-ubuntu-timesketch

clean-remnux:
	rm -rf Ubuntu_REMnux_64-bit.vmwarevm

clean-sift:
	rm -rf Ubuntu_SIFT_64-bit.vmwarevm

clean-ubuntu:
	rm -rf Ubuntu_64-bit.vmwarevm

clean-ubuntu-18.04:
	rm -rf Ubuntu_1804_64-bit.vmwarevm

clean-ubuntu-20.04:
	rm -rf Ubuntu_2004_64-bit.vmwarevm

dist-clean:
	make clean
	rm -rf packer_cache
