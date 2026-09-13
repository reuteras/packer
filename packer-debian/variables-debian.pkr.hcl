//  variables.pkr.hcl

// Defaults for all Debian installations
headless     = false
ssh_username = "user"
ssh_password = "password"

// Debian Bookworm
iso_checksum_debian = "a7ef94ac2fb9a7fec454552abd629b7cc9d5155c886165a45649f5ce6167e355"
iso_urls_debian     = ["https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-13.7.0-amd64-netinst.iso"]
