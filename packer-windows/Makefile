CHECKPOINT_DISABLE ?= 1
all: windows10_default

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

windows10_default:
	packer build --only=vmware-iso windows_10_default.json

windows10_default-full:
	make validate-windows10_default
	packer build windows_10_default.json

debug-windows10_default:
	make validate-windows10_default
	packer build -on-error=abort --only=vmware-iso windows_10_default.json

validate-windows10_default:
	packer validate windows_10_default.json

windows10_malware:
	packer build windows_10_malware.json

install:
	../bin/install.sh

clean:
	rm -rf Windows_10*

dist-clean:
	make clean
	rm -rf packer_cache

