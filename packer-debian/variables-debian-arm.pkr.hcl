//  variables.pkr.hcl

// Defaults for all Debian installations
headless      = false
ssh_username  = "user"
ssh_password  = "password"

// Debian Bookworm
iso_checksum_debian = "3f8211e759d19370d50e1d853859b66ecba62700d712214a8a65ed26c6d08ecc"
iso_urls_debian     = ["https://cdimage.debian.org/debian-cd/current/arm64/iso-cd/debian-13.5.0-arm64-netinst.iso"]
