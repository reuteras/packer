//  variables.pkr.hcl

// Defaults for all Ubuntu installations
headless      = false
ssh_username  = "user"
ssh_password  = "password"

// Ubuntu 20.04 LTS
iso_checksum_centos_8_stream = "sha256:07b94e6b1a0b0260b94c83d6bb76b26bf7a310dc78d7a9c7432809fb9bc6194a"
iso_urls_centos_8_stream     = ["http://mirrors.glesys.net/CentOS/8-stream/isos/x86_64/CentOS-Stream-8-x86_64-20210706-boot.iso"]
