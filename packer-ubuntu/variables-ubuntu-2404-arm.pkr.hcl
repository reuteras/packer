//  variables-ubuntu-2404.pkr.hcl

// Defaults for all Ubuntu installations
headless      = "true"
ssh_username  = "malware"
ssh_password  = "password"

// Ubuntu 24.04 LTS
iso_checksum_ubuntu_2404_arm = "2ee2163c9b901ff5926400e80759088ff3b879982a3956c02100495b489fd555"
iso_urls_ubuntu_2404_arm     = ["https://cdimage.ubuntu.com/releases/24.04/release/ubuntu-24.04.3-live-server-arm64.iso"]
