//  variables-ubuntu-2404.pkr.hcl

// Defaults for all Ubuntu installations
headless     = "true"
ssh_username = "malware"
ssh_password = "password"

// Ubuntu 24.04 LTS
iso_checksum_ubuntu = "sha256:97f3d7ffb032c3eb3b23d2c8be9cc76e60c2c1f2c0146ba5ba9fe01cafae0fd8"
iso_urls_ubuntu     = ["https://releases.ubuntu.com/24.04/ubuntu-24.04.5-live-server-amd64.iso"]
