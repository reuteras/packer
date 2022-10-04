# Default location for virtual machines
# Change the values below for your environment. You have to create the directories.

# Name and location of readonly folder to mount in VM
$SHARED_RO_NAME = "ro"
$SHARED_RO_PATH = "D:\Shared\ro"

# Name and location of writable folder to mount in VM
$SHARED_RW_NAME = "rw"
$SHARED_RW_PATH = "D:\Shared\rw"

# Folder to store VMs in after they are created
$VM_DIR = "D:\Virtual Machines"

# --- No need to edit below --- #

# Defaults for shared cache for Packer.
$env:PACKER_CACHE_DIR = "../packer_cache"

# Functions
function Create-VirtualMachine($BASE, $CONF_NAME, $VM_DIR_NAME){
    Set-Location $CONF_NAME
    
    packer build -force -var-file ../variables-$BASE.pkr.hcl ./$CONF_NAME.pkr.hcl
    Start-Sleep -s 2
    
    if (-not (Test-Path $VM_DIR/$VM_DIR_NAME)){
        Move-Item ./$VM_DIR_NAME $VM_DIR
        Start-Sleep -s 2
    }
    
    if (Test-Path ./shared.ps1) {
        ./shared.ps1
    }
    
    Set-Location ..
    vmware.exe -q -t $VM_DIR/$VM_DIR_NAME/$VM_DIR_NAME.vmx
}

function Enable-SharedFolders($VM_DIR_NAME){
    vmrun.exe enableSharedFolders $VM_DIR/$VM_DIR_NAME/$VM_DIR_NAME.vmx
}

function Add-SharedFolder($VM_DIR_NAME, $SHARE_NAME, $SHARE_PATH, $SHARED_STATE){
    vmrun.exe addSharedFolder $VM_DIR/$VM_DIR_NAME/$VM_DIR_NAME.vmx $SHARE_NAME $SHARE_PATH
    vmrun.exe setSharedFolderState $VM_DIR/$VM_DIR_NAME/$VM_DIR_NAME.vmx $SHARE_NAME $SHARE_PATH $SHARED_STATE
}

function Start-VM($VM_DIR_NAME){
    vmrun.exe start $VM_DIR/$VM_DIR_NAME/$VM_DIR_NAME.vmx
    
    # Wait until running
    vmrun.exe getGuestIPAddress $VM_DIR/$VM_DIR_NAME/$VM_DIR_NAME.vmx
    Start-Sleep -s 2
}

function Stop-VM($VM_DIR_NAME){
    vmrun.exe stop $VM_DIR/$VM_DIR_NAME/$VM_DIR_NAME.vmx
    vmrun.exe deleteSnapshot $VM_DIR/$VM_DIR_NAME/$VM_DIR_NAME.vmx Installed
    vmrun.exe snapshot $VM_DIR/$VM_DIR_NAME/$VM_DIR_NAME.vmx Secure
}