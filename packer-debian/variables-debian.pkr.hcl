//  variables.pkr.hcl

// Defaults for all Debian installations
headless      = false
ssh_username  = "user"
ssh_password  = "password"

// Debian Bookworm
iso_checksum_debian = "65273beed27b2df543b68b65630ba525cfbad8df2b12035732b2dff87d6664e7"
iso_urls_debian     = ["https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-13.6.0-amd64-netinst.iso"]
