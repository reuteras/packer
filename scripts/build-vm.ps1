# Build a VM with packer + VMware Workstation, move it to $VM_DIR and set up shared folders.
# Run from a packer-* folder (the just recipes do this), e.g.:
#   pwsh -File ../scripts/build-vm.ps1 -Base debian -Conf debian -VmDirName Debian_64-bit
param(
    [Parameter(Mandatory)][string]$Base,       # variables-<Base>.pkr.hcl
    [Parameter(Mandatory)][string]$Conf,       # folder and <Conf>.pkr.hcl
    [Parameter(Mandatory)][string]$VmDirName   # vm_name in the packer template
)

. (Join-Path $PSScriptRoot "vmware-lib.ps1")

$target = Join-Path $VM_DIR $VmDirName
if (Test-Path $target) {
    throw "Directory for VM exists ($target). Remove it and rerun."
}
if (-not (Test-Path $VM_DIR)) {
    throw "VM directory $VM_DIR does not exist. Create it or edit defaults.ps1."
}

Push-Location $Conf
try {
    Invoke-Native "packer" @("init", "$Conf.pkr.hcl")
    Invoke-Native "packer" @("build", "-force", "-var-file", "../variables-$Base.pkr.hcl", "$Conf.pkr.hcl")
    if (-not (Test-Path $VmDirName)) {
        throw "Packer finished but ./$VmDirName was not created."
    }
    Move-Item "./$VmDirName" $VM_DIR
} finally {
    Pop-Location
}

Start-BuiltVM $VmDirName
Enable-SharedFolders $VmDirName
Add-SharedFolder $VmDirName $SHARED_RO_NAME $SHARED_RO_PATH "readonly"
Add-SharedFolder $VmDirName $SHARED_RW_NAME $SHARED_RW_PATH "writable"
Stop-BuiltVM $VmDirName

Write-Host "Built $target" -ForegroundColor Green
& vmware.exe -q -t (Get-VmxPath $VmDirName)
