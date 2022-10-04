variable "cpus" {
  type    = string
  default = "2"
}

variable "disk_size" {
  type    = string
  default = "512000"
}

variable "headless" {
  type    = bool
  default = false
}

variable "hostname" {
  type    = string
  default = "malcolm"
}

variable "iso_checksum_ubuntu_2204" {
  type    = string
  default = ""
}

variable "iso_urls_ubuntu_2204" {
  type    = list(string)
  default = []
}

variable "memory" {
  type    = string
  default = "40964"
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
  default = "Malcolm"
}

source "vmware-iso" "ubuntu-2204" {
  boot_command     = [
    "c<wait>",
    "linux /casper/vmlinuz --- autoinstall ds=\"nocloud-net;seedfrom=http://{{.HTTPIP}}:{{.HTTPPort}}/\"",
    "<enter><wait>",
    "initrd /casper/initrd",
    "<enter><wait>",
    "boot",
    "<enter>"
  ]
  boot_wait        = "10s"
  disk_size        = "${var.disk_size}"
  guest_os_type    = "ubuntu64Guest"
  headless         = "${var.headless}"
  http_directory   = "../ubuntu-2204/http"
  iso_checksum     = "${var.iso_checksum_ubuntu_2204}"
  iso_urls         = "${var.iso_urls_ubuntu_2204}"
  output_directory = "${var.vm_name}"
  shutdown_command = "echo '${var.ssh_password}' | sudo -S shutdown -P now"
  ssh_password     = "${var.ssh_password}"
  ssh_port         = 22
  ssh_timeout      = "8000s"
  ssh_username     = "${var.ssh_username}"
  vm_name          = "${var.vm_name}"
  memory           = "${var.memory}"
  cpus             = "${var.cpus}"
  vmx_data = {
    annotation                = "Packer version: ${packer.version}|0AVM creation time: ${formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())}\nUsername: ${var.ssh_username}\nPassword: ${var.ssh_password}"
  }
}

build {
  sources = ["source.vmware-iso.ubuntu-2204"]

  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    scripts         = [
        "../scripts/setup.sh",
        "../scripts/disable_ipv6.sh",
        "../scripts/gui.sh"
    ]
  }

  provisioner "shell" {
    execute_command = "{{ .Vars }} bash '{{ .Path }}'"
    scripts         = [
        "../scripts/malcolm.sh",
        "../scripts/fix-malcolm.sh",
        "../scripts/user-setup.sh"
    ]
  }
  
  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    scripts         = [
        "../scripts/cleanup.sh"
    ]
  }

  post-processor "shell-local" {
    inline = ["vmrun -T ws snapshot ${var.vm_name}/${var.vm_name}.vmx Installed"]
  }
}
