variable "cpus" {
  type    = string
  default = "2"
}

variable "disk_size" {
  type    = string
  default = "512000"
}

variable "headless" {
  type    = string
  default = "false"
}

variable "hostname" {
  type    = string
  default = "kali"
}

variable "iso_checksum_kali" {
  type    = string
  default = ""
}

variable "iso_urls_kali" {
  type    = list(string)
  default = []
}

variable "memory" {
  type    = string
  default = "8192"
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
  default = "Kali"
}

source "vmware-iso" "kali" {
  boot_command     = [
    "<esc><wait>", 
    "/install.amd/vmlinuz<wait>",
    " grub-installer/bootdev=/dev/sda<wait>",
    " initrd=/install.amd/initrd.gz<wait>",
    " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg auto=true priority=critical",
    " -- <wait>",
    "<enter><wait>"
  ]
  boot_wait         = "10s"
  disk_size         = "${var.disk_size}"
  guest_os_type     = "debian12-64"
  headless          = "${var.headless}"
  http_directory    = "../http"
  iso_checksum      = "${var.iso_checksum_kali}"
  iso_urls          = "${var.iso_urls_kali}"
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
    "mks.enable3d"  : "TRUE"
  }
}

build {
  sources = ["source.vmware-iso.kali"]

  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    scripts         = [
        "../scripts/kali-tools-kali.sh"
    ]
  }

  provisioner "shell" {
    execute_command = "{{ .Vars }} bash '{{ .Path }}'"
    scripts         = [
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

packer {
  required_plugins {
    vmware = {
      version = "~> 1"
      source = "github.com/hashicorp/vmware"
    }
  }
}

