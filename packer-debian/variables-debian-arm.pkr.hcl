//  variables.pkr.hcl

// Defaults for all Debian installations
headless     = false
ssh_username = "user"
ssh_password = "password"

// Debian Bookworm
iso_checksum_debian = "6e93fa1759bd9d4b0fc11e938987de6967ee7de5297dac1be27c3a75cc17024b"
iso_urls_debian     = ["https://cdimage.debian.org/debian-cd/current/arm64/iso-cd/debian-13.7.0-arm64-netinst.iso"]
