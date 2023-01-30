//  variables.pkr.hcl

// Defaults for all Ubuntu installations
headless      = false
ssh_username  = "malware"
ssh_password  = "password"

// Ubuntu 22.04 LTS
iso_checksum_ubuntu_2204 = "sha256:bc5a8015651c6f8699ab262d333375d3930b824f03d14ae51e551d89d9bb571c"
iso_urls_ubuntu_2204     = ["https://cdimage.ubuntu.com/ubuntu/releases/22.04/release/ubuntu-22.04.1-live-server-arm64.iso"]
