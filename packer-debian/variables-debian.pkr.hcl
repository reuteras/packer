//  variables.pkr.hcl

// Defaults for all Debian installations
headless      = "true"
ssh_username  = "user"
ssh_password  = "password"

// Debian Bookworm
iso_checksum_debian = "sha256:013f5b44670d81280b5b1bc02455842b250df2f0c6763398feb69af1a805a14f"
iso_urls_debian     = ["https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.5.0-amd64-netinst.iso"]
