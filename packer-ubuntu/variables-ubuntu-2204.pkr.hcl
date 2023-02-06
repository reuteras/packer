//  variables.pkr.hcl

// Defaults for all Ubuntu installations
headless      = false
ssh_username  = "malware"
ssh_password  = "password"

// Ubuntu 22.04 LTS
iso_checksum_ubuntu_2204 = "sha256:10f19c5b2b8d6db711582e0e27f5116296c34fe4b313ba45f9b201a5007056cb"
iso_urls_ubuntu_2204     = ["https://releases.ubuntu.com/22.04/ubuntu-22.04.1-live-server-amd64.iso"]// Ubuntu 22.04 LTS arm
iso_checksum_ubuntu_2204_arm    = "sha256:b9a399e392f38704d796a9aada1c9c1a883db4e05f721682aa1ee3de28d3e206"
iso_urls_ubuntu_2204_arm        = ["https://cdimage.ubuntu.com/ubuntu-server/jammy/daily-live/current/jammy-live-server-arm64.iso"]
