all: centos-8-full

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

centos-8:
	packer build centos-8.json

centos-8-full:
	make validate-centos-8
	packer build centos-8.json

debug-centos-8:
	make validate-centos-8
	packer build -on-error=abort centos-8.json

validate-centos-8:
	packer validate centos-8.json

install:
	../bin/install.sh

clean:
	rm -rf Centos_*_64-bit.vmwarevm 

dist-clean:
	make clean
	rm -rf packer_cache

