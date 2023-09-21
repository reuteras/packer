//  variables.pkr.hcl

// Defaults for all Debian installations
headless      = false
ssh_username  = "user"
ssh_password  = "password"

// Debian Bookworm
iso_checksum_debian = "sha256:b58e02fe14a52c1dfdacc0ccd6bc9b4edf385c7e8cea1871a3b0fccb6438700b"
iso_urls_debian     = ["https://cdimage.debian.org/debian-cd/current/arm64/iso-cd/debian-12.1.0-arm64-netinst.iso"]
