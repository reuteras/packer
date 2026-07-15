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
  default = "Kali_64-bit_arm"
}

source "qemu" "kali" {
  qemu_binary  = "../scripts/qemu-arm64-wrapper.sh"
  machine_type = "virt"
  cpu_model    = "host"
  accelerator  = "hvf"

  efi_firmware_code = "/opt/homebrew/share/qemu/edk2-aarch64-code.fd"
  efi_firmware_vars = "/opt/homebrew/share/qemu/edk2-arm-vars.fd"

  boot_command = [
    "<wait5>c<wait5>",
    "linux /install.a64/vmlinuz",
    " auto=true",
    " priority=critical",
    " console-setup/ask_detect=false",
    " console-setup/layoutcode=sv",
    " console-setup/modelcode=pc105",
    " debconf/frontend=noninteractive",
    " debian-installer=en_US",
    " fb=false",
    " console=tty0",
    " netcfg/choose_interface=eth0",
    " kbd-chooser/method=sv",
    " console-keymaps-at/keymap=sv",
    " keyboard-configuration/xkb-keymap=sv",
    " keyboard-configuration/layout=Sweden",
    " grub-installer/bootdev=default",
    " netcfg/get_domain=vm",
    " netcfg/get_hostname=kali",
    " locale=en_US",
    " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg",
    " quiet<enter><wait5>",
    "initrd /install.a64/initrd.gz<enter><wait2>",
    "boot<enter>"
  ]
  boot_wait = "30s"

  disk_size       = var.disk_size
  disk_interface  = "virtio"
  cdrom_interface = "scsi"
  format          = "qcow2"

  net_device     = "virtio-net"

  http_directory = "http"

  iso_checksum = var.iso_checksum_kali
  iso_urls     = var.iso_urls_kali

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
  sources = ["source.qemu.kali"]

  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    scripts = [
      "../scripts/kali-tools-kali.sh"
    ]
  }

  provisioner "shell" {
    execute_command = "{{ .Vars }} bash '{{ .Path }}'"
    scripts = [
      "../../scripts/user-setup.sh"
    ]
  }

  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    inline = [
      "ROOT_UUID=$(blkid -s UUID -o value $(findmnt -n -o SOURCE /))",
      "sed -i \"s|root=/dev/vd[a-z][0-9]*|root=UUID=$${ROOT_UUID}|g\" /boot/grub/grub.cfg"
    ]
  }

  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    scripts = [
      "../scripts/cleanup.sh"
    ]
  }
}
