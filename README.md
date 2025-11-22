# Packer

This repo contains scripts and configuration to build virtual machines on macOS and Windows with the help of packer and VMware. At the moment I don't have a macOS machine with an Intel processor so those scripts are not tested. Since VMware Fusion for arm is in beta no real effort is made to support that platform.

## Instructions on Windows

To get started install VMware Workstation, [packer][pai] and git. My recommendation is to install git with the command **winget**. Run the following in a Windows Terminal:

```bash
winget install Git.Git
```

You have to add *C:\Program Files\Git\bin* to the Path environment variable. Also make sure that you have VMware in the path, *C:\Program Files (x86)\VMware\VMware Workstation*.

Then start a new terminal and change to folder where you like to check out the repo. Then use git to check it out and configure some defaults.

```bash
git clone https://github.com/reuteras/packer.git
cd packer
# Open and configure the default values
<editor> defaults.ps1
```

To build a VM use **cd** to change to the folder for base image you would like to use. The following are available for Windows

- packer-kali
- packer-ubuntu

## packerconfig.pkr.hcl

My *packerconfig.pkr.hcl* file contains the following.

```yaml
packer {
  required_plugins {
    digitalocean = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/digitalocean"
    }
    vmware = {
      source  = "github.com/hashicorp/vmware"
      version = "~> 1"
    }
  }
}
```

To install the dependencies I use the following command (update for your path) on macOS (arm64).

```bash
packer init -upgrade ~/.packer.d/.packerconfig.pkr.hcl
```

## FAQ

### Packer Build Error with VMware Workstation 16

If you have problems building with Packer with VMware Workstation 16 read the blog [post][pbe]. In short the solution is to the following steps.

- In Workstation go to Edit...Virtual Network Editor
- Click Change Settings
- Don’t change anything, just click OK

## TODO

Update the code and fix (among other things):

- Better preseed.cfg can cloud-init files
- Use templates

## Bugs

There will be bugs so please file a report when you find them.

## Support

<a href="https://www.buymeacoffee.com/reuteras" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>


  [deb]: https://debian.org
  [kal]: https://www.kali.org
  [kat]: https://github.com/reuteras/kali-tools
  [mal]: https://github.com/reuteras/malir
  [pai]: https://www.packer.io/downloads
  [pbe]: https://www.vgemba.net/vmware/Packer-Workstation-Error
  [rem]: https://remnux.org
  [ret]: https://github.com/reuteras/remnux-tools
  [sif]: https://digital-forensics.sans.org/community/downloads/
  [w10]: https://www.microsoft.com/en-us/windows
  [wse]: https://www.microsoft.com/en-us/cloud-platform/windows-server
