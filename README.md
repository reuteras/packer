# Packer

This repo contains scripts and configuration to build virtual machines on macOS and Windows with the help of packer and VMware. At the moment I don't have a macOS machine with an Intel processor so those scripts are not tested. Since VMware Fusion for arm is in beta no real effort is made to support that platform.

## Instructions on Windows

To get started install VMware Workstation, [packer][pai] and git. My recommendation is to install git with the command **winget**. Run the following in a Windows Terminal:

    winget install Git.Git

You have to add *C:\Program Files\Git\bin* to the Path environment variable. Also make sure that you have VMware in the path, *C:\Program Files (x86)\VMware\VMware Workstation*.

Then start a new terminal and change to folder where you like to check out the repo. Then use git to check it out and configure some defaults.

    git clone https://github.com/reuteras/packer.git
    cd packer
    # Open and configure the default values
    <editor> defaults.ps1

To build a VM use **cd** to change to the folder for base image you would like to use. The following are available for Windows

- packer-centos
- packer-kali
- packer-ubuntu

### CentOS

- centos-7 - CentOS 7 - build with **./build-centos-7.ps1**
- centos-8-stream - CentOS 8 Stream - build with **./build-centos-8-stream.ps1**

### Kali

- kali - my repo [kali-tools][kat] is used to do a very basic installation of [Kali][kal] - build with **./build-kali.ps1**

### Images based on Ubuntu

Configuration for the images based on Ubuntu 20.04 is done in *variables-ubuntu-2004.pkr.hcl* for images based on Ubuntu 20.04 LTS.

Images based on Ubuntu 20.04.

- Ubuntu 20.04 default - build with **./build-ubuntu-2004.ps1**
- [REMnux][rem] installed via my repo [remnux-tools][ret] - build with **./build-remnux.ps1**
- [SIFT][sif] installed via my repo [remnux-tools][ret] - build with **./build-sift.ps1**

Configuration for the images based on Ubuntu 22.04 is done in *variables-ubuntu-2204.pkr.hcl* for images based on Ubuntu 22.04 LTS.

Images based on Ubuntu 22.04.

- Ubuntu 22.04 default - build with **./build-ubuntu-2204.ps1**
- Malcolm - Malcolm is not installed but my repo [malir][mal] is added to help with the installation - build with **./build-malcolm.ps1**

## Instructions on macOS

### CentOS

- centos-7 - CentOS 7
- centos-8 - CentOS 8

### Debian

Available in the subdirectory **packer-debian** and has two make targets:

- debian - debian.json - install a basic [Debian][deb] host.

### Fedora

- fedora-34 - Fedora 34

### Kali

- kali - kali.json - my script [kali-tools][kat] to do a very basic install of [Kali][kal].

### Ubuntu

Available in **packer-ubuntu** and has three targets:

- remnux
- sift
- ubuntu

### Windows

[Windows 10][w10] and [server][wse].

- Windows 10

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
  [sif]: https://digital-forensics.sans.org/community/downloads/
  [w10]: https://www.microsoft.com/en-us/windows
  [wse]: https://www.microsoft.com/en-us/cloud-platform/windows-server
