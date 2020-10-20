all: windows10

windows10:
	packer build --only=vmware-iso windows_10.json

windows10-full:
	make validate-windows10
	packer build windows_10.json

debug-windows10:
	make validate-windows10
	packer build -on-error=abort --only=vmware-iso windows_10.json

validate-windows10:
	packer validate windows_10.json

install:
	../bin/install.sh

clean:
	rm -rf Windows_10_64-bit.vmwarevm

dist-clean:
	make clean
	rm -rf packer_cache

