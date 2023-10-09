//  variables.pkr.hcl

// Defaults for all Debian installations
headless      = false
ssh_username  = "user"
ssh_password  = "password"

// Debian Bookworm
iso_checksum_debian = "sha256:7b8f2ff9bd422fc1cba7d5978bace17ecf48ba23842e7e7e13b0d8ba502a7556"
iso_urls_debian     = ["https://cdimage.debian.org/debian-cd/current/arm64/iso-cd/debian-12.2.0-arm64-netinst.iso"]
