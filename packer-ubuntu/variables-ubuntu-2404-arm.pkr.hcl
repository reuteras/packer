//  variables-ubuntu-2404.pkr.hcl

// Defaults for all Ubuntu installations
headless      = "true"
ssh_username  = "malware"
ssh_password  = "password"

// Ubuntu 24.04 LTS
iso_checksum_ubuntu_2404_arm = "sha256:d2d9986ada3864666e36a57634dfc97d17ad921fa44c56eeaca801e7dab08ad7"
iso_urls_ubuntu_2404_arm     = ["https://cdimage.ubuntu.com/releases/24.04/release/ubuntu-24.04-live-server-arm64.iso"]
