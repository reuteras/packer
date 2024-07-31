//  variables.pkr.hcl

// Defaults for all Debian installations
headless      = false
ssh_username  = "user"
ssh_password  = "password"

// Debian Bookworm
iso_checksum_debian = "sha256:38dc21a00ca96dab9754c9c6e8eea55549befc99dbe88d4e3c8af4bd622ab22f"
iso_urls_debian     = ["https://cdimage.debian.org/debian-cd/current/arm64/iso-cd/debian-12.6.0-arm64-netinst.iso"]
