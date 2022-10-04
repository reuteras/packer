//  variables.pkr.hcl

// Defaults for all Ubuntu installations
headless      = false
ssh_username  = "malware"
ssh_password  = "password"

// Ubuntu 22.04 LTS
iso_checksum_ubuntu_2204 = "sha256:10f19c5b2b8d6db711582e0e27f5116296c34fe4b313ba45f9b201a5007056cb"
iso_urls_ubuntu_2204     = ["https://releases.ubuntu.com/22.04/ubuntu-22.04.1-live-server-amd64.iso"]