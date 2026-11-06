# Packer

This repo contains scripts and configuration to build virtual machines on macOS, Windows and Linux with the help of packer and VMware. At the moment I don't have a macOS machine with an Intel processor so those scripts are not tested.

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
- packer-ubuntu: `build-ubuntu-2404-arm-qemu`, `build-remnux-arm-qemu`, `build-sift-arm-qemu`

Each build ends with `scripts/qcow2-to-fusion.sh`, which converts the disk to VMDK, writes a `.vmx` and takes an `Installed` snapshot. `just install` moves the VM to `~/Virtual Machines.localized` and opens it in Fusion.

## Instructions on Windows

Install VMware Workstation, [packer][pai], [just][just] and git, for example with **winget**. Run the following in a Windows Terminal:

```powershell
winget install Git.Git Casey.Just Hashicorp.Packer
```

Make sure `packer`, `just` and `vmrun` (*C:\Program Files\VMware\VMware Workstation*) are in the Path. PowerShell 7 (`pwsh`) is required.

Then start a new terminal, check out the repo and configure some defaults (VM and shared folder locations; the directories must exist).

```powershell
git clone https://github.com/reuteras/packer.git
cd packer
<editor> defaults.ps1
```

Build a VM from its folder with just:

```powershell
cd packer-debian
just build-debian
```

Available recipes on Windows (amd64): `packer-debian`: `build-debian`, `packer-kali`: `build-kali`, `packer-ubuntu`: `build-ubuntu-2404`, `build-remnux`, `build-sift`.

Each recipe runs `scripts/build-vm.ps1`, which runs `packer init` and `packer build`, moves the VM to the folder set in *defaults.ps1*, adds the shared folders, takes a `Secure` snapshot and opens the VM.

## Instructions on Linux

Install VMware Workstation Pro, [packer][pai] and [just][just] (`vmrun` and `vmware` must end up on your `$PATH`; the Workstation installer normally puts them in `/usr/bin`).

Then check out the repo and configure some defaults (VM and shared folder locations; the directories must exist).

```bash
git clone https://github.com/reuteras/packer.git
cd packer
<editor> defaults.sh
```

Build a VM from its folder with just:

```bash
cd packer-debian
just build-debian
```

Available recipes on Linux (amd64): `packer-debian`: `build-debian`, `packer-kali`: `build-kali`, `packer-ubuntu`: `build-ubuntu-2404`, `build-remnux`, `build-sift`.

Each recipe runs `scripts/build-vm.sh`, which runs `packer init` and `packer build`, moves the VM to the folder set in *defaults.sh*, adds the shared folders, takes a `Secure` snapshot and opens the VM. This mirrors the Windows flow (`build-vm.ps1`), just with `vmrun -T ws` / `vmware` invoked from bash instead of PowerShell.

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

### Secure Boot blocks vmmon/vmnet on Linux

If `vmware.service` fails to start (`systemctl status vmware` shows "Virtual machine monitor - failed" and/or "Virtual ethernet - failed") and Secure Boot is enabled (`mokutil --sb-state`), the kernel is refusing to load the unsigned `vmmon`/`vmnet` modules VMware built for your kernel. Sign them with your own key and enroll it via MOK. This is a one-time setup, but the modules must be re-signed after every kernel upgrade that rebuilds them.

```bash
sudo -i bash
mkdir -p /root/module-signing
cd /root/module-signing
openssl req -new -x509 -newkey rsa:2048 -keyout MOK.priv -outform DER -out MOK.der -nodes -days 36500 -subj "/CN=VMware module signing key/"
mokutil --import MOK.der          # sets an enrollment password
reboot
```

At boot, the blue MokManager screen appears -> "Enroll MOK" -> enter the password -> confirm.

After reboot, check that the installed kernel headers actually match the **running** kernel - if a kernel update landed at the same reboot (common with unattended-upgrades), they won't, `sign-file` won't exist yet, and VMware won't have built `vmmon.ko`/`vmnet.ko` for the new kernel either:

```bash
uname -r                                     # running kernel
dpkg -l | grep linux-headers                 # must include a line matching `uname -r`
sudo apt install linux-headers-$(uname -r)   # if it's missing
sudo vmware-modconfig --console --install-all # rebuilds vmmon.ko/vmnet.ko for this kernel
```

Then sign and load the (now present, matching) modules:

```bash
sudo /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 \
  /root/module-signing/MOK.priv /root/module-signing/MOK.der /lib/modules/$(uname -r)/misc/vmmon.ko
sudo /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 \
  /root/module-signing/MOK.priv /root/module-signing/MOK.der /lib/modules/$(uname -r)/misc/vmnet.ko

sudo modprobe vmmon vmnet
sudo systemctl start vmware
```

## Bugs

There will be bugs so please file a report when you find them.

## Support

<a href="https://www.buymeacoffee.com/reuteras" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>

  [pai]: https://www.packer.io/downloads
  [just]: https://github.com/casey/just
  [pbe]: https://www.vgemba.net/vmware/Packer-Workstation-Error
