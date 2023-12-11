//  variables-ubuntu-2204-arm.pkr.hcl

// Defaults for all Ubuntu installations
headless      = false
ssh_username  = "malware"
ssh_password  = "password"

// Ubuntu 22.04 LTS arm
iso_checksum_ubuntu_2204_arm    = "sha256:e08313e0e0683bbf0f53e5ee9b1b22c40865d536dba22948f58c6e1405acfcf0"
iso_urls_ubuntu_2204_arm        = ["https://cdimage.ubuntu.com/ubuntu-server/jammy/daily-live/20231210/jammy-live-server-arm64.iso"]
