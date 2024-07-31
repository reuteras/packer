//  variables-ubuntu-2404.pkr.hcl

// Defaults for all Ubuntu installations
headless      = "true"
ssh_username  = "malware"
ssh_password  = "password"

// Ubuntu 24.04 LTS
iso_checksum_ubuntu        = "sha256:8762f7e74e4d64d72fceb5f70682e6b069932deedb4949c6975d0f0fe0a91be3"
iso_urls_ubuntu            = ["https://releases.ubuntu.com/24.04/ubuntu-24.04-live-server-amd64.iso"]
