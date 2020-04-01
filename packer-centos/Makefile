all: centos-7-full

centos-7:
	packer build centos-7.json

centos-7-full:
	make validate-centos-7
	packer build centos-7.json

debug-centos-7:
	make validate-centos-7
	packer build -on-error=abort centos-7.json

validate-centos-7:
	packer validate centos-7.json

install:
	../bin/install.sh

clean:
	rm -rf Centos_7_64-bit.vmwarevm

dist-clean:
	make clean
	rm -rf packer_cache

