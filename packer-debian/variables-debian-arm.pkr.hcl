//  variables.pkr.hcl

// Defaults for all Debian installations
headless      = false
ssh_username  = "user"
ssh_password  = "password"

// Debian Bookworm
iso_checksum_debian = "ffa590beb3ae9158c354e00ebc4bf45421f4720bb3a8ddf2db3cbfc0374cf480"
iso_urls_debian     = ["https://cdimage.debian.org/debian-cd/current/arm64/iso-cd/debian-13.6.0-arm64-netinst.iso"]
