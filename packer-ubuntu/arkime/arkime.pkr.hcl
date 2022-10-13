variable "password" {
  type    = string
  default = ""
}

variable "username" {
  type    = string
  default = ""
}

source "vmware-iso" "arkime" {
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
    " netcfg/get_hostname=arkime",
    " keyboard-configuration/xkb-keymap=sv",
    " keyboard-configuration/layout=Sweden",
    " keyboard-configuration/variant=Sweden",
    "<enter><wait>"
  ]
  boot_wait        = "10s"
  disk_size        = 102400
  guest_os_type    = "ubuntu64Guest"
  headless         = false
  http_directory   = "http"
  iso_checksum     = "sha256:0e79e00bf844929d40825b1f0e8634415cda195ba23bae0b041911fde4dfe018"
  iso_urls         = ["http://archive.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/current/legacy-images/netboot/mini.iso"]
  output_directory = "Arkime_64-bit"
  shutdown_command = "echo 'password' | sudo -S shutdown -P now"
  ssh_password     = "password"
  ssh_port         = 22
  ssh_timeout      = "8000s"
  ssh_username     = "malware"
  usb              = "true"
  snapshot_name    = "Installed"
  vm_name          = "Arkime_64-bit"
  vmx_data = {
    annotation                = "Packer version: ${packer.version}|0AVM creation time: ${formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())}"
    "cpuid.coresPerSocket"    = "1"
    memsize                   = "4096"
    numvcpus                  = "2"
  }
}

build {
  sources = ["source.vmware-iso.arkime"]

  provisioner "shells" {
    execute_command = "echo 'password' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    script          = [
        "../scripts/setup.sh",
        "../scripts/disable_ipv6.sh"
  }

  provisioner "shells" {
    execute_command = "{{ .Vars }} bash '{{ .Path }}'"
    script          = [
        "../scripts/arkime.sh"
    ]
  }

  provisioner "shells" {
    execute_command = "echo 'password' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    script          = [
        "../scripts/remnux-tools-cleanup.sh"
    ]
  }
}
