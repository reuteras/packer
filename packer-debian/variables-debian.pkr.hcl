//  variables.pkr.hcl

// Defaults for all Debian installations
headless      = "true"
ssh_username  = "user"
ssh_password  = "password"

// Debian Bookworm
iso_checksum_debian = "sha256:ade3a4acc465f59ca2496344aab72455945f3277a52afc5a2cae88cdc370fa12"
iso_urls_debian     = ["https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.6.0-amd64-netinst.iso"]
