//  variables.pkr.hcl

// Defaults for all Debian installations
headless      = false
ssh_username  = "user"
ssh_password  = "password"

// Debian 12.2
iso_checksum_debian = "sha256:23ab444503069d9ef681e3028016250289a33cc7bab079259b73100daee0af66"
iso_urls_debian     = ["https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.2.0-amd64-netinst.iso"]
