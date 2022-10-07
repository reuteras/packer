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
  default = "Kali"
}

source "vmware-iso" "kali" {
  boot_command     = [
    "<esc><wait>", 
    "/install.amd/vmlinuz<wait>",
    " auto<wait>",
    " console-setup/ask_detect=false<wait>",
    " console-setup/layoutcode=sv<wait>",
    " console-setup/modelcode=pc105<wait>",
    " debconf/frontend=noninteractive<wait>",
    " debian-installer=en_US<wait>", " fb=false<wait>",
    " initrd=/install.amd/initrd.gz<wait>",
    " kbd-chooser/method=sv<wait>",
    " netcfg/choose_interface=eth0<wait>",
    " console-keymaps-at/keymap=sv<wait>",
    " keyboard-configuration/xkb-keymap=sv<wait>",
    " keyboard-configuration/layout=Sweden<wait>",
    " keyboard-configuration/variant=Sweden<wait>",
    " locale=en_US<wait>",
    " netcfg/get_domain=vm<wait>",
    " netcfg/get_hostname=kali<wait>",
    " grub-installer/bootdev=/dev/sda<wait>",
    " noapic<wait>",
    " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg auto=true priority=critical",
    " -- <wait>",
    "<enter><wait>"
  ]
  boot_wait         = "10s"
  disk_size         = "${var.disk_size}"
  guest_os_type     = "debian10-64"
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
  
  post-processor "shell-local" {
    inline = ["vmrun -T ws snapshot ${var.vm_name}/${var.vm_name}.vmx Installed"]
  }
}
