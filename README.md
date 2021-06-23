# Packer

## VMs for work and home

For some years I've maintained a couple of scripts to install and configure SIFT, [REMnux](https://remnux.org), Kali and Cuckoo with some addons that I like for each tool and distribution. To run the scripts I've had to install the base OS manually which resulted in subtle differences every time. It is easy to forget to change memory or disk size or miss a package that I use to install etc.

I've finally started to test [packer.io](https://www.packer.io/) and as always I found that this is a extremely useful tool I should have used much earlier. So far I've created scripts to build VMs based on Ubuntu, Debian and Kali.

### Debian

Available in the subdirectory **packer-debian** and has two make targets:

* cuckoo - debian-cuckoo.json - install [Debian](https://debian.org) and then run my script [cuckoo-tools](https://github.com/reuteras/cuckoo-tools) to install [Cuckoo Sandbox](https://www.cuckoosandbox.org).
* debian - debian.json - install a basic [Debian](https://debian.org) host.

### Ubuntu

Available in **packer-ubuntu** and has three targets:

* remnux - ubuntu-remnux-tools-remnux.json - install [REMnux](https://remnux.org) and some additions with my [remnux-tools](https://github.com/reuteras/remnux-tools) repo.
* sift - ubuntu-remnux-tools-sift.json - install [SIFT](https://digital-forensics.sans.org/community/downloads/) and some additions with my [remnux-tools](https://github.com/reuteras/remnux-tools) repo
* ubuntu - ubuntu.json - install a basic [Ubuntu](https://www.ubuntu.com/)

### Kali

* kali - kali.json - my script [kali-tools](https://github.com/reuteras/kali-tools) to do a very basic install of [Kali](https://www.kali.org).

### Manual steps

At the moment you have to add a usb controller manually.

## TODO

Create configurations for

* [Fedora](https://getfedora.org/)
* [CentOS](https://centos.org/)
* [Security Onion](https://securityonion.net/)
* [pfSense](https://pfsense.org/)
* [Windows 10](https://www.microsoft.com/en-us/windows) and [server](https://www.microsoft.com/en-us/cloud-platform/windows-server)

Other things to do:

* Better preseed.cfg files
* Use templates
* And much more :)

## Support

<a href="https://www.buymeacoffee.com/reuteras" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>
