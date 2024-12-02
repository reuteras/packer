//  variables.pkr.hcl

// Defaults for all Debian installations
headless      = false
ssh_username  = "user"
ssh_password  = "password"

// Debian Bookworm
iso_checksum_debian = "sha256:b242a2c76375fb0b912afbc31bbf9a4c27276524daeea4e65e3d0da83eee9931"
iso_urls_debian     = ["https://cdimage.debian.org/debian-cd/current/arm64/iso-cd/debian-12.8.0-arm64-netinst.iso"]
