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
  default = "ubuntu"
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
  default = "Ubuntu_22.04_64-bit_arm"
}

source "vmware-iso" "ubuntu-2204" {
  boot_command     = [
    "e<wait>",
    "<down><down><down><end>",
    "<bs><bs><bs><wait>",
    "autoinstall net.ifnames=0 biosdevname=0 ip=dhcp ipv6.disable=1 ",
    "ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ",
    "---<wait><f10><wait>"
  ]
  boot_wait         = "5s"
  disk_size         = "${var.disk_size}"
  guest_os_type     = "arm-ubuntu-64"
  headless          = "${var.headless}"
  http_directory    = "http"
  iso_checksum      = "${var.iso_checksum_ubuntu_2204}"
  iso_urls          = "${var.iso_urls_ubuntu_2204}"
  output_directory  = "${var.vm_name}"
  shutdown_command  = "echo '${var.ssh_password}' | sudo -S shutdown -P now"
  ssh_password      = "${var.ssh_password}"
  ssh_port          = 22
  ssh_timeout       = "8000s"
  ssh_username      = "${var.ssh_username}"
  vm_name           = "${var.vm_name}"
  memory            = "${var.memory}"
  cpus              = "${var.cpus}"
  snapshot_name     = "Installed"
  disk_adapter_type = "nvme"
  disk_type_id      = "0"
  network           = "nat"
  network_adapter_type = "vmxnet3"
  sound             = "false"
  usb               = "true"
  version           = "19"
  cdrom_adapter_type = "sata"
  vmx_data = {
    "annotation"                                = "Packer version: ${packer.version}|0D|0AVM creation time: ${formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())}|0D|0AUsername: ${var.ssh_username}|0D|0APassword: ${var.ssh_password}",
    "config.version"                            = "8"
    "tools.upgrade.policy"                      = "upgradeAtPowerCycle"
    "usb_xhci:4.deviceType"                    = "hid"
    "usb_xhci:4.parent"                        = "-1"
    "usb_xhci:4.port"                          = "4"
    "usb_xhci:4.present"                       = "TRUE"
    "usb_xhci:6.deviceType"                    = "hub"
    "usb_xhci:6.parent"                        = "-1"
    "usb_xhci:6.port"                          = "6"
    "usb_xhci:6.present"                       = "TRUE"
    "usb_xhci:6.speed"                         = "2"
    "usb_xhci:7.deviceType"                    = "hub"
    "usb_xhci:7.parent"                        = "-1"
    "usb_xhci:7.port"                          = "7"
    "usb_xhci:7.present"                       = "TRUE"
    "usb_xhci:7.speed"                         = "4"
    "usb_xhci.pciSlotNumber"                   = "192"
    "usb_xhci.present"                         = "TRUE"
    "uefi.secureBoot.enabled"                  = "FALSE"
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
        "../scripts/act-clean-ubuntu_2204.sh",
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
