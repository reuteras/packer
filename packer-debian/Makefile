CHECKPOINT_DISABLE ?= 1
all: debian

cuckoo:
	make validate-cuckoo
	packer build debian-cuckoo.json

debian:
	make validate-debian
	packer build debian.json

debug-cuckoo:
	make validate-cuckoo
	packer build -on-error=abort debian-cuckoo.json

debian-chrome:
	make validate-debian-chrome
	packer build debian-chrome.json

validate-cuckoo:
	packer validate debian-cuckoo.json

validate-debian:
	packer validate debian.json

validate-debian-chrome:
	packer validate debian-chrome.json

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

