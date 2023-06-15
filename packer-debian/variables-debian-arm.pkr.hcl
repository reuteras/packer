//  variables.pkr.hcl

// Defaults for all Debian installations
headless      = false
ssh_username  = "user"
ssh_password  = "password"

// Debian 12.0
iso_checksum_debian = "sha256:e455263fb33c71ebf8396a823cdc15ca75786efd2e86172c067a97b1fa9924a5"
iso_urls_debian     = ["https://cdimage.debian.org/debian-cd/current/arm64/iso-cd/debian-12.0.0-arm64-netinst.iso"]
