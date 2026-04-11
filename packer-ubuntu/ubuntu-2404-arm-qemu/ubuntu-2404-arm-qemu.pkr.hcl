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
  type    = string
  default = "102400"
}

variable "headless" {
  type    = bool
  default = true
}

variable "hostname" {
  type    = string
  default = "ubuntu"
}

variable "iso_checksum_ubuntu_2404_arm" {
  type    = string
  default = ""
}

variable "iso_urls_ubuntu_2404_arm" {
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
  default = "Ubuntu_24.04_64-bit_arm"
}

source "qemu" "ubuntu-2404" {
  qemu_binary  = "../scripts/qemu-arm64-wrapper.sh"
  machine_type = "virt"
  cpu_model    = "host"
  accelerator  = "hvf"

  efi_firmware_code = "/opt/homebrew/share/qemu/edk2-aarch64-code.fd"
  efi_firmware_vars = "/opt/homebrew/share/qemu/edk2-arm-vars.fd"

  boot_command = [
    "c<wait>",
    "linux /casper/vmlinuz autoinstall quiet ds=\"nocloud-net;seedfrom=http://{{.HTTPIP}}:{{.HTTPPort}}/\"",
    "<enter><wait>",
    "initrd /casper/initrd",
    "<enter><wait>",
    "boot",
    "<enter>"
  ]
  boot_wait = "30s"

  disk_size       = var.disk_size
  disk_interface  = "virtio"
  cdrom_interface = "scsi"
  format          = "qcow2"

  net_device     = "virtio-net"

  http_directory = "http"

  iso_checksum = var.iso_checksum_ubuntu_2404_arm
  iso_urls     = var.iso_urls_ubuntu_2404_arm

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
  sources = ["source.qemu.ubuntu-2404"]

  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    scripts = [
      "../scripts/setup.sh",
      "../scripts/disable_ipv6.sh",
      "../scripts/gui.sh"
    ]
  }

  provisioner "shell" {
    execute_command = "{{ .Vars }} bash '{{ .Path }}'"
    scripts = [
      "../scripts/act-clean-ubuntu_2404.sh",
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
