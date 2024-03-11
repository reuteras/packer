variable "cpus" {
  type    = string
  default = "2"
}

variable "disk_size" {
  type    = string
  default = "51200"
}

variable "headless" {
  type    = string
  default = "true"
}

variable "hostname" {
  type    = string
  default = "ubuntu"
}

variable "iso_checksum_ubuntu_2004" {
  type    = string
  default = ""
}

variable "iso_urls_ubuntu_2004" {
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
  default = "Ubuntu_20.04_64-bit"
}

source "vmware-iso" "ubuntu-2004" {
  boot_command     = [
    "<tab>",
    " url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg",
    " auto=true",
    " locale=en_US",
    " console-setup/ask_detect=false",
    " console-setup/layoutcode=sv",
    " console-setup/modelcode=pc105",
    " debian-installer=en_US",
    " initrd=/install/initrd.gz",
    " netcfg/get_hostname=${var.hostname}",
    " keyboard-configuration/xkb-keymap=sv",
    " keyboard-configuration/layout=Sweden",
    " keyboard-configuration/variant=Sweden",
    "<enter><wait>"
  ]
  boot_wait         = "10s"
  disk_size         = "${var.disk_size}"
  guest_os_type     = "ubuntu-64"
  headless          = "${var.headless}"
  http_directory    = "../http"
  iso_checksum      = "${var.iso_checksum_ubuntu_2004}"
  iso_urls          = "${var.iso_urls_ubuntu_2004}"
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
  vmx_data          = {
                        "annotation"    : "Packer version: ${packer.version}|0D|0AVM creation time: ${formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())}|0D|0AUsername: ${var.ssh_username}|0D|0APassword: ${var.ssh_password}",
                    }
}

build {
  sources = ["source.vmware-iso.ubuntu-2004"]

  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    scripts         = [
                        "../scripts/setup.sh",
                        "../scripts/disable_ipv6.sh",
    ]
  }

  provisioner "shell" {
    execute_command = "{{ .Vars }} bash '{{ .Path }}'"
    scripts         = [
                        "../scripts/act-clean-ubuntu_2004.sh",
                        "../../scripts/user-setup.sh"
    ]
  }
  
  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    scripts         = [
                        "../scripts/cleanup.sh"
    ]
  }
}
