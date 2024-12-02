//  variables.pkr.hcl

// Defaults for all Debian installations
headless      = "true"
ssh_username  = "user"
ssh_password  = "password"

// Debian Bookworm
iso_checksum_debian = "sha256:04396d12b0f377958a070c38a923c227832fa3b3e18ddc013936ecf492e9fbb3"
iso_urls_debian     = ["https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.8.0-amd64-netinst.iso"]
