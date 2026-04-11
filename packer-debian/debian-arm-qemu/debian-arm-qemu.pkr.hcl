packer {
  required_plugins {
    qemu = {
      source  = "github.com/hashicorp/qemu"
      version = "~> 1"
    }
  }
}

variable "cpus" {
  type    = string
  default = "2"
}

variable "disk_size" {
  type    = number
  default = 102400
}

variable "headless" {
  type    = bool
  default = true
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
  default = "Debian_64-bit"
}

source "qemu" "debian" {
  qemu_binary  = "../scripts/qemu-arm64-wrapper.sh"
  machine_type = "virt"
  cpu_model    = "host"
  accelerator  = "hvf"

  efi_firmware_code = "/opt/homebrew/share/qemu/edk2-aarch64-code.fd"
  efi_firmware_vars = "/opt/homebrew/share/qemu/edk2-arm-vars.fd"

  boot_command = [
    "c<wait5>",
    "linux /install.a64/vmlinuz ",
    "auto=true ",
    "language=en ",
    "country=SE ",
    "locale=en_US.UTF-8 ",
    "keymap=se ",
    "url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
    "hostname=${var.hostname} ",
    "domain=localdomain ",
    "interface=auto ",
    "noprompt quiet --<enter>",
    "initrd /install.a64/initrd.gz<enter>",
    "boot<enter>"
  ]
  boot_wait = "30s"

  disk_size       = var.disk_size
  disk_interface  = "virtio"
  cdrom_interface = "scsi"
  format          = "qcow2"

  net_device     = "virtio-net"

  http_directory = "../http"

  iso_checksum = var.iso_checksum_debian
  iso_urls     = var.iso_urls_debian

  output_directory = var.vm_name
  vm_name          = "${var.vm_name}.qcow2"

  shutdown_command = "echo '${var.ssh_password}' | sudo -S shutdown -P now"

  headless = var.headless
  display  = "cocoa"

  ssh_username = var.ssh_username
  ssh_password = var.ssh_password
  ssh_port     = 22
  ssh_timeout  = "8000s"

  cpus   = var.cpus
  memory = var.memory

  qemuargs = [
    ["-device", "virtio-gpu"],
    ["-device", "qemu-xhci"],
    ["-device", "usb-kbd"],
  ]
}

build {
  sources = ["source.qemu.debian"]

  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    scripts = [
      "../scripts/setup.sh",
      "../scripts/setup-debian.sh"
    ]
  }

  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | {{ .Vars }} bash '{{ .Path }}'"
    scripts = [
      "../scripts/user-setup.sh",
      "../../scripts/user-setup.sh"
    ]
  }

  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    scripts = [
      "../scripts/cleanup.sh"
    ]
  }
}
