//  variables.pkr.hcl

// Defaults for all Debian installations
headless      = false
ssh_username  = "user"
ssh_password  = "password"

// Debian 11.6
iso_checksum_debian = "sha256:e482910626b30f9a7de9b0cc142c3d4a079fbfa96110083be1d0b473671ce08d"
iso_urls_debian     = ["https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.6.0-amd64-netinst.iso"]
