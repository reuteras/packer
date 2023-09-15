//  variables-ubuntu-2204-arm.pkr.hcl

// Defaults for all Ubuntu installations
headless      = false
ssh_username  = "malware"
ssh_password  = "password"

// Ubuntu 22.04 LTS arm
iso_checksum_ubuntu_2204_arm    = "sha256:7e51747934ee839fc0e2541bf02f3c430edcf1a8c3d995474b7b63851caa7709"
iso_urls_ubuntu_2204_arm        = ["https://cdimage.ubuntu.com/ubuntu-server/jammy/daily-live/20230914/jammy-live-server-arm64.iso"]
