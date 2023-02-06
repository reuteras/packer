//  variables.pkr.hcl

// Defaults for all Ubuntu installations
headless      = false
ssh_username  = "malware"
ssh_password  = "password"

// Ubuntu 20.04 LTS
iso_checksum_ubuntu_2004        = "sha256:0e79e00bf844929d40825b1f0e8634415cda195ba23bae0b041911fde4dfe018"
iso_urls_ubuntu_2004            = ["http://archive.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/current/legacy-images/netboot/mini.iso"]

// Ubuntu 20.04 LTS arm
iso_checksum_ubuntu_2004_arm    = "sha256:e42d6373dd39173094af5c26cbf2497770426f42049f8b9ea3e60ce35bebdedf"
iso_urls_ubuntu_2004_arm        = ["https://cdimage.ubuntu.com/releases/focal/release/ubuntu-20.04.5-live-server-arm64.iso"]
