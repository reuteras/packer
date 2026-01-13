//  variables.pkr.hcl

// Defaults for all Debian installations
headless      = false
ssh_username  = "user"
ssh_password  = "password"

// Debian Bookworm
iso_checksum_debian = "10aa125ac1a74de9366ba624e71fb892fbc2e7863be85e966973f43d018698a6"
iso_urls_debian     = ["https://cdimage.debian.org/debian-cd/current/arm64/iso-cd/debian-13.3.0-arm64-netinst.iso"]
