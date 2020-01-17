all: sift remnux moloch
ubuntu: ubuntu-18.04
moloch: ubuntu-18.04-moloch
hunter: ubuntu-16.04-hybrid-hunter
so: ubuntu-16.04-security_onion

remnux:
	packer validate ubuntu-remnux-tools-remnux.json
	packer build -on-error=abort ubuntu-remnux-tools-remnux.json

sift:
	packer validate ubuntu-remnux-tools-sift.json
	packer build ubuntu-remnux-tools-sift.json

ubuntu-16.04:
	packer validate ubuntu-16.04.json
	packer build ubuntu-16.04.json

ubuntu-16.04-hybrid-hunter:
	packer validate ubuntu-16.04-hybrid-hunter.json
	packer build ubuntu-16.04-hybrid-hunter.json

ubuntu-16.04-security_onion:
	packer validate ubuntu-16.04-security_onion.json
	packer build ubuntu-16.04-security_onion.json

ubuntu-18.04:
	packer validate ubuntu-18.04.json
	packer build ubuntu-18.04.json

ubuntu-18.04-moloch:
	packer validate ubuntu-18.04-moloch.json
	packer build ubuntu-18.04-moloch.json

debug-remnux:
	packer validate ubuntu-remnux-tools-remnux.json
	packer build -debug -on-error=abort ubuntu-remnux-tools-remnux.json

debug-sift:
	packer validate ubuntu-remnux-tools-sift.json
	packer build -debug -on-error=abort ubuntu-remnux-tools-sift.json

debug-ubuntu-16.04:
	packer validate ubuntu-16.04.json
	packer build -debug -on-error=abort ubuntu-16.04.json

debug-ubuntu-16.04:
	packer validate ubuntu-16.04-hybrid-hunter.json
	packer build -debug -on-error=abort ubuntu-16.04-hybrid-hunter.json

debug-ubuntu-18.04:
	packer validate ubuntu-18.04.json
	packer build -debug -on-error=abort ubuntu-18.04.json

debug-ubuntu-18.04-moloch:
	packer validate ubuntu-18.04-moloch.json
	packer build -debug -on-error=abort ubuntu-18.04-moloch.json

install:
	../bin/install.sh

clean:
	make clean-remnux
	make clean-sift
	make clean-ubuntu
	make clean-ubuntu-16.04
	make clean-ubuntu-16.04-hybrid-hunter
	make clean-ubuntu-16.04-security_onion
	make clean-ubuntu-18.04
	make clean-ubuntu-18.04-moloch

clean-remnux:
	rm -rf Ubuntu_REMnux_64-bit.vmwarevm

clean-sift:
	rm -rf Ubuntu_SIFT_64-bit.vmwarevm

clean-ubuntu:
	rm -rf Ubuntu_64-bit.vmwarevm

clean-ubuntu-16.04:
	rm -rf Ubuntu_1604_64-bit.vmwarevm

clean-ubuntu-16.04-hybrid-hunter:
	rm -rf Hybrid_Hunter.vmwarevm

clean-ubuntu-16.04-security_onion:
	rm -rf Security_Onion.vmwarevm

clean-ubuntu-18.04:
	rm -rf Ubuntu_1804_64-bit.vmwarevm

clean-ubuntu-18.04-moloch:
	rm -rf Ubuntu_moloch.vmwarevm

dist-clean:
	make clean
	rm -rf packer_cache
