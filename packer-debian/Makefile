CHECKPOINT_DISABLE ?= 1
all: build-debian-arm

build-arkime-arm:
	cd arkime-arm && packer build -force -var-file ../variables-debian-arm.pkr.hcl arkime-arm.pkr.hcl

build-debian-arm:
	cd debian-arm && packer build -force -var-file ../variables-debian-arm.pkr.hcl debian-arm.pkr.hcl

build-malcolm-arm:
	cd malcolm-arm && packer build -force -var-file ../variables-debian-arm.pkr.hcl malcolm-arm.pkr.hcl

install:
	../bin/install.sh

