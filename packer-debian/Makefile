CHECKPOINT_DISABLE ?= 1
all: debian

build-debian-arm:
	cd debian-arm && packer build -force -var-file ../variables-debian-arm.pkr.hcl debian-arm.pkr.hcl

cuckoo:
	make validate-cuckoo
	packer build -var-file=debian-vars.jsondebian-cuckoo.json

debian:
	make validate-debian
	packer build -var-file=debian-vars.json debian.json

debug-cuckoo:
	make validate-cuckoo
	packer build -on-error=abort -var-file=debian-vars.json debian-cuckoo.json

debian-chrome:
	make validate-debian-chrome
	packer build -var-file=debian-vars.json debian-chrome.json

validate-cuckoo:
	packer validate -var-file=debian-vars.json debian-cuckoo.json

validate-debian:
	packer validate -var-file=debian-vars.json debian.json

validate-debian-chrome:
	packer validate -var-file=debian-vars.json debian-chrome.json

install:
	../bin/install.sh

clean:
	rm -rf Debian_Cuckoo_64-bit.vmwarevm
	rm -rf Debian_64-bit.vmwarevm
	rm -rf Debian_11_64-bit.vmwarevm
	rm -rf Debian_11_chrome-bit.vmwarevm

dist-clean:
	make clean
	rm -rf packer_cache

