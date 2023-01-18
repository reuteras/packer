variable "cpus" {
  type    = string
  default = "2"
}

variable "disk_size" {
  type    = string
  default = "51200"
}

variable "headless" {
  type    = bool
  default = false
}

variable "hostname" {
  type    = string
  default = "debian"
}

variable "iso_checksum_debian" {
  type    = string
  default = ""
}

variable "iso_urls_debian" {
  type    = list(string)
  default = []
}

variable "memory" {
  type    = string
  default = "4096"
}

variable "ssh_password" {
  type    = string
  default = ""
}

variable "ssh_username" {
  type    = string
  default = ""
}

variable "vm_name" {
  type    = string
  default = "Debian_64-bit"
}

source "vmware-iso" "debian" {
  boot_command     = [
    "<esc><wait>",
    "install",
	" auto",
	" url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg",
	" debian-installer=en_US",
	" locale=en_US",
	" keymap=se",
	" netcfg/get_hostname=cuckoo",
	" netcfg/get_domain=local",
	"<enter>"
  ]
  boot_wait         = "10s"
  disk_size         = "${var.disk_size}"
  guest_os_type     = "debian10-64"
  headless          = "${var.headless}"
  http_directory    = "../debian/http"
  iso_checksum      = "${var.iso_checksum_debian}"
  iso_urls          = "${var.iso_urls_debian}"
  output_directory  = "${var.vm_name}"
  shutdown_command  = "echo '${var.ssh_password}' | sudo -S shutdown -P now"
  ssh_password      = "${var.ssh_password}"
  ssh_port          = 22
  ssh_timeout       = "8000s"
  ssh_username      = "${var.ssh_username}"
  vm_name           = "${var.vm_name}"
  memory            = "${var.memory}"
  cpus              = "${var.cpus}"
  usb               = "true"
  snapshot_name     = "Installed"
  vmx_data = {
    "annotation"    : "Packer version: ${packer.version}|0D|0AVM creation time: ${formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())}|0D|0AUsername: ${var.ssh_username}|0D|0APassword: ${var.ssh_password}",
  }
}

build {
  sources = ["source.vmware-iso.debian"]

  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    scripts         = [
        "../scripts/setup.sh",
        "../scripts/setup-debian.sh"
    ]
  }

  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    scripts         = [
        "../scripts/cleanup.sh"
    ]
  }
}
