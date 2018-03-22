all: cuckoo

cuckoo:
	make validate-cuckoo
	packer build debian-cuckoo.json

debian:
	make validate-debian
	packer build debian.json

debug-cuckoo:
	make validate-cuckoo
	packer build -on-error=abort debian-cuckoo.json

debian-xfce:
	make validate-debian-xfce
	packer build debian-xfce.json

validate-cuckoo:
	packer validate debian-cuckoo.json

validate-debian:
	packer validate debian.json

validate-debian-xfce:
	packer validate debian-xfce.json

install:
	../bin/install.sh

clean:
	rm -rf Debian_Cuckoo_64-bit.vmwarevm
	rm -rf Debian_64-bit.vmwarevm
	rm -rf Debian_9_64-bit.vmwarevm
	rm -rf Debian_9_xfce_64-bit.vmwarevm

dist-clean:
	make clean
	rm -rf packer_cache

