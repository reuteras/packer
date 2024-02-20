//  variables-ubuntu-2204-arm.pkr.hcl

// Defaults for all Ubuntu installations
headless      = "true"
ssh_username  = "malware"
ssh_password  = "password"

// Ubuntu 22.04 LTS arm
iso_checksum_ubuntu_2204_arm    = "sha256:7a5c2d0a2e025803ae0c247a94b4defe1fea28273452d9e769c3f3744273e25c"
iso_urls_ubuntu_2204_arm        = ["https://cdimage.ubuntu.com/ubuntu-server/jammy/daily-live/20240215/jammy-live-server-arm64.iso"]
