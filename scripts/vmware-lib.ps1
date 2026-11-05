# Shared helpers for building VMware Workstation VMs on Windows.
# Dot-sourced by build-vm.ps1. Configuration lives in ../defaults.ps1.

$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "../defaults.ps1")

function Invoke-Native {
    # Run a native command and stop if it fails (PowerShell does not do this on its own).
    param([string]$Command, [string[]]$Arguments)
    & $Command @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "'$Command $($Arguments -join ' ')' failed with exit code $LASTEXITCODE"
    }
}

function Get-VmxPath($VmDirName) {
    return Join-Path $VM_DIR "$VmDirName/$VmDirName.vmx"
}

function Invoke-Vmrun {
    param([string[]]$Arguments)
    Invoke-Native "vmrun.exe" (@("-T", "ws") + $Arguments)
}

function Enable-SharedFolders($VmDirName) {
    Invoke-Vmrun @("enableSharedFolders", (Get-VmxPath $VmDirName))
}

function Add-SharedFolder($VmDirName, $ShareName, $SharePath, $State) {
    $vmx = Get-VmxPath $VmDirName
    Invoke-Vmrun @("addSharedFolder", $vmx, $ShareName, $SharePath)
    Invoke-Vmrun @("setSharedFolderState", $vmx, $ShareName, $SharePath, $State)
}

function Start-BuiltVM($VmDirName) {
    $vmx = Get-VmxPath $VmDirName
    Invoke-Vmrun @("start", $vmx, "nogui")
    # Waits until the guest has an IP address, i.e. is running
    Invoke-Vmrun @("getGuestIPAddress", $vmx, "-wait")
}

function Stop-BuiltVM($VmDirName) {
    $vmx = Get-VmxPath $VmDirName
    Invoke-Vmrun @("stop", $vmx)
    # Replace the Installed snapshot with a Secure one
    try { Invoke-Vmrun @("deleteSnapshot", $vmx, "Installed") } catch { Write-Host "No Installed snapshot to delete." }
    Invoke-Vmrun @("snapshot", $vmx, "Secure")
}
