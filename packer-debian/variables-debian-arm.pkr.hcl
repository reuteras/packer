//  variables.pkr.hcl

// Defaults for all Debian installations
headless     = false
ssh_username = "user"
ssh_password = "password"

// Debian Trixie
iso_checksum_debian = "f4e05f67b5c74e3ff7b24c2a8f889960f9eb31fe0c1ac8513d27d5656958b6b3"
iso_urls_debian     = ["https://cdimage.debian.org/debian-cd/current/arm64/iso-cd/debian-13.8.0-arm64-netinst.iso"]
