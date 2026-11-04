# Packer

This repo contains scripts and configuration to build virtual machines on macOS and Windows with the help of packer and VMware. At the moment I don't have a macOS machine with an Intel processor so those scripts are not tested.

## Instructions on macOS (Apple Silicon)

The arm64 VMs are built with QEMU (hvf) and converted to VMware Fusion VMs. Install the dependencies with Homebrew:

```bash
brew install just packer qemu
```

Then build and install a VM from its folder, for example REMnux:

```bash
cd packer-ubuntu
just build-remnux-arm-qemu
just install
```

Available recipes (run `just --list` in a folder to see them):

- packer-debian: `build-debian-arm-qemu`, `build-arkime-arm-qemu`, `build-malcolm-arm-qemu`
- packer-kali: `build-kali-arm-qemu`
- packer-ubuntu: `build-ubuntu-2404-arm-qemu`, `build-remnux-arm-qemu`

Each build ends with `scripts/qcow2-to-fusion.sh`, which converts the disk to VMDK, writes a `.vmx` and takes an `Installed` snapshot. `just install` moves the VM to `~/Virtual Machines.localized` and opens it in Fusion.

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

## Bugs

There will be bugs so please file a report when you find them.

## Support

<a href="https://www.buymeacoffee.com/reuteras" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>

  [pai]: https://www.packer.io/downloads
  [pbe]: https://www.vgemba.net/vmware/Packer-Workstation-Error
