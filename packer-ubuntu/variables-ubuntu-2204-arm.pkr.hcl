//  variables-ubuntu-2204-arm.pkr.hcl

// Defaults for all Ubuntu installations
headless      = "true"
ssh_username  = "malware"
ssh_password  = "password"

// Ubuntu 22.04 LTS arm
iso_checksum_ubuntu_2204_arm    = "sha256:0a1245004cd12c6196a45a52a01796aa13ebb0b56d152ed4054507ebb712801e"
iso_urls_ubuntu_2204_arm        = ["https://cdimage.ubuntu.com/ubuntu-server/jammy/daily-live/20231208/jammy-live-server-arm64.iso"]
