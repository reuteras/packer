CHECKPOINT_DISABLE ?= 1

# Detect the VMware NAT (VNET_8) host IP so Packer's HTTP server is reachable
# from the VM even when other interfaces (e.g. Tailscale) are active.
VMW_NETWORKING := /Library/Preferences/VMware\ Fusion/networking
NAT_SUBNET := $(shell grep "VNET_8_HOSTONLY_SUBNET" $(VMW_NETWORKING) 2>/dev/null | awk '{sub(/\.0$$/, "", $$3); print $$3}')
HTTP_IP := $(shell ifconfig 2>/dev/null | grep "inet $(NAT_SUBNET)\." | awk '{print $$2}' | head -1)
HTTP_IP_ARG := $(if $(HTTP_IP),-var http_ip=$(HTTP_IP),)

all: build-debian-arm

build-arkime-arm:
	cd arkime-arm && packer build -force $(HTTP_IP_ARG) -var-file ../variables-debian-arm.pkr.hcl arkime-arm.pkr.hcl

build-debian-arm:
	cd debian-arm && packer build -force $(HTTP_IP_ARG) -var-file ../variables-debian-arm.pkr.hcl debian-arm.pkr.hcl

build-malcolm-arm:
	cd malcolm-arm && packer build -force $(HTTP_IP_ARG) -var-file ../variables-debian-arm.pkr.hcl malcolm-arm.pkr.hcl

install:
	../bin/install.sh

