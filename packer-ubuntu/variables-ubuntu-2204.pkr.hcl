//  variables.pkr.hcl

// Defaults for all Ubuntu installations
headless      = false
ssh_username  = "malware"
ssh_password  = "password"

// Ubuntu 22.04 LTS
iso_checksum_ubuntu_2204        = "sha256:10f19c5b2b8d6db711582e0e27f5116296c34fe4b313ba45f9b201a5007056cb"
iso_urls_ubuntu_2204            = ["https://releases.ubuntu.com/22.04/ubuntu-22.04.1-live-server-amd64.iso"]// Ubuntu 22.04 LTS arm
iso_checksum_ubuntu_2204_arm    = "sha256:875cdcd9b3bd8189c39b1e778960a17f64bf511cf51c8d6bb0bdb4235f2a89c3"
iso_urls_ubuntu_2204_arm        = ["https://cdimage.ubuntu.com/ubuntu-server/jammy/daily-live/20230205/jammy-live-server-arm64.iso"]
