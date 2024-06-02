packer {
  required_plugins {
    vmware = {
      source  = "github.com/hashicorp/vmware"
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
    "<wait><wait><wait>c<wait><wait><wait>",
    "linux /install.a64/vmlinuz ",
    "auto=true ",
    "language=en ",
    "country=SV ",
    "locale=en_US.UTF-8 ",
    "keymap=se ",
    "url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
    "hostname=${var.hostname} ",
    "domain=localdomain ",
    "interface=auto ",
    "vga=788 noprompt quiet --<enter>",
    "initrd /install.a64/initrd.gz<enter>",
    "boot<enter>"
  ]
  boot_wait         = "3s"
  disk_size         = "${var.disk_size}"
  guest_os_type     = "arm-debian12-64"
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
  disk_adapter_type = "nvme"
  disk_type_id      = "0"
  network           = "nat"
  network_adapter_type = "vmxnet3"
  sound             = "true"
  version           = "19"
  cdrom_adapter_type = "sata"
  vmx_data = {
    "annotation"                                = "Packer version: ${packer.version}|0D|0AVM creation time: ${formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())}|0D|0AUsername: ${var.ssh_username}|0D|0APassword: ${var.ssh_password}",
    "config.version"                            = "8"
    "sound.autoDetect"                          = "TRUE"
    "sound.virtualDev"                          = "hdaudio"
    "sound.fileName"                            = "-1"
    "sound.present"                             = "TRUE"
    "tools.upgrade.policy"                      = "upgradeAtPowerCycle"
    "usb_xhci:4.deviceType"                     = "hid"
    "usb_xhci:4.parent"                         = "-1"
    "usb_xhci:4.port"                           = "4"
    "usb_xhci:4.present"                        = "TRUE"
    "usb_xhci:6.deviceType"                     = "hub"
    "usb_xhci:6.parent"                         = "-1"
    "usb_xhci:6.port"                           = "6"
    "usb_xhci:6.present"                        = "TRUE"
    "usb_xhci:6.speed"                          = "2"
    "usb_xhci:7.deviceType"                     = "hub"
    "usb_xhci:7.parent"                         = "-1"
    "usb_xhci:7.port"                           = "7"
    "usb_xhci:7.present"                        = "TRUE"
    "usb_xhci:7.speed"                          = "4"
    "usb_xhci.pciSlotNumber"                    = "192"
    "usb_xhci.present"                          = "TRUE"
    "uefi.secureBoot.enabled"                   = "FALSE"
  }
  vmx_data_post = {
    "sata0:0.autodetect"     = "TRUE"
    "sata0:0.deviceType"     = "cdrom-raw"
    "sata0:0.fileName"       = "auto detect"
    "sata0:0.startConnected" = "FALSE"
    "sata0:0.present"        = "TRUE"
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
    execute_command = "{{ .Vars }} bash '{{ .Path }}'"
    scripts         = [
        "../scripts/user-setup.sh"
    ]
  }

  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    scripts         = [
        "../scripts/cleanup.sh"
    ]
  }
}
