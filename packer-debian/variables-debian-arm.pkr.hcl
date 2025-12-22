//  variables.pkr.hcl

// Defaults for all Debian installations
headless      = false
ssh_username  = "user"
ssh_password  = "password"

// Debian Bookworm
iso_checksum_debian = "sha256:f6df8813e4a02dec91248c7127d8150a747485d3ca7294644815ac3aeda30662"
iso_urls_debian     = ["https://cdimage.debian.org/debian-cd/current/arm64/iso-cd/debian-13.2.0-arm64-netinst.iso"]
