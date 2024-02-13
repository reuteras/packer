//  variables-ubuntu-2204-arm.pkr.hcl

// Defaults for all Ubuntu installations
headless      = false
ssh_username  = "malware"
ssh_password  = "password"

// Ubuntu 22.04 LTS arm
iso_checksum_ubuntu_2204_arm    = "sha256:da14c83b3adea5803450d8fe812a18acff1cc0d0fb9838ab93011161dea774d7"
iso_urls_ubuntu_2204_arm        = ["https://cdimage.ubuntu.com/ubuntu-server/jammy/daily-live/20240213/jammy-live-server-arm64.iso"]
