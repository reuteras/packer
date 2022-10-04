//  variables.pkr.hcl

// Defaults for all Ubuntu installations
headless      = false
ssh_username  = "malware"
ssh_password  = "password"

// Ubuntu 20.04 LTS
iso_checksum_ubuntu_2004 = "sha256:0e79e00bf844929d40825b1f0e8634415cda195ba23bae0b041911fde4dfe018"
iso_urls_ubuntu_2004     = ["http://archive.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/current/legacy-images/netboot/mini.iso"]
