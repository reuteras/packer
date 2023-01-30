CHECKPOINT_DISABLE ?= 1
all: sift remnux arkime ubuntu
ubuntu: ubuntu-20.04
moloch: arkime
arkime: ubuntu-18.04-arkime
hunter: ubuntu-16.04-hybrid-hunter
so: ubuntu-16.04-security_onion
timesketch: ubuntu-timesketch

remnux:
	packer validate ubuntu-remnux-tools-remnux.json
	packer build -on-error=abort ubuntu-remnux-tools-remnux.json

sift:
	packer validate ubuntu-remnux-tools-sift.json
	packer build ubuntu-remnux-tools-sift.json

ubuntu-16.04:
	packer validate ubuntu-16.04.json
	packer build ubuntu-16.04.json

ubuntu-18.04:
	packer validate ubuntu-18.04.json
	packer build ubuntu-18.04.json

ubuntu-20.04:
	packer validate ubuntu-20.04.json
	packer build ubuntu-20.04.json

ubuntu-22.04:
	packer validate ubuntu-22.04.json
	packer build ubuntu-22.04.json

build-ubuntu-2204-arm:
	cd ubuntu-2204-arm && packer build -force -var-file ../variables-ubuntu-2204-arm.pkr.hcl ubuntu-2204-arm.pkr.hcl

ubuntu-timesketch:
	packer validate ubuntu-timesketch.json
	packer build ubuntu-timesketch.json

ubuntu-timesketch-ova:
	packer validate ubuntu-timesketch.json
	packer build ubuntu-timesketch.json
	/Applications/VMware\ OVF\ Tool/ovftool Ubuntu_Timesketch_64-bit.vmwarevm/Ubuntu_Timesketch_64-bit.vmx timesketch.ova

ubuntu-18.04-arkime:
	packer validate ubuntu-18.04-arkime.json
	packer build ubuntu-18.04-arkime.json

debug-remnux:
	packer validate ubuntu-remnux-tools-remnux.json
	packer build -debug -on-error=abort ubuntu-remnux-tools-remnux.json

debug-sift:
	packer validate ubuntu-remnux-tools-sift.json
	packer build -debug -on-error=abort ubuntu-remnux-tools-sift.json

debug-ubuntu-16.04:
	packer validate ubuntu-16.04.json
	packer build -debug -on-error=abort ubuntu-16.04.json

debug-ubuntu-18.04:
	packer validate ubuntu-18.04.json
	packer build -debug -on-error=abort ubuntu-18.04.json

debug-ubuntu-20.04:
	packer validate ubuntu-20.04.json
	packer build -debug -on-error=abort ubuntu-20.04.json

debug-ubuntu-18.04-arkime:
	packer validate ubuntu-18.04-arkime.json
	packer build -debug -on-error=abort ubuntu-18.04-arkime.json

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
	make clean-ubuntu-18.04-arkime
	make clean-ubuntu-20.04
	make clean-ubuntu-timesketch

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

clean-ubuntu-20.04:
	rm -rf Ubuntu_2004_64-bit.vmwarevm

clean-ubuntu-timesketch:
	rm -rf Ubuntu_Timesketch_64-bit.vmwarevm timesketch.ova

clean-ubuntu-18.04-arkime:
	rm -rf Ubuntu_arkime.vmwarevm

dist-clean:
	make clean
	rm -rf packer_cache
