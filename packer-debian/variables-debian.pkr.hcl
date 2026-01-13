//  variables.pkr.hcl

// Defaults for all Debian installations
headless      = "true"
ssh_username  = "user"
ssh_password  = "password"

// Debian Bookworm
iso_checksum_debian = "c9f09d24b7e834e6834f2ffa565b33d6f1f540d04bd25c79ad9953bc79a8ac02"
iso_urls_debian     = ["https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-13.3.0-amd64-netinst.iso"]
