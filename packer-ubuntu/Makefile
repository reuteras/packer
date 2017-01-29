all: sift remnux

remnux:
	packer validate ubuntu-remnux-tools-remnux.json
	packer build -on-error=abort ubuntu-remnux-tools-remnux.json

sift:
	packer validate ubuntu-remnux-tools-sift.json
	packer build ubuntu-remnux-tools-sift.json

ubuntu:
	packer validate ubuntu.json
	packer build ubuntu.json

debug-remnux:
	packer validate ubuntu-remnux-tools-remnux.json
	packer build -on-error=abort ubuntu-remnux-tools-remnux.json

debug-sift:
	packer validate ubuntu-remnux-tools-sift.json
	packer build -on-error=abort ubuntu-remnux-tools-sift.json

debug-ubuntu:
	packer validate ubuntu.json
	packer build -on-error=abort ubuntu.json

install:
	../bin/install.sh

clean:
	make clean-remnux
	make clean-sift
	make clean-ubuntu

clean-remnux:
	rm -rf Ubuntu_REMnux_64-bit.vmwarevm

clean-sift:
	rm -rf Ubuntu_SIFT_64-bit.vmwarevm

clean-ubuntu:
	rm -rf Ubuntu_64-bit.vmwarevm

dist-clean:
	make clean
	rm -rf packer_cache
