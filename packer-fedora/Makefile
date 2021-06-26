CHECKPOINT_DISABLE ?= 1
all: fedora-34-full

fedora-34:
	packer build fedora-34.json

fedora-34-full:
	make validate-fedora-34
	packer build fedora-34.json

debug-fedora-34:
	make validate-fedora-34
	packer build -on-error=abort fedora-34.json

validate-fedora-34:
	packer validate fedora-34.json

fedora-34-gui:
	packer build fedora-34-gui.json

fedora-34-gui-full:
	make validate-fedora-34-gui
	packer build fedora-34-gui.json

debug-fedora-34-gui:
	make validate-fedora-34-gui
	packer build -on-error=abort fedora-34-gui.json

validate-fedora-34-gui:
	packer validate fedora-34-gui.json

install:
	../bin/install.sh

clean:
	rm -rf Fedora_*_64-bit.vmwarevm 

dist-clean:
	make clean
	rm -rf packer_cache

